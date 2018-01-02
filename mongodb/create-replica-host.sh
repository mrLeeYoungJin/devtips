copyFilesToContainer() {
  echo '... copying files to container >>>> '$1' ...'

  # copy necessary files
  docker cp ./admin.js $1:/data/admin/
  docker cp ./replica.js $1:/data/admin/
  docker cp ./mongo-keyfile $1:/data/keyfile/
}

# @params container volume
configMongoContainer() {
  echo '.. configuring container >>>> '$1' ..'

  # start container
  docker run --name $1 -v $2:/data -d gwee/mongo --smallfiles

  # create the folders necessary for the container
  docker exec -i $1 bash -c 'mkdir /data/keyfile /data/admin'

  # copy the necessary files to the container
  copyFilesToContainer $1

  # change folder owner to the current container user
  docker exec -i $1 bash -c 'chown -R mongodb:mongodb /data'
}

# @params container volume
removeAndCreateContainer() {
  echo '.. removing container >>>> '$1' ..'

  # remove container
  docker rm -f $1

  keyfile='mongo-keyfile'
  port='27017:27017'
  rs='rs1'

  echo '.. recreating container >>>> '$1' ..'

  #create container with sercurity and replica configuration
  docker run --restart=unless-stopped --name $1 --hostname $1 \
  -v $2:/data \
  -port $port \
  -d gwee/mongo --smallfiles \
  --keyFile /data/keyfile/$keyfile \
  --replSet $rs \
  --storageEngine wiredTiger
}

# @params server container volume
createMongoDBNode() {
  # switch to corresponding server
  #switchToServer $1

  echo '.. creating container >>>> '$2' ...'

  # start configuration of the container
  configMongoContainer $2 $3

  sleep 2

  #create container with sercurity and replica configuration
  removeAndCreateContainer $2 $3

  echo '...............................'
  echo '.  CONTAINER '$1' CREATED ..'
  echo '...............................'
}

createKeyFile() {
  openssl rand -base64 756 > $1
  chmod 600 $1
}

init_replica_set() {
  docker exec -i $1 bash -c 'mongo < /data/admin/replica.js'
  sleep 2
  docker exec -i $1 bash -c 'mongo < /data/admin/admin.js'
  #cmd='mongo -u $MONGO_REPLICA_ADMIN -p $MONGO_PASS_REPLICA --eval "rs.status()" --authenticationDatabase "admin"'
  #sleep 2
  #docker exec -i $1 bash -c "$cmd"
}

init_mongo_primary() {
  # @params name-of-keyfile
  createKeyFile mongo-keyfile
  # @params server container volume
  createMongoDBNode $1 $2 $3

  sleep 3

  init_replica_set $2

  echo '.....................................'
  echo '.. REPLICA SET READY TO ADD NODES ...'
  echo '.....................................'
}

init_mongo_secondaries() {
  # @Params server container volume
  createMongoDBNode  $1 $2 $3
}


# $1 : primary, secondary1
# $2 : docker container name
# $3 : volume
main() {
  if [[ ($1 == 'primary') ]]; then
    init_mongo_primary $1 $2 $3
  elif [[ $1 == 'secondary' ]]; then
    init_mongo_secondaries $1 $2 $3
  fi
}

main $1 $2 $3

CONF_PATH=/var/data/influxdb
DATA_PATH=/var/data/influxdb/data
BIND_PORT=8086:8086
INIT_DATABASE='corning'


createInfluxdbConfFile() {
  docker run --rm influxdb:1.4.2 influxd config > $CONF_PATH/influxdb.conf
}

changeInfluxHttpAuth() {
  sed -i "s/auth-enabled = false/auth-enabled = true/g" $CONF_PATH/influxdb.conf
}

createInfluxdbRun() {
  docker run -d --name $1 -v $CONF_PATH/influxdb.conf:/etc/influxdb/influxdb.conf:ro -v $DATA_PATH:/var/lib/influxdb -p $BIND_PORT influxdb:1.4.2 -config /etc/influxdb/influxdb.conf
}

createDatabase() {
  docker exec -it $1 sh -c 'influx -execute "CREATE DATABASE '$INIT_DATABASE'"'
}

init_influxdb_node() {
  createInfluxdbConfFile

  sleep 2

  #changeInfluxHttpAuth

  createInfluxdbRun $1

  sleep 3

  if [[${2^^} == 'Y']]; then
    createDatabase $1
  fi

  echo '.....................................'
  echo '......... CREATE INFLUXDB ...........'
  echo '.....................................'
}

# $1 : node, relay
# $2 : docker container name
# $3 : create database y/n
main() {
  if [[ ($1 == 'node') ]]; then
    init_influxdb_node $2 $3
  fi
}

if [[ ($1 == "--h") || ($1 == "--help") ]] ; then
    echo ".............................."
    echo "param 1 is node or relay"
    echo "param 2 is container name"
    echo "param 3 is create database y/n"
    echo ".............................."
    exit 0
fi

main $1 $2 $3

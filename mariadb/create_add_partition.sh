#!/bin/bash

PARITION_TABLES=( T_PCS_ANALOG_VALUE T_BATTERY_ANALOG_VALUE T_PCS_UNIT T_BATTERY_UNIT )
YEAR=`date "+%Y"`
MONTH=`date "+%m"`

function checkLastPartitionInfo() {
  local tablename=$1
  local query=" SELECT PARTITION_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = '${tablename}' order by partition_description desc LIMIT 1; "

  last_part=$(mysql -upms -ppms pmsdb -N -s -e " ${query} " )

  if [ ${lastpart} != p${pre_year}12 ]; then
    echo "Last PartitionName is not p${pre_year}12"
    exit 0
  fi
}

function addPartition() {
  local parition_months=( )

  local year=$1
  local month
  local pre_year=$((${year}-1))

  for i in {1..12}
  do
    month=${i}
    if [ ${month} -lt 10 ]; then
      month="0"${i}
      parition_months[${i}]=" PARTITION p${year}${month} VALUES LESS THAN (TO_DAYS('${year}-${month}-01')) ENGINE = InnoDB, \n "
    elif [ ${month} = 12 ]; then
      parition_months[${i}]=" PARTITION p${year}${month} VALUES LESS THAN MAXVALUE ENGINE = InnoDB \n "
    else
      parition_months[${i}]=" PARTITION p${year}${month} VALUES LESS THAN (TO_DAYS('${year}-${month}-01')) ENGINE = InnoDB, \n "
    fi

    #echo -e ${parition_months[${i}]}
  done

  for value in "${PARITION_TABLES[@]}"; do
    local tempQuery=" ALTER TABLE ${value} REORGANIZE PARTITION p${pre_year}12 INTO ( \n "
    tempQuery+=${parition_months[@]}
    tempQuery+=" \"); \n "

    echo -e "query:"${tempQuery}
  done
}

function alterPartition() {
  if [ $MONTH != "01" ]; then
    echo "Month is not Jan!"
    exit 0
  fi

  addPartition ${YEAR}
}


checkLastPartitionInfo
alterPartition

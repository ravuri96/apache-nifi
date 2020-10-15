#!/bin/sh -e

prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}

nifi_bootstrap_file=${NIFI_HOME}/conf/bootstrap.conf
nifi_props_file=${NIFI_HOME}/conf/nifi.properties

if [ ! -z "${NIFI_JVM_HEAP_INIT}" ]; then
    prop_replace 'java.arg.2'       "-Xms${NIFI_JVM_HEAP_INIT}" ${nifi_bootstrap_file}
fi

if [ ! -z "${NIFI_JVM_HEAP_MAX}" ]; then
    prop_replace 'java.arg.3'       "-Xmx${NIFI_JVM_HEAP_MAX}" ${nifi_bootstrap_file}
fi
prop_replace 'nifi.flow.configuration.file' './data/flow.xml.gz' ${nifi_props_file}


"../scripts/start.sh"
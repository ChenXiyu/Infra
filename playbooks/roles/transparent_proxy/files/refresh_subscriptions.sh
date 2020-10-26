#!/bin/bash -x
set -ue
set -o pipefail

function restart_v2ray {
  /bin/systemctl restart v2ray
}

function roll_back {
  mv ${v2ray_config_path}.back ${v2ray_config_path}
  restart_v2ray
}

function assert_active {
  sleep 10
  if [ "$(/bin/systemctl is-active v2ray)" != 'active' ]
  then
    roll_back
    # TODO notify
  fi
}

trap 'assert_active' ERR

v2ray_config_path='/usr/local/etc/v2ray/config.json'

# Back the origin config
cp ${v2ray_config_path} ${v2ray_config_path}.back

/usr/bin/docker run --rm -it --network host 94xychen/sub2conf:latest "$1" > ${v2ray_config_path}

restart_v2ray

assert_active

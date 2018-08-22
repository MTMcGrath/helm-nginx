#!/usr/bin/env bash

help_msg(){ echo -e '
Usage: ./orchestrate.sh <option> 

Arguments:
  -h, --help   help menu
  -run --run'
}

bomb_out(){
  echo "ERROR incorrect usage"
  help_msg
  exit 1
}

run_command(){
  helm upgrade --force helm-nginx . --set service.type=NodePort 2>/dev/null 
  if [ $? -ge 1 ]; then
      helm install --name helm-nginx . --set service.type=NodePort
  fi 
}
case "$1" in
  -h | --help | help)
    help_msg
  ;;
  -run| --run)
    shift
    run_command "$@"
  ;;
  *)
    bomb_out
  ;;
esac


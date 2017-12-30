#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 12/28/2017
#
# Script Name: config_bastion_host.sh
#
# Description: Set up and start puppet master
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile

function usage {

        echo "Usage: $0 [options], where options are:"
        echo "  -h              print help and exit"
        echo "  -t              terraform all"
        echo "  -x              destroy all" 

} # //usage

function prechecks {

  TF=`cat ~/.bashrc | grep TF_VAR | cut -d'=' -f1`
  if [ ! -z "$TF" ] ; then
    #echo "${TF}"
    echo "Found proper digital ocean setup."
  else
    echo "Digial Ocean TF_VARS not found in .bashrc!"
    echo "Digital Ocean provisioning won't work right."
    echo ""
    echo "Be sure these are added to the end of .bashrc:"
    echo "" 
    echo "export TF_VAR_do_token="
    echo "export TF_VAR_pub_key="
    echo "export TF_VAR_pvt_key="
    echo "export TF_VAR_ssh_fingerprint="
  fi


  if [ ! -f /usr/local/bin/terraform ] ; then
    echo "Please install Terraform locally"
    exit 1
  fi

} # //prechecks

function terraform_it {

  # We import this so we don't destroy the existing DNS setup.
  terraform import digitalocean_domain.default bitsmasher.net

  # now let's do some planning
  terraform plan -out plan

  #  make it so
  terraform apply "plan"

} # //terraform_it

function destroy_all {
  return 0
} # //destroy_all

function main {

  # execute environment checks
  prechecks

  while getopts "htx" OPTION; do
    case $OPTION in 
      h)
        usage
        exit 0
        ;;
      t)
        terraform_it
        ;;
      x)
        destroy_all
        ;;
      *)
        usage
        exit 1
        ;;
    esac
  done

} # //main

if [ "$#" -lt 1 ]
then
  echo "Please choose a course of action" 
  usage
  exit 1
fi

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi


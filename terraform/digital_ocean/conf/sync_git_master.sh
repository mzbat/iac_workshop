#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 10/13/2017
#
# Script Name: config.sh
#
# Description: Set up and start puppet master
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile
#

function usage {

  echo " " 
  echo "Usage: $0 [options], where options are:"
  echo "  -h              print help and exit"
  echo "  -a              sync all environments"
  echo "  -b              pull a specific branch, sync all environments"
  echo "  -d              sync dev environment" 
  echo "  -p              sync prod environment"
  echo "  -w              sync workshop environment"
  echo " "

} # //usage

function remove_stale {

  if [ -d "/tmp/iac_workshop.old" ]
  then 
    rm -rf /tmp/iac_workshop.old
  fi 

  if [ -d "/tmp/iac_workshop" ] 
  then 
    mv /tmp/iac_workshop /tmp/iac_workshop.old
    echo "Renaming stale repo directory in /tmp."
  fi
  return 0

} # //remove_stale

function pull_from_git () {

  BRANCH=$1
  # copy in the latest from the repo
  cd /tmp && \
  # change this to mzbat repo after building class
  git clone https://github.com/theDevilsVoice/iac_workshop.git --branch ${BRANCH}
  return 0

} # //pull_from_git

function sync_dev {

  if [ -d "/tmp/iac_workshop/puppetlabs/code/environments/development" ] ;
  then
    cp -Rp /tmp/iac_workshop/puppetlabs/code/environments/development \
      /etc/puppetlabs/code/environments/
  else 
    echo "Unable to find development dir, skipping"
    return 1
  fi
  return 0

} # //sync_dev

function sync_prod {

  if [ -d "/tmp/iac_workshop/puppetlabs/code/environments/production" ] ;
  then
    cp -Rp /tmp/iac_workshop/puppetlabs/code/environments/production \
      /etc/puppetlabs/code/environments/
  else 
    echo "Unable to find production dir, skipping"
    return 1
  fi
  return 0

} # //sync_prod

function sync_workshop {

  if [ -d "/tmp/iac_workshop/puppetlabs/code/environments/workshop" ] ;
  then
    cp -Rp /tmp/iac_workshop/puppetlabs/code/environments/workshop \
      /etc/puppetlabs/code/environments/
  else 
    echo "Unable to find workshop dir, skipping"
    return 1
  fi
  return 0

} # //sync_workshop

function main {

  BRANCH="master"

  # push the old one out of the way. 
  remove_stale 

  while getopts "hab:dpw" OPTION; do
    case $OPTION in 
      h)
        usage
        exit 0
        ;;
      a|b)
        # They specified a branch, make sure it's there
        if [ ${OPTION} == "b" ]
        then
          if [ ! -z "$(git ls-remote --heads https://github.com/theDevilsVoice/iac_workshop.git ${BRANCH})" ]
          then 
            echo " "
            echo "No such branch \"${BRANCH}\" in the repo, sorry friend. "
            usage
            exit 1
          else 
            BRANCH=$OPTARG
          fi
        fi   
        # get the latest
        pull_from_git ${BRANCH}
        # copy the dirs into place
        sync_dev
        sync_prod
        sync_workshop
        exit 0
        ;;
      d)
        pull_from_git ${BRANCH}
        sync_dev
        exit 0
        ;;
      p)
        pull_from_git ${BRANCH}
        sync_prod
        exit 0
        ;;
      w) 
        pull_from_git ${BRANCH}
        sync_workshop
        exit 0
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

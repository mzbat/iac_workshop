#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 10/13/2017
#
# Script Name: config.sh
#
# Description: Use this shell script to ensure your system
#              is ready for the class.
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile
#

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#################
# Error Counter #
#################
ERROR_COUNTER=0

usage() {
cat <<- EOF
  usage: $PROGNAME options


  OPTIONS:
    -t --test                run unit test to check the program
    -v --verbose             Verbose. You can specify more then one -v to have more verbose
    -x --debug               debug
    -h --help                show this help
       --help-config         configuration help
EOF
}

cmdline() {
    # got this idea from here:
    # http://kirk.webfinish.com/2009/10/bash-shell-script-to-use-getopts-with-gnu-style-long-positional-parameters/
    local arg=
    for arg
    do
        local delim=""
        case "$arg" in
            #translate --gnu-long-options to -g (short options)
            --config)         args="${args}-c ";;
            --pretend)        args="${args}-n ";;
            --test)           args="${args}-t ";;
            --help-config)    usage_config && exit 0;;
            --help)           args="${args}-h ";;
            --verbose)        args="${args}-v ";;
            --debug)          args="${args}-x ";;
            #pass through anything else
            *) [[ "${arg:0:1}" == "-" ]] || delim="\""
                args="${args}${delim}${arg}${delim} ";;
        esac
    done

    #Reset the positional parameters to the short options
    eval set -- $args

    while getopts "nvhxt:c:" OPTION
    do
         case $OPTION in
         v)
             readonly VERBOSE=1
             ;;
         h)
             usage
             exit 0
             ;;
         x)
             readonly DEBUG='-x'
             set -x
             ;;
         t)
             RUN_TESTS=$OPTARG
             verbose VINFO "Running tests"
             ;;
         c)
             readonly CONFIG_FILE=$OPTARG
             ;;
         n)
             readonly PRETEND=1
             ;;
        esac
    done

    if [[ $recursive_testing || -z $RUN_TESTS ]]; then
        [[ ! -f $CONFIG_FILE ]] \
            && exit "You must provide --config file"
    fi
    return 0
}

###################################
# Check if terraform is installed #
###################################
function check_terraform {
  echo -e "${LPURP}***** Check terraform setup *****${NC}"
  if [ -e "/usr/local/bin/terraform" ] ; then
    echo -e "${CYAN}"
    terraform version
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Terraform not found in /usr/local/bin is it somewhere else?"
    echo "Instructions to install terraform: "
    echo "https://www.terraform.io/intro/getting-started/install.html"
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  fi
}

#############################
# Confirm AWS configuration #
#############################
function check_aws {
  echo -e "${LPURP}***** Confirm AWS Configuration *****"
  if [ -f ~/.aws/credentials ] ; then
    echo -e "${YELLOW}"
    echo "No ~/.aws/credentials found!"
    echo "Follow the steps at: http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html"
    echo ""
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  else 
    echo -e "${CYAN}"
    aws --version
    echo "AWS Configuration looking good..."
    echo -e "${NC}"
  fi
} 

####################
# Check for tfvars #
####################
function check_terra_config {
  echo -e "${LPURP}***** Check  for terraform.tfvars file *****${NC}"
  if [ ! -f ${PWD}/terraform/aws/terraform.tfvars ] ; then
    echo -e "${YELLOW}"
    echo "${PWD}/terraform/aws/terraform.tfvars not found!"
    echo "Amazon AWS won't work right."
    echo "The file should have two lines."
    echo ""
    echo "Example:"
    echo ""
    echo "aws_access_key = \"KLJAHSDFKJASHDLKJASHD\""
    echo "aws_secret_key = \"ljasdfjlkjasdflkjasdflkajd98345\""
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  else 
    echo -e "${CYAN}"
    echo "Found tfvars file in ${PWD}/terraform/aws/terraform.tfvars"
    echo -e "${NC}"
  fi
}

#################################
# Confirm digital ocean TF_VARS #
#################################
function check_do_vars {
  echo -e "${LPURP}***** Check TF_VARS for Digital Ocean *****${NC}"
  TF=`cat ~/.bashrc | grep TF_VAR | cut -d'=' -f1`
  if [ -z "$TF" ] ; then
    echo -e "${CYAN}"
    echo "Found properly formatted DigitalOcean credentials"
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Digial Ocean TF_VARS not found in .bashrc!"
    echo "Digital Ocean provisioning won't work right."
    echo ""
    echo "Be sure these are added to the end of .bashrc:"
    echo "" 
    echo "export TF_VAR_do_token="
    echo "export TF_VAR_pub_key="
    echo "export TF_VAR_pvt_key="
    echo "export TF_VAR_ssh_fingerprint="
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  fi
}

#########################
# Check for puppet-lint #
#########################
function check_puppet_lint {
  echo -e "${LPURP}***** Check if puppet-lint is installed *****${NC}"
  PL="$(gem list -i '^puppet-lint$')"
  if [ ! "$PL" ] ; then
    echo -e "${YELLOW}"
    echo "Could not find puppet-lint installed on this host"
    echo "Get it from http://puppet-lint.com/"
    echo -e "${NC}"
    # This isn't really a showstopper so not counting as an error
    #ERROR_COUNTER=$((ERROR_COUNTER+1))
  fi
} 

#########################
# Print the ERROR_COUNT #
#########################
function show_summary {
  if [[ "$ERROR_COUNTER" -gt 0 ]] ; then
    echo -e "${LRED}"
    echo "Oh no, $ERROR_COUNTER errors found."
    echo "Please correct the errors and run this script again."
    echo -e "${NC}"
  else
    echo -e "${LGREEN}"
    echo "No errors. All clean and green."
    echo -e "${NC}"
  fi
}

function main {

  check_terraform 
  check_aws
  check_terra_config 
  check_do_vars
  show_summary

}

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi

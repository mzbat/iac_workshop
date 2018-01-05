#!/bin/bash

# incorporate this into config.sh script

# verify pyuthon 2.7 is installed
python -V

# verify we have wget

# wget the file
#cd /tmp && wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-183.0.0-linux-x86_64.tar.gz
#cd /tmp && gzip -d /tmp/google-cloud-sdk-*.tar.gz
#cd /tmp && tar -xf /tmp/google-cloud-sdk-*.tar
#cd /tmp/google-cloud-sdk
#yes | /tmp/google-cloud-sdk/install.sh
mv /tmp/google-cloud-sdk /opt
#yes | /opt/google-cloud-sdk/bin/gcloud init --console-only 
# add /opt/google-cloud-sdk/bin to $PATH
#if [ -d "/opt/google-cloud-sdk/bin" ] ; then
#    PATH="$PATH:/opt/google-cloud-sdk/bin"
#fi

###############
# fix .bashrc #
###############
if grep -Fq "export TF_VAR_org_id="  ~/.bashrc
then
  # code if found
else
  # code if not found
  echo "export TF_VAR_org_id=YOUR_ORG_ID" >> ~/.bashrc
fi
if grep -Fq "export TF_VAR_billing_account="  ~/.bashrc
then
  # code if found
else
  echo "export TF_VAR_billing_account=YOUR_BILLING_ACCOUNT_ID" >> ~/.bashrc
fi
if grep -Fq "export TF_ADMIN=" ~/.bashrc
then
  # code if found
else
  echo "export TF_ADMIN=${USER}-terraform-admin" >> ~/.bashrc
fi
if grep -Fxq "export TF_CREDS=~/.config/gcloud/terraform-admin.json"  ~/.bashrc
then
  # code if found
else
  echo "export TF_CREDS=~/.config/gcloud/terraform-admin.json" >> ~/.bashrc
fi 

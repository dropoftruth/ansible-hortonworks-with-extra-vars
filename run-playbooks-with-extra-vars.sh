#!/bin/bash


virtualenv ~/ansible; source ~/ansible/bin/activate

export FILENAME=`basename $1`

export CLOUD_TO_USE=aws
export OUTPUT=../output-yaml-files-$FILENAME
export EXTRA_VARS_AWS=@config/aws-cluster.yml
export EXTRA_VARS_HDP=@config/$FILENAME

rm -rf $OUTPUT
mkdir $OUTPUT

# clone repository
ansible-playbook -v git-playbook/clone-hdp-repo.yml > $OUTPUT/clone-hdp-repo.yml

#cd ./ansible-hortonworks/

#0
# set_cloud.sh
. set_cloud.sh

#1
# prepare_cloud.sh
ansible-playbook -v --connection=local "ansible-hortonworks/playbooks/clouds/build_${cloud_to_use}.yml" --extra-vars="$EXTRA_VARS_AWS" --extra-vars="$EXTRA_VARS_HDP" > $OUTPUT/prepare_cloud.out

#2
# prepare_nodes.sh
ansible-playbook -v -i "inventory/${cloud_to_use}" -e "cloud_name=${cloud_to_use}" ansible-hortonworks/playbooks/prepare_nodes.yml --extra-vars="$EXTRA_VARS_AWS" --extra-vars="$EXTRA_VARS_HDP" > $OUTPUT/prepare_nodes.out

#3
# install_ambari.sh
ansible-playbook -v -i "inventory/${cloud_to_use}" -e "cloud_name=${cloud_to_use}" ansible-hortonworks/playbooks/install_ambari.yml --extra-vars="$EXTRA_VARS_AWS" --extra-vars="$EXTRA_VARS_HDP" > $OUTPUT/install_ambari.out

#4
# configure_ambari.sh
ansible-playbook -v -i "inventory/${cloud_to_use}" -e "cloud_name=${cloud_to_use}" ansible-hortonworks/playbooks/configure_ambari.yml --extra-vars="$EXTRA_VARS_AWS" --extra-vars="$EXTRA_VARS_HDP" > $OUTPUT/configure_ambari.out

#5
# apply_blueprint.sh
ansible-playbook -v -i "inventory/${cloud_to_use}" -e "cloud_name=${cloud_to_use}" ansible-hortonworks/playbooks/apply_blueprint.yml --extra-vars="$EXTRA_VARS_AWS" --extra-vars="$EXTRA_VARS_HDP" > $OUTPUT/apply_blueprint.out

deactivate

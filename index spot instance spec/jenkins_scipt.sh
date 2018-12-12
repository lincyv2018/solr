#!/bin/bash
ls -ltr
echo -e "\e[31m \e[1m Config Updateing process for \"index spot instance spec\" started \e[0m"
echo -e "\e[34m ==========================================================\e[0m"
cp -rf ./Orginals/* ./index\ spot\ instance\ spec/
cd ./index\ spot\ instance\ spec/
echo -e "\e[31m \e[1m Replacing the userdata Docker Image with ${DOCKER_IMAGE} \e[0m"
echo "=========================================================="
sed -i 's,DOCKER_IMAGE,'"${DOCKER_IMAGE}"',g' UserData.sh
echo -e "\e[31m \e[1m Replacing the userdata PROD Server IP with ${PROD_IP} \e[0m"
echo "=========================================================="
sed -i 's,PROD_IP,'"${PROD_IP}"',g' UserData.sh
echo -e "\e[31m \e[1m Replacing the userdata DR Server IP with ${DR_IP} \e[0m"
echo "=========================================================="
sed -i 's,DR_IP,'"${DR_IP}"',g' UserData.sh
echo -e "\e[31m \e[1m Replacing the userdata DR Server IP with ${STAGING_IP} \e[0m"
echo "=========================================================="
sed -i 's,STAGING_IP,'"${STAGING_IP}"',g' UserData.sh
echo -e "\e[31m \e[1m Encoding the Userdata \e[0m"
crypt=$(base64 --wrap=0 ./UserData.sh)
echo -e "=========================================================="
echo -e "\e[31m \e[1m Replacing the Instance spec for spot instance \e[0m"
echo -e "\e[34m ==========================================================\e[0m"
echo -e "\e[31m \e[1m Adding the Image ID \e[0m"
sed -i 's,IMAGE_ID,'"${Image_Id}"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Adding the Encoded Userdata to instance Spec \e[0m"
sed -i 's,USER_DATA,'"$crypt"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Adding the Instance Type to instance Spec \e[0m"
sed -i 's,INSTANCE_TYPE,'"${Inst_type}"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Adding the Zone to instance Spec \e[0m"
sed -i 's,AVZONE,'"${AZ}"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Adding the Subnet to instance Spec \e[0m"
sed -i 's,SUB_NET,'"${sub_net}"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Adding the spot Security Group to instance Spec \e[0m"
sed -i 's,SPOT_SG,'"${spot_sg}"',g' spot-instance-spec.json
echo -e "=========================================================="
echo -e "\e[31m \e[1m Userdata \e[0m"
cat UserData.sh
echo -e "\e[31m \e[1m Encoded Userdata \e[0m"
echo $crypt
echo -e "\e[31m \e[1m Instances Spec \e[0m"
cat spot-instance-spec.json
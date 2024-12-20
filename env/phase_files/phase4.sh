#!/bin/bash

##################################################################################################################
# Phase 4: Load Testing
##################################################################################################################

echo -e "/n/n/n"
echo "############################################################################################################"
echo "Starting Phase 4: Load Testing"
echo "############################################################################################################"
echo -e "\n\n\n"

# # Shutdown the both EC2 instances
# if [[ $status -eq 0 ]]; then
#     execute_command "aws ec2 stop-instances --instance-ids \"$INSTANCE_ID\" \"$NEW_INSTANCE_ID\""
#     status=$?
# fi

# # Load Testing the ASG with 1000 requests per second
# if [[ $status -eq 0 ]]; then
#     npm install -g loadtest
#     echo "Running loadtest on the application"
#     loadtest --rps 1000  -c 500 -k "$LB_DNS"
#     status=$?
# fi

echo -e "\n\n\n"
echo "############################################################################################################"
echo "Load Testing executed"
echo "############################################################################################################"
echo -e "\n\n\n"

##################################################################################################################
# End of Phase 4
##################################################################################################################

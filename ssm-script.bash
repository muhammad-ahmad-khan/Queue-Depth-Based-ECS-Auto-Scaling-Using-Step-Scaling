#!/usr/bin/env bash

while (($# > 1)); do
  case $1 in
  --profile) PROFILE="$2" ;;
  *) break ;;
  esac
  shift 2
done

echo "Deleting Parameters..."
aws ssm delete-parameter --profile $PROFILE --name "/$PROFILE/services/consumer-service/AWS_REGION"
aws ssm delete-parameter --profile $PROFILE --name "/config/ecs/FARGATE_SCALING_ENV"
aws ssm delete-parameter --profile $PROFILE --name "/config/ecs/consumer-service/QUEUE_DEPTH_SCALE_OUT_ALARM_THRESHOLD"
aws ssm delete-parameter --profile $PROFILE --name "/config/ecs/consumer-service/CPU_UTILIZATION_SCALE_IN_ALARM_THRESHOLD"
aws ssm delete-parameter --profile $PROFILE --name "/config/ecs/consumer-service/CPU_UTILIZATION_NO_COMPUTE_OR_SCALE_IN_ALARM_EVALUATION_PERIODS"
aws ssm delete-parameter --profile $PROFILE --name "/config/ecs/consumer-service/AUTO_SCALING_TARGET_MAX_CAPACITY"

echo "Creating parameters..."
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/'$PROFILE'/services/consumer-service/AWS_REGION", "Value": "us-east-1"}'
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/config/ecs/FARGATE_SCALING_ENV", "Value": "non-prod"}' # valid values are: non-prod or prod
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/config/ecs/consumer-service/QUEUE_DEPTH_SCALE_OUT_ALARM_THRESHOLD", "Value": "10"}' # if you are increasing this then make sure you are also adjusting step scaling criteria
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/config/ecs/consumer-service/CPU_UTILIZATION_SCALE_IN_ALARM_THRESHOLD", "Value": "2"}' # 2% 
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/config/ecs/consumer-service/CPU_UTILIZATION_NO_COMPUTE_OR_SCALE_IN_ALARM_EVALUATION_PERIODS", "Value": "3"}' # do not set this as 1 in non-prod
aws ssm put-parameter --profile $PROFILE --overwrite --cli-input-json '{"Type": "String", "Name": "/config/ecs/consumer-service/AUTO_SCALING_TARGET_MAX_CAPACITY", "Value": "6"}' # put 1 if you want to disable autoscaling at all

# SQS depth based ECS task auto-scaling using step scaling.

SQS depth based ECS task auto-scaling using step scaling.

## Dependencies

- aws cli

### How to execute the solution?

- First create the essential SSM parameters: `bash ssm-script.bash --profile dev`
- Then deploy CloudFormation template using aws cli: 
```
aws cloudformation deploy --template-file template.yml \
    --capabilities CAPABILITY_IAM \
    --stack-name consumer-service \
    --parameter-overrides "DockerImageUrl=DOCKER_IMAGE_URL:VERSION EnvironmentName=dev" \
    --profile dev
```

* See the write up here:
  https://dev.to/muhammad_ahmad_khan/sqs-depth-based-ecs-task-auto-scaling-using-step-scaling-5h4k

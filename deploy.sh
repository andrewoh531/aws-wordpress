docker run --rm \
    -v `pwd`:/cwd \
    -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN \
    -e AWS_DEFAULT_REGION \
    realestate/stackup:latest my-niche-wordpress up -t ./cloudformation-templates/wordpress.yml \
    --override KeyName=sharonohk --override DBPassword=hellomate
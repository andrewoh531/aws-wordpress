
# Should pass in vpc-id and availability zone as 1st and 2nd parameters respectively
get_default_subnet_id () {
   subnetId=`aws ec2 describe-subnets --filters Name=defaultForAz,Values=true Name=vpc-id,Values=$1 Name=availabilityZone,Values=$2 | grep SubnetId | sed s'/.*subnet/subnet/g' | sed 's/\".*//g'`
}

vpcId=`aws ec2 describe-vpcs --filters Name=isDefault,Values=true | grep VpcId | sed s'/.*vpc/vpc/g' | sed 's/\".*//g'`
echo "vpcId=$vpcId"

get_default_subnet_id $vpcId 'ap-southeast-2a'
subnetA=$subnetId
echo "subnetA=$subnetA"

get_default_subnet_id $vpcId 'ap-southeast-2b'
subnetB=$subnetId
echo "subnetB=$subnetB"

get_default_subnet_id $vpcId 'ap-southeast-2c'
subnetC=$subnetId
echo "subnetC=$subnetC"

docker run --rm \
    -v `pwd`:/cwd \
    -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN \
    -e AWS_DEFAULT_REGION \
    realestate/stackup:latest $WORD_PRESS_STACK_NAME up -t ./cloudformation-templates/wordpress.yml \
    --override KeyName=$EC2_KEY_PAIR --override DBPassword=$DB_PASSWORD --override SubnetA=$subnetA \
    --override SubnetB=$subnetB --override SubnetC=$subnetC --override HostedZoneName=$HOSTED_ZONE_NAME


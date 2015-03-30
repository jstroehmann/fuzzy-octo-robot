export aws_access_key='XXXXXXXXXXXXXXXXXXXXXXX'
export aws_secret_key='XXXXXXXXXXXXXXXXXXXXXXX'
/opt/packer/packer build -machine-readable packer/packer.json |tee packer.output
AMI_ID=$(awk '/artifact,0,id/ {print $2}' packer.output)
echo $AMI_ID
aws s3 cp cftemplates/website.template s3://cf-templates-1bpde8xxropa1-us-east-1
aws cloudformation create-stack --stack-name "website$BUILD_NUMBER" --template-url "https://s3.amazonaws.com/cf-templates-1bpde8xxropa1-us-east-1/website.template" --tags '[{"Key":"cf","Value":"true"},{"Key":"app","Value":"jenkins"}]' --parameters '[{"amiID":"$AMI_ID"}]'

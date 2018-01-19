imagename="kevin/hello"

docker build -t ${imagename} .
docker rmi $(docker images -q -f dangling=true)

echo "######################################################################################"
echo "#################################Successed############################################"
echo "Show current docker images:"
docker images

echo "######################################################################################"
echo "#################################Running......########################################"
echo "Application running:"
docker run -ti --rm ${imagename}
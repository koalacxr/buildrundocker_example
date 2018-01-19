# 编译并运行一个比较小的 golang Docker Image [![Build Status](https://travis-ci.org/kevingo/Go-Small-Docker-Image.svg?branch=master)](https://travis-ci.org/kevingo/Go-Small-Docker-Image)

## 第一步编写App项目
package main

import "fmt"

func main() {
	fmt.Println("Hello world!")
}


## 第二步编写Dockerfile文件
FROM golang:alpine AS build-env
ADD . /src
RUN cd /src && go build -o goapp

FROM alpine
WORKDIR /app
COPY --from=build-env /src/goapp /app/
ENTRYPOINT ./goapp

## 第三步执行app_build_run.sh脚本
### 大部分项目只要修改app_build_run.sh脚本中imagename变量就行了
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

# 执行结果如下，只有6MB, 不会大200多MB了
![image](https://github.com/koalacxr/buildrundocker_example/blob/master/demo.jpg)

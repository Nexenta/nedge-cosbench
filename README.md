# nedge-cosbench


	Build Docker Image
1. Create repository clone
2. Build nexenta/cosbench using instructions in nexenta/cosbench/Build.md url: https://github.com/Nexenta/cosbench/blob/master/BUILD.md
3. Copy start.sh to cos folder
4. $ docker build -t nedge-cosbench .
5. $ docker images
6. $ docker tag <Image ID> nexenta/cosbench:latest
7. $ docker login
8. $ docker push nexenta/cosbench

# nedge-cosbench



## Build Docker Image

1. Create repository clone
2. Build nexenta/cosbench using instructions in nexenta/cosbench/Build.md
 url: https://github.com/Nexenta/cosbench/blob/master/BUILD.md
3. Deploy build to cos folder 
4. Copy start.sh to cos folder
5. $ docker build -t nedge-cosbench .
6. $ docker images
7. $ docker tag nedge-cosbench:latest nexenta/cosbench:latest
8. $ docker login
9. $ docker push nexenta/cosbench

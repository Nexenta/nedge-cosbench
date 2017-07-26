#!/bin/bash
# starting drives and controlles

u=0
if [ "$3" = "true" ] || [ "$4" = "true" ]; then
   u=1
fi

if [ $u -eq 0 ]; then
   echo "Setting compressible objects on"
   echo "true" > /cos/compress
fi



if [ $# -eq 0 ] || [ "$2" = "driver" ]; then
echo "Starting only driver"
        ./start-driver.sh


while [ ! -f log/driver-boot.log ]; do
   sleep 10
done

tail -f log/driver-boot.log

exit
fi

if  [ "$2" = "controller" ]; then
echo "Starting only controller"


ips=(`echo $1 | sed 's/,/\n/g'`)

n=${#ips[@]}
echo "$n"
echo " " >> conf/controller.conf
echo "[controller]" > conf/controller.conf
echo "drivers = $n" >> conf/controller.conf
echo "log_level = INFO" >> conf/controller.conf
echo "log_file = log/system.log" >> conf/controller.conf
echo "archive_dir = archive" >> conf/controller.conf
echo " " >> conf/controller.conf
echo " " >> conf/controller.conf

        for (( i=0; i<$n; i++))
do
echo "[driver$(($i+1))]" >> conf/controller.conf
echo "name = driver$(($i+1))" >> conf/controller.conf
echo "url = http://${ips[$i]}:18088/driver" >> conf/controller.conf
echo " " >> conf/controller.conf
echo " " >> conf/controller.conf

done

cat conf/controller.conf

./start-controller.sh

while [ ! -f log/system.log ]; do
   sleep 10
done

tail -f log/system.log


exit
fi

if  [ "$2" = "both" ]; then

n=1
if [ "$3x" != "x" ]; then
n=$3
fi 

echo " " >> conf/controller.conf
echo "[controller]" > conf/controller.conf
echo "drivers = $n" >> conf/controller.conf
echo "log_level = INFO" >> conf/controller.conf
echo "log_file = log/system.log" >> conf/controller.conf
echo "archive_dir = archive" >> conf/controller.conf
echo " " >> conf/controller.conf
echo " " >> conf/controller.conf

	for (( i=1; i<$n+1; i++))
do
echo "[driver$i]" >> conf/controller.conf
echo "name = driver$i" >> conf/controller.conf
echo "url = http://$1:$((18087+$i))/driver" >> conf/controller.conf
echo " " >> conf/controller.conf
echo " " >> conf/controller.conf


	if [ "$i" -eq "1" ];then

 ./start-driver.sh
else
echo " start docker driver port:$((18087+$i))"
docker run -p "$((18087+$i))":18088  nedgecos &

fi
done

cat conf/controller.conf

./start-controller.sh

while [ ! -f log/system.log ]; do
   sleep 10
done

tail -f log/system.log

exit
fi


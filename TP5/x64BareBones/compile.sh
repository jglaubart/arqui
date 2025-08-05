docker start TP5
docker exec -it TP5 make clean -C /root/x64BareBones/Toolchain
docker exec -it TP5 make clean -C /root/x64BareBones
docker exec -it TP5 make -C /root/x64BareBones/Toolchain
docker exec -it TP5 make -C /root/x64BareBones
docker stop TP5
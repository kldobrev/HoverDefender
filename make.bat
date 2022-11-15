F:\Game_Boy_Dev_Tools\gbdk\bin\lcc -IF:\hUGETracker_1_0b9\hUGEDriver\include -Wa-l -Wl-m -Wl-j -Wf-bo1 -c -o bank1.o bank1.c
F:\Game_Boy_Dev_Tools\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -Wf-bo2 -c -o bank2.o bank2.c
F:\Game_Boy_Dev_Tools\gbdk\bin\lcc -IF:\hUGETracker_1_0b9\hUGEDriver\include -Wa-l -Wl-m -Wl-j -Wl-yt1 -Wl-yo8 -o hoverdefender.gb main.c hUGEDriver.obj.o ost\*.c  bank*.o 
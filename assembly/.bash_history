which gcc
ls -a
ls -al
cd root
ls -a
cd ch4
ls -a
gcc -fno-pic -fomit-frame-pointer -o docker_trace trace.c
ls -a
vim .dbginit
vi .dbginit
gdb -q docker_trace 
dnf install gdb
gdb -q docker_trace 
vi /root/.config/dbg/dbginit
mkdir -p /root/.config/dbg
vi /root/.config/dbg/dbginit
dbg -q docker_trace 
gdb -q docker_trace 
ls -a /root/.config
mv /root/.config/dbg /root/.config/gdb
gdb -q docker_trace 
ls -a /root/.config/gdb/
mv /root/.config/gdb/dbginit /root/.config/gdb/gdbinit
gdb -q docker_trace 
exit 
ls -a
cd /root/
ls -a
cd ch4
ls -al
gdb -q docker_trace 
dnf install gdb
gdb -q docker_trace 
gdb docker_trace 
exit 
cd /root/
ls -a
cd ch5
ls -al
mv volatile_add.s va.s && gcc -fno-pic -fomit-frame-pointer -S volatile_add.c
ls -al
cat volatile_add.s
ls -al
cd ..
ls -a
cd ch5
vi .gdbinit
vi volatile_add.s
gcc -fno-pic -fomit-frame-pointer -o volatile volatile_add.c
gdb -q volatile
dnf install gdb
dnf install gdb
gdb -q volatile
vi .gdbinit 
gdb -q volatile
exit 
ls -a
cd /root/
s
ls -a
cd ch6
s
ls -a
gcc -fno-pic -fomit-frame-pointer call.c
ls -a
ln -s ../ch5/.gdbinit ./
ls -al
n .gdbinit 
vim .gdbinit 
vi .gdbinit 
gdb -q a.out 
dnf install gdb
gdb -q a.out 
n .gdbinit 
vi .gdbinit 
gdb -q a.out 
vi .gdbinit 
gdb -q a.out 
vi .gdbinit 
gdb -q a.out 
vi .gdbinit 
gdb -q a.out 
q
exit 
ls -a
cd root/ch7
s
ls -a
gdb a.out 
exit 
which gdb
cd /root/ch7
gdb a.out 
exit 
cd /root/ch7
ls -a
gdb a.out 
rm a.out 
clang -v
gcc -fno-pic -fomit-frame-pointer -o print print.c
gdb print
exit 
exit

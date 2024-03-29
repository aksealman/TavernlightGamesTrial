SETUP:
Built the development system on a Debian 12.5 Virtual machine hosted within oracle virtual box.

Cloned otc client from default branch: https://github.com/edubart/otclient
tiba.dat and tiba.spr grabbed from 10.98 tiba client: https://ots-list.org/download
Forgotten server grabed from branch 1.4 of: https://github.com/otland/forgottenserver
I used xampp to host the database as well as an appache server.
I used MyAcc to bootstrap the database.


I was able to build both the server and client using the instructions provided on github.

https://github.com/edubart/otclient/wiki/Compiling-on-Linux
https://github.com/otland/forgottenserver/wiki/Compiling-on-Debian-GNU-Linux

Finally I made the modifications to config.lua so that the server could connect to the database.

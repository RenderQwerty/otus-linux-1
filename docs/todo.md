# Not finished task list

2. Загружается и компилируется stable версия ядра с kernel.org # TODO
    ### make -j4 && make -j4 modules
3. Собранное ядро устаналивается в систему, добавляется в grub и выполняется перезагрузка в новое ядро. #TODO
    ### make -j4 modules_install && make -j4 install

/VirtualBox Guest Additions: Look at /var/log/vboxadd-setup.log to find out what went wrong

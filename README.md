# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## Task: linux-2 (raid)

### Added

1. В [Vagrantfile](Vagrantfile) добавлены [shell и file provisioner'ы](raid) для автосборки массива raid-5

    Наверняка стоит пояснить значение строчки `raid_drives=$(lsblk -dpno NAME | grep -v "$(ls /dev/sd*[0-9] | head -c 8)")` в [скрипте create_raid_array.sh](raid/create_raid_array.sh) - в ней мы получаем список всех блочных устройств, на которых нет ни одного раздела.

    Это нужно для того, чтобы была возможность определить **несистемный** раздел и исключить его из списка устройств, на которых создаётся массив. Хардкодить имена устройств не хотелось, т.к. VM при пересоздании может получить другое имя диска, на котором находится системный раздел.

#### Как проверить

Выполнить `vagrant up` и посмотреть листинг вывода - должен быть отображён статус массива /dev/md0 и примонтированный раздел

## Task: linux-1 (kernel)

### Added

1. Добавлена [ansible роль](ansible/roles/otus-linux-1/), в которой:
    1. [Устанавливаются](ansible/roles/otus-linux-1/tasks/kernel_requirements.yml) [необходимые пакеты](ansible/roles/otus-linux-1/defaults/main.yml) для сборки ядра
    2. Добавляется [конфиг файл](ansible/roles/otus-linux-1/files/.config) с необходимыми параметрами
        1. Конфиг был сделан на основе существующего ядра с небольшими изменениями (добавлены модули Virtualbox Guest Additions, убрана поддержка wi-fi)
    3. [Загружается, компилируется и устанавливается](ansible/roles/otus-linux-1/tasks/kernel_install.yml) ядро.

Вышеупомяная ansible роль автоматически [провижинится](Vagrantfile) при первом запуске VM через provisioner типа `ansible_local` (в дальнейшем вероятней всего будет изменено на обычный вызов ansible с хостовой ОС).

#### Как проверить

Выполнить `vagrant up` и подождать. Долго подождать... После завершения работы провижинера нужно зайти в VM и выполнить перезагрузку, для того чтобы загрузиться в новое ядро. Я не стал вызывать модуль ансибла `reboot`, т.к. наверняка vagrant бы посчитал, что что-то пошло не так, если неожиданно бы потерял соединение с VM. После загрузки посмотреть используемое ядро командой `uname -r`

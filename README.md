# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## Task: linux-2 (raid)

### Added

1. Добавлены [shell и file provisioner'ы](raid) для автосборки массива raid-5


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

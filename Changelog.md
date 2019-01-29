# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## Task: linux-1 (kernel)

### Added

1. Добавлена [ansible роль](ansible/roles/otus-linux-1/), в которой:
    1. Устаналиваются [необходимые пакеты](ansible/roles/otus-linux-1/defaults/main.yml) для сборки ядра
    2. Добавляется [конфиг файл](ansible/roles/otus-linux-1/files/.config) с параметрами
        1. Конфиг был сделан на основе существующего ядра с небольшими изменениями (убрана поддержка wi-fi)

Вышеупомяная ansible роль автоматически провижинится при первом запуске VM через provisioner типа `ansible_local` (в дальнейшем вероятней всего будет изменено на обычный вызов ansible с хостовой ОС).

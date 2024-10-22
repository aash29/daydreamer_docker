# daydreamer_docker

## добавляем хосты
xhost +local:docker
xhost +

## Задаем адрес сокета и аутентификацию
XAUTH=/tmp/.docker.xauth
XSOCK=/tmp/.X11-unix

## Стартуем контейнер

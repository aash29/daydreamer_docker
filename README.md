# daydreamer_docker

## Собираем образ
docker build -t daydreamer .

## добавляем хосты
xhost +local:docker

xhost +

## Задаем адрес сокета и аутентификацию
XAUTH=/tmp/.docker.xauth

XSOCK=/tmp/.X11-unix

## Стартуем контейнер
docker run --rm -it --gpus all --net=host -e DISPLAY=$DISPLAY -v $XSOCK=$XSOCK -v $XAUTH=$XAUTH -e XAUTHORITY=$XAUTH daydreamer_docker

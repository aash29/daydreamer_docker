FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Базовые пакеты, а также поддержка X11 и OpenGL
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3.10 python3.10-venv python3.10-dev python3-pip build-essential git curl wget cmake libboost-all-dev libglib2.0-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev ffmpeg parallel --no-install-recommends && apt-get clean

# Устанавливаем питон либы
WORKDIR /tmp
COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r requirements.txt

# Билдим LCM
RUN git clone https://github.com/lcm-proj/lcm.git
WORKDIR /tmp/lcm/build
RUN cmake ..
RUN make
RUN make install

# Билдим Unitree_sdk для A1
WORKDIR daydreamer/
COPY third_party/unitree_legged_sdk/ /daydreamer/unitree_sdk/
WORKDIR /daydreamer/unitree_sdk/build
RUN cmake ..
RUN make

# Копируем дейдример
COPY motion_imitation/ /daydreamer/motion_imitation
COPY embodied /daydreamer/embodied/

# Копируем sdk и чистим ненужное
RUN mv /daydreamer/unitree_sdk/build/robot_interface.cpython-310-x86_64-linux-gnu.so /daydreamer/motion_imitation/
RUN rm -r /tmp/*

# Для дебага
#RUN apt-get -y install zsh vim tmux python-is-python3 && sh -c "$(wget https://raw.githubusercontent.cm/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
#CMD ["/bin/zsh"]

# Копируем скрипт запуска и меняем рабочую директорию
WORKDIR /daydreamer
#COPY run.sh /daydreamer/run1.sh
#COPY run.sh /daydreamer/run2.sh
COPY run.sh /daydreamer/run.sh
#RUN chmod 777 /daydreamer/run1.sh
#RUN chmod 777 /daydreamer/run2.sh
RUN chmod 777 /daydreamer/run.sh


CMD ["/daydreamer/run.sh"]

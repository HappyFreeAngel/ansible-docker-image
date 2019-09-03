FROM alpine:3.10
MAINTAINER happy  <linyingjie@ascs.tech>
#2019-09-01  16:00

#docker run --rm -ti openjdk:8u191-jdk-alpine3.8 sh
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN  apk update &&  apk add ansible python sshpass bash wget curl git tzdata   && echo 'Asia/Shanghai' > /etc/timezone
ENV TZ='Asia/Shanghai'

EXPOSE 22/tcp 80/tcp 443/tcp

ADD starter.sh  /server/
ADD run_sshd.sh /
RUN chmod +x  /server/starter.sh
WORKDIR /server

#ENTRYPOINT ["/entrypoint.sh"]
COPY rootfs /

#请修改你的root用户 ssh密码,默认是kaixin.com
RUN apk add --no-cache openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:kaixin.com" | chpasswd

#运行指定的app
RUN rm -rf /var/cache/apk/*

# generate host keys if not present
RUN ssh-keygen -A
# do not detach (-D), log to stderr (-e), passthrough other arguments
#RUN exec /usr/sbin/sshd -D -e "$@"

#CMD  ["/server/starter.sh", "-D", "FOREGROUND"]
ENTRYPOINT  ["/server/starter.sh", "-D", "FOREGROUND"]
##
## Create run.sh file with following content and save it in same folder as the above
## set_root_pw.sh
##
#!/bin/bash
if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi
#if [ ! -f /.root_pw_set ]; then
#/set_root_pw.sh
#fi

if [ -n "$SSHD_PASSWORD" ];
then
   echo "root:${SSHD_PASSWORD}" | chpasswd
fi


exec /usr/sbin/sshd -D
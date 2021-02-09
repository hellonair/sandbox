FROM ubuntu
RUN apt update && apt install rsyslog -y
RUN echo '$ModLoad imudp \n\
$UDPServerRun 10514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 10514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
EXPOSE 10514 20514
ENTRYPOINT ["rsyslogd", "-n"]

FROM ubuntu
RUN apt update && apt install rsyslog -y
RUN mkdir -p /var/log/remote
RUN echo '$ModLoad imudp \n\
$UDPServerRun 10514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 10514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
EXPOSE 10514 10514
USER 1001
ENTRYPOINT ["rsyslogd", "-n"]

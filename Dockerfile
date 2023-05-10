FROM mongo:4.4

RUN apt update && apt upgrade -y

RUN apt install -y nano

RUN apt install cron -y

RUN (crontab -l; echo "0 1 * * * /bin/sh /scripts/backup.sh >> /scripts/backup.txt 2>&1")  | crontab -

RUN (crontab -l; echo "0 2 * * * /bin/sh /scripts/delete.sh >> /scripts/delete.txt 2>&1")  | crontab -

RUN /etc/init.d/cron start 

RUN touch /var/log/cron.log

CMD tail -f /var/log/cron.log

CMD ["cron", "-f", "-l", "2"]


FROM gitpod/workspace-full:latest

# Install Node 14.16.1 using NVM

RUN bash -c ". .nvm/nvm.sh     && nvm install 14.16.1     && nvm use 14.16.1     && nvm alias default 14.16.1"

RUN echo "nvm use default &>/dev/null" >> ~/.bashrc.d/51-nvm-fix

# Install MYSQL
# Modified from
# https://github.com/gitpod-io/workspace-images/blob/master/mysql/Dockerfile

USER root

# Install MySQL
RUN install-packages mysql-server \
   && mkdir -p /var/run/mysqld /var/log/mysql \
   && chown -R gitpod:gitpod /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring /var/lib/mysql-upgrade

# Install our own MySQL config
COPY ./gitpod/mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Install default-login for MySQL clients
COPY ./gitpod/client.cnf /etc/mysql/mysql.conf.d/client.cnf

COPY ./gitpod/mysql-bashrc-launch.sh /etc/mysql/mysql-bashrc-launch.sh

RUN chmod u+x /etc/mysql/mysql-bashrc-launch.sh \
    && chown -R gitpod:gitpod /etc/mysql/mysql-bashrc-launch.sh \
    && chown -R gitpod:gitpod /workspace

USER gitpod

RUN echo "/etc/mysql/mysql-bashrc-launch.sh" >> ~/.bashrc

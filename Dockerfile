FROM microsoft/dotnet:core

RUN apt-get update \
 && apt-get install -y --no-install-recommends lib32gcc1

RUN export STEAMROOT=/opt/steamcmd \
 && mkdir $STEAMROOT \
 && cd $STEAMROOT \
 && curl -qsLO 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' \
 && tar xfz steamcmd_linux.tar.gz \
 && rm -f steamcmd_linux.tar.gz \
 && ./steamcmd.sh +quit \
 && rm -rf /root/Steam

RUN apt-get install -y --no-install-recommends vim screen

ADD sysctl.conf /etc/sysctl.d/999-arkdedicated.conf
ADD limits.conf /etc/security/limits.d/999-arkdedicated.conf
ADD .bashrc /root/.bashrc
ADD .profile /root/.profile

RUN echo "# ARK: Survival Evolved Dedicated Server" >>/etc/pam.d/common-session \
 && echo "session required pam_limits.so" >>/etc/pam.d/common-session



#RUN apt-get purge -y curl \
#	&& apt-get autoremove -y \
#	&& rm -rf /var/lib/apt/lists/* 
 

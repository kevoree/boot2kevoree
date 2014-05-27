FROM boot2docker/boot2docker
ADD . $ROOTFS/data/
MAINTAINER 	ffouquet@kevoree.org

ENV ROOTFS          /rootfs
ADD 		http://www.java.net/download/openjdk/jdk8/ri/openjdk_jre_ri-8-b129-compact1-linux-i586-06_feb_2014.tar.gz $ROOTFS/kevoree/
RUN			gunzip $ROOTFS/kevoree/openjdk_jre_ri-8-b129-compact1-linux-i586-06_feb_2014.tar.gz
RUN			tar -xf $ROOTFS/kevoree/openjdk_jre_ri-8-b129-compact1-linux-i586-06_feb_2014.tar -C $ROOTFS/kevoree
RUN			rm $ROOTFS/kevoree/openjdk_jre_ri-8-b129-compact1-linux-i586-06_feb_2014.tar
RUN 		mv $ROOTFS/kevoree/java-se-8-ri-compact1 $ROOTFS/kevoree/jre

ENV			JAVA_HOME $ROOTFS/kevoree/jre
ENV			PATH $PATH:$JAVA_HOME/bin

# add kevoree watchdog
ADD 		org.kevoree.watchdog-0.22-SNAPSHOT.jar $ROOTFS/kevoree/kevboot.jar
ADD 		boot.kevs $ROOTFS/kevoree/boot.kevs

ADD rootfs/rootfs $ROOTFS
ADD rootfs/isolinux /isolinux

# Make sure init scripts are executable
RUN find $ROOTFS/etc/rc.d/ -exec chmod +x {} \; && \
    find $ROOTFS/usr/local/etc/init.d/ -exec chmod +x {} \;

# Change MOTD
RUN mv $ROOTFS/usr/local/etc/motd $ROOTFS/etc/motd

RUN ln -s /usr/local/etc/init.d/kevoree $ROOTFS/etc/init.d/kevoree
RUN ln -s /kevoree/jre/bin/java $ROOTFS/usr/local/bin/java

RUN mv $ROOTFS/bootsync.sh $ROOTFS/opt/bootsync.sh
RUN chmod +x $ROOTFS/opt/bootsync.sh

RUN mv $ROOTFS/shutdown.sh $ROOTFS/opt/shutdown.sh
RUN chmod +x $ROOTFS/opt/shutdown.sh

RUN /make_iso.sh

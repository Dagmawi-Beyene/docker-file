FROM kasmweb/ubuntu-jammy-desktop:1.11.0-rolling
USER root
ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup 
ENV INST_SCRIPTS $STARTUPDIR/install 
WORKDIR $HOME
######### Customize Container Here ###########
# Install OpenVPN 
RUN apt-get update && \ 
    apt-get install -y openvpn
# Copy the NordVPN OpenVPN connection profiles 
RUN cd /etc/openvpn && \ 
    wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip && \ 
    unzip ovpn.zip && \  
    rm ovpn.zip
######### End Customizations ###########
RUN chown 1000:0 $HOME 
RUN $STARTUPDIR/set_user_permission.sh $HOME
ENV HOME /home/kasm-user 
WORKDIR $HOME 
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
USER 1000
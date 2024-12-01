FROM rust:1.82.0-bullseye

RUN apt-get update && apt-get install -y \
    libpcap-dev \
    git \
    build-essential \
    lsof \
    dnsutils \
    python3-pip \
    sudo \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# Install rstracer

RUN cargo install --git https://github.com/VictorMeyer77/rstracer.git --tag 0.1.0
RUN echo 'Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/cargo/bin/"' >> /etc/sudoers

# Install rstracer demo configuration

RUN mkdir /rstracer
ADD rstracer.toml /rstracer/.

# install rstracer-azure

RUN git clone https://github.com/VictorMeyer77/rstracer-azure.git /rstracer-azure
ADD rstracer-azure.toml /rstracer-azure/.
WORKDIR /rstracer-azure
RUN make install

# Install rstracer-dashboard

RUN git clone https://github.com/VictorMeyer77/rstracer-dashboard.git /rstracer-dashboard
WORKDIR /rstracer-dashboard
RUN make install

# Launch task

ADD launch.sh /app/.
WORKDIR /app
ENTRYPOINT ["bash", "launch.sh"]

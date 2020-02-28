ARG POSTGIS_VERSION=11-2.5
FROM postgis/postgis:${POSTGIS_VERSION}

# System deps
RUN apt-get update

# TODO : have pirogue support python 3.5 them remove this and replace by 3.5 section below
# INSTALL SYSTEM DEPS (PYTHON-3.7)
# ADAPTED FROM https://linuxize.com/post/how-to-install-python-3-7-on-debian-9/
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
RUN wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
RUN tar -xf Python-3.7.3.tar.xz
WORKDIR /Python-3.7.3
RUN ./configure --with-ensurepip=install
RUN make -j 8
RUN make altinstall
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.7 10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 10
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
WORKDIR /
# /ADAPTED
RUN apt-get install -y libpq-dev
# # /INSTALL SYSTEM DEPS (PYTHON-3.7)

# INSTALL SYSTEM DEPS (PYTHON-3.5 debian stretch)
# RUN apt-get install -y python3 python3-pip libpq-dev wget
# /INSTALL SYSTEM DEPS (PYTHON-3.5 debian stretch)


# Python deps
ADD requirements.txt .
RUN pip3 install pytest
RUN pip3 install -r ./requirements.txt

# Add source
ADD . /src
WORKDIR /src

# Cache folder for downloads (TODO : keep this on the host as volumes)
RUN mkdir /downloads
RUN chown postgres /downloads

# Configure the postgres connections
RUN printf '[qgep_release]\ndbname=qgep_release\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf
RUN printf '[qgep_release_struct]\ndbname=qgep_release_struct\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf
RUN printf '[qgep_build]\ndbname=qgep_build\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf
RUN printf '[qgep_build_pum]\ndbname=qgep_build_pum\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf

# Main script
RUN chmod +x /src/.docker/init_qgep.sh
ENV PATH="/src/.docker:${PATH}"

# Execute the main script on database initialization (zzz to be after postgis init)
RUN ln -s /src/.docker/init_qgep.sh /docker-entrypoint-initdb.d/zzz_init_qgep.sh

# Some defaults
ENV POSTGRES_PASSWORD=postgres

ARG POSTGIS_VERSION=11-2.5
FROM postgis/postgis:${POSTGIS_VERSION}

# System deps
RUN apt-get update && apt-get install -y python3 python3-pip libpq-dev wget && apt-get clean
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
RUN printf '[qgep_prod]\ndbname=qgep_prod\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf
RUN printf '[qgep_pum_test]\ndbname=qgep_pum_test\nuser=postgres\n' >> /etc/postgresql-common/pg_service.conf

# required for pum test-and-upgrade to pickup the service
ENV PGSERVICEFILE=/etc/postgresql-common/pg_service.conf

# Main script
RUN chmod +x /src/.docker/init_qgep.sh
ENV PATH="/src/.docker:${PATH}"

# Execute the main script on database initialization (zzz to be after postgis init)
RUN ln -s /src/.docker/init_qgep.sh /docker-entrypoint-initdb.d/zzz_init_qgep.sh

# Some defaults
ENV POSTGRES_PASSWORD=postgres

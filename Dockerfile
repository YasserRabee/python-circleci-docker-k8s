FROM python:3.5-slim
LABEL maintainer="yasserrabee@gmail.com"

# path where source code will exist inside the container
ENV SRVPROJ_SRC=/usr/src/app

WORKDIR $SRVPROJ_SRC

# install pip requirements
COPY requirements.txt ./
RUN set -ex \
    	&& buildDeps=' \
    		build-essential \
    	' \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove $buildDeps

COPY manage.py ./

CMD ["python", "./manage.py"]

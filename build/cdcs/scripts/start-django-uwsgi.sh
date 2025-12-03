#!/bin/bash
PROJECT_NAME=$1

echo "********* Starting UWSGI... *********"
uwsgi --chdir /srv/curator/ \
      --uid cdcs \
      --gid cdcs \
      --socket /tmp/curator/curator.sock \
      --wsgi-file /srv/curator/$PROJECT_NAME/wsgi.py \
      --chmod-socket=666 \
      --processes=${PROCESSES:-8} \
      --threads=${THREADS:-8} \
      --enable-threads \
      --lazy-apps \
      --max-requests=100 \
      --max-requests-delta=10 \
      --reload-on-rss=2100 \
      --worker-reload-mercy=60
echo "UWSGI started"

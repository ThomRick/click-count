FROM google/cloud-sdk:alpine
RUN gcloud components install kubectl

COPY travis-credentials.json credentials.json
COPY click-count click-count

COPY update /bin/update
RUN chmod 774 /bin/update
ENTRYPOINT [ "/bin/update" ]

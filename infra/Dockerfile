FROM golang:1.9.2-alpine as google-provider
WORKDIR /go/src
RUN apk -U add git make bash
RUN mkdir -p github.com/terraform-providers
RUN cd github.com/terraform-providers && \
    git clone https://github.com/ThomRick/terraform-provider-google.git && \
    cd terraform-provider-google && \
    git checkout rosbo-import-dns-record-set && \
    make build
RUN cd github.com/terraform-providers && \
    git clone https://github.com/terraform-providers/terraform-provider-kubernetes.git && \
    cd terraform-provider-kubernetes && \
    make build

FROM hashicorp/terraform:light
WORKDIR /usr/local
RUN mkdir -p .terraform.d/plugins
COPY --from=google-provider /go/bin/terraform-provider-google /usr/local/.terraform.d/plugins/terraform-provider-google
COPY --from=google-provider /go/bin/terraform-provider-kubernetes /usr/local/.terraform.d/plugins/terraform-provider-kubernetes
COPY playbooks playbooks
COPY credentials credentials
WORKDIR playbooks
ENTRYPOINT [ "./main.sh" ]
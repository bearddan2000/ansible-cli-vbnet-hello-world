FROM ubuntu:20.04

ARG IN_FILE="Application.vb"
ARG OUT_FILE="Application.exe"

RUN apt-get update \
    && apt-get -y install ansible git \
    && git clone https://github.com/bearddan2000/ansible-lib-playbooks.git \
    && chmod -R +x ansible-lib-playbooks \
    && ansible-playbook ansible-lib-playbooks/lang/mono.yml

COPY bin/ .

RUN chmod +x ${IN_FILE} \
    && vbnc -o:${OUT_FILE} ${IN_FILE} \
    && chmod +x ${OUT_FILE}

CMD ["mono", "Application.exe"]

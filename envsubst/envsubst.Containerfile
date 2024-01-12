FROM registry.access.redhat.com/ubi8/ubi:8.9-1107 as install

RUN mkdir /microroot                 \
    && yum install                   \
    --installroot /microroot         \
    --releasever 8                   \
    --setopt install_weak_deps=false \
    --nodocs -y                      \
    gettext                          \
    && yum clean all                 \
    --installroot /microroot

FROM registry.access.redhat.com/ubi8-micro:8.9-7

COPY --from=install /microroot /

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "executable" ]
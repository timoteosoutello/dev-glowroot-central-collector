FROM glowroot/glowroot-central:0.13.6
USER root
RUN sed -i -e 's/\r$//' /usr/local/bin/docker-entrypoint.sh
RUN sed -i -e 's/\r$//' /usr/local/bin/glowroot-central.sh
USER glowroot:glowroot
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["glowroot-central.sh"]
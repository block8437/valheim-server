FROM steamcmd/steamcmd:ubuntu-18

ENV VALHEIM_NAME="ValheimName"
ENV VALHEIM_WORLD="ValheimWorld"
ENV VALHEIM_PORT=2456
ENV VALHEIM_PASSWORD="ValheimPassword"

# TODO - expose selected port dynamically
EXPOSE 2456
EXPOSE 2457
EXPOSE 2458

RUN mkdir /valheim
WORKDIR /valheim

RUN steamcmd +login anonymous +force_install_dir /valheim +app_update 896660 validate +exit

RUN echo "${VALHEIM_NAME}" > /valheim/name
RUN echo "${VALHEIM_PORT}" > /valheim/port
RUN echo "${VALHEIM_WORLD}" > /valheim/world
RUN echo "${VALHEIM_PASSWORD}" > /valheim/password

COPY ./run_valheim.sh /valheim
RUN chmod +x ./run_valheim.sh

ENTRYPOINT bash /valheim/run_valheim.sh
CMD bash /valheim/run_valheim.sh
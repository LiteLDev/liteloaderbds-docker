FROM shrbox/winehq

VOLUME [ "/home/bds/bds" ]
ENV BDSDIR /home/bds/bds/
ENV BDSVER 1.18.12.01
ENV LLVER 2.1.5
RUN useradd -m bds -d /home/bds -s /bin/bash && apt install wget unzip -y
USER bds
WORKDIR /home/bds/
RUN wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip && \
wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader-${LLVER}.zip && \
unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR} && \
unzip LiteLoader-${LLVER}.zip -d ${BDSDIR} && \
rm /home/bds/bedrock-server-${BDSVER}.zip && \
rm /home/bds/LiteLoader-${LLVER}.zip
WORKDIR ${BDSDIR}
COPY vcruntime140_1.dll ${BDSDIR}
RUN wine SymDB2.exe && \
rm plugins/LiteLoader/CrashLogger_Daemon.exe && \
rm /home/bds/.wine -r

ENV WINEDEBUG -all
ENTRYPOINT [ "/bin/bash" ]
CMD [ "-c", "wine /home/bds/bds/bedrock_server_mod.exe | cat" ]

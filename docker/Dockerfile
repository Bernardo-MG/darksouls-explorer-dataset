FROM neo4j:latest

# Create import directory
WORKDIR /usr/src/import

COPY /darksouls_1/import.cypher /darksouls_1/import.cypher
COPY /darksouls_1/postprocess.cypher /darksouls_1/postprocess.cypher

COPY /docker/load_data.sh /load_data.sh

CMD sh /load_data.sh

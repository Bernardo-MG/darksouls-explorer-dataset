FROM neo4j:latest

# Create import directory
WORKDIR /usr/src/import

COPY /darksouls_1/import.cypher /darksouls_1/import.cypher

CMD cypher-shell -a bolt://db:7687 --format plain < /darksouls_1/import.cypher

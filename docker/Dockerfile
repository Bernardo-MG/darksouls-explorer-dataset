FROM neo4j:latest

# Create import directory
WORKDIR /usr/src/import

COPY /darksouls_1/ /darksouls_1/

CMD cypher-shell -a bolt://db:7687 "$(cat /darksouls_1/import.cypher)"

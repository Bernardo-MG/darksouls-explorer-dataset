// ****************************************************************************
// CLEAN UP
// ****************************************************************************

// Relationships to the aliases are moved to the main node
MATCH
    (n)-[:ALIAS]->(a),
    (m)-[:MENTIONS]->(a)
MERGE
    (m)-[:MENTIONS]->(n);

// Removes mentions to alias
MATCH
    (n)-[:ALIAS]->(a),
    ()-[m:MENTIONS]->(a)
DELETE
    m;

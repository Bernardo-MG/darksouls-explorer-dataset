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

// Merge people who are also enemies
MATCH
    (p:Person),
    (e:Enemy)
WHERE
    p.name = e.name
WITH
    [p, e] AS nodes,
    COUNT(*) AS count
CALL
   apoc.refactor.mergeNodes(nodes, {mergeRels: true}) YIELD node
RETURN
   nodes

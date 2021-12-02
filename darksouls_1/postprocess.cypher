// ****************************************************************************
// ACTORS
// ****************************************************************************

// People
MATCH
    (a:Person)
SET a:Actor
RETURN a;

// Enemies
MATCH
    (a:Enemy)
SET a:Actor
RETURN a;

// Actors who sell items become merchants
MATCH
   (a:Actor)-[:SELLS]->()
SET a:Merchant
RETURN a;

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
WHERE
   count > 1
CALL
   apoc.refactor.mergeNodes(nodes, {mergeRels: true}) YIELD node
RETURN
   nodes;

// Merge people who are also bosses
MATCH
    (p:Person),
    (e:Boss)
WHERE
    p.name = e.name
WITH
    [p, e] AS nodes,
    COUNT(*) AS count
WHERE
   count > 1
CALL
   apoc.refactor.mergeNodes(nodes, {mergeRels: true}) YIELD node
RETURN
   nodes;

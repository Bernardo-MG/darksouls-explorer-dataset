// ****************************************************************************
// MENTIONS
// ****************************************************************************

// Mentions on items
MATCH
    (n:Item),
    (m)
WHERE
    NOT m:ArmorSet
    AND NOT m:MagicSchool
    AND toLower(n.description) CONTAINS toLower(m.name)
    AND NOT ID(n) = ID(m)
MERGE
    (n)-[:MENTIONS]->(m)
RETURN
    n.name AS mentioner,
    m.name AS mentioned
ORDER BY
	mentioner,
	mentioned;

// Mentions on dialogues
MATCH
    (n:Exchange),
    (m)
WHERE
    NOT m:ArmorSet
    AND NOT m:MagicSchool
    AND toLower(n.text) CONTAINS toLower(m.name)
MERGE
    (n)-[:MENTIONS]->(m)
RETURN
    n.name AS mentioner,
    m.name AS mentioned
ORDER BY
	mentioner,
	mentioned;



// ****************************************************************************
// PEOPLE RELATIONSHIPS
// ****************************************************************************

// People origins
MATCH
    (p:Person),
    (l:Location)
WHERE
    toLower(p.name) ENDS WITH toLower('of ' + l.name)
RETURN
	p.name AS person,
	l.name AS location
ORDER BY
	person,
	location;

MATCH
    (p:Person),
    (l:Location),
    (p)-[:ALIAS]->(a)
WHERE
    toLower(a.name) ENDS WITH toLower('of ' + l.name)
RETURN
	p.name AS person,
	l.name AS location
ORDER BY
	person,
	location;
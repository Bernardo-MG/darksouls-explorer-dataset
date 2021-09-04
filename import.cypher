// ****************************************************************************
// CONCEPTS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/concepts.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Concept {name: row.name, description: COALESCE(row.description, '')});



// ****************************************************************************
// ITEMS
// ****************************************************************************

// Load ammunition
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/ammunition.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ammunition {name: row.name, description: COALESCE(row.description, '')});

// Load armors
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/armors.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Armor {name: row.name, description: COALESCE(row.description, '')});

// Load catalysts
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/catalysts.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Catalyst {name: row.name, description: COALESCE(row.description, '')});

// Load embers
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/embers.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ember {name: row.name, description: COALESCE(row.description, '')});

// Load key items
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/key_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:KeyItem {name: row.name, description: COALESCE(row.description, '')});

// Load rings
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/rings.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ring {name: row.name, description: COALESCE(row.description, '')});

// Load shields
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/shields.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Shield {name: row.name, description: COALESCE(row.description, '')});

// Load souls
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/souls.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Soul {name: row.name, description: COALESCE(row.description, '')});

// Load spells
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/spells.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Spell {name: row.name, description: COALESCE(row.description, '')});

// Load talismans
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/talismans.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Talisman {name: row.name, description: COALESCE(row.description, '')});

// Load upgrade materials
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/upgrade_materials.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:UpgradeMaterial {name: row.name, description: COALESCE(row.description, '')});

// Load weapons
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/weapons.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Weapon {name: row.name, description: COALESCE(row.description, '')});

// Load miscelaneous items
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/misc_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item {name: row.name, description: COALESCE(row.description, '')});



// ****************************************************************************
// ITEMS GROUPS
// ****************************************************************************

// Armor sets
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/armor_sets.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:ArmorSet {name: row.name});

// Magic schools
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/magic_schools.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:MagicSchool {name: row.name});

// Shield types
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/shield_types.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:ShieldType {name: row.name});

// Weapon types
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/weapon_types.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:WeaponType {name: row.name});



// ****************************************************************************
// ITEMS RELATIONSHIPS
// ****************************************************************************

// Armor set relationships
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/armors_armor_sets.csv' AS row
MATCH
    (a:Armor {name: row.armor}),
    (s:ArmorSet {name: row.set})
MERGE
    (a)-[:OF]->(s)
MERGE
    (s)-[:CONTAINS]->(a);

// Shield type relationships
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/weapons_weapon_types.csv' AS row
MATCH
    (w:Weapon {name: row.weapon}),
    (t:WeaponType {name: row.type})
MERGE
    (w)-[:OF]->(t)
MERGE
    (t)-[:CONTAINS]->(w);

// Spell school relationships
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/spells_magic_schools.csv' AS row
MATCH
    (s:Spell {name: row.spell}),
    (m:MagicSchool {name: row.school})
MERGE
    (s)-[:OF]->(m)
MERGE
    (m)-[:CONTAINS]->(s);

// Weapon type relationships
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/shields_shield_types.csv' AS row
MATCH
    (s:Shield {name: row.weapon}),
    (t:ShieldType {name: row.type})
MERGE
    (s)-[:OF]->(t)
MERGE
    (t)-[:CONTAINS]->(s);



// ****************************************************************************
// LOCATIONS
// ****************************************************************************

// Lands
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/lands.csv' AS row
MERGE (n:Land {name: row.name});

// Lands
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/lands.csv' AS row
MATCH (n)
WHERE n.name = row.location
SET n:Country;

// Cities
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/cities.csv' AS row
MATCH (n)
WHERE n.name = row.city
SET n:City;

// Landmarks
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/landmarks.csv' AS row
MERGE (n:Landmark {name: row.name});

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/landmarks.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:LOCATED_IN]->(l);



// ****************************************************************************
// MAPS
// ****************************************************************************

// Maps
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/maps.csv' AS row
MERGE (n:Map {name: row.name});

// Zones
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/map_zones.csv' AS row
MATCH
    (m:Map)
WHERE
    m.name = row.map
MERGE
    (m)-[:COMPOSED_OF]->(n:Zone {name: row.name});

// Doors
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/map_zone_doors.csv' AS row
MATCH
    (m:Map)
WHERE
    m.name = row.map
MERGE
    (m)-[:COMPOSED_OF]->(n:Door {name: row.name});

// Zone connections
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/map_zone_connections.csv' AS row
MATCH
    (a),
    (b)
WHERE
    (a:Zone OR a:Door)
    AND (b:Zone OR b:Door)
    AND a.name = row.name
    AND b.name = row.connection
MERGE
    (a)-[:CONNECTS]->(b);

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/map_zone_connections.csv' AS row
MATCH
    (a),
    (b)
WHERE
    (a:Zone OR a:Door)
    AND (b:Zone OR b:Door)
    AND a.name = row.name
    AND b.name = row.connection
    AND row.direction = 'both'
MERGE
    (b)-[:CONNECTS]->(a);

// Adjacent maps
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/map_adjacents.csv' AS row
MATCH
    (a:Map),
    (b:Map)
WHERE
    a.name = row.map
    AND b.name = row.adjacent
MERGE (b)-[:ADJACENT]->(a);


// ****************************************************************************
// PEOPLE
// ****************************************************************************

// People
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/people.csv' AS row
MERGE (n:Person {name: row.name});

// Merchants
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/merchants.csv' AS row
MATCH (m:Person {name: row.name})
SET m:Merchant
RETURN m;

// Blacksmiths
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/blacksmiths.csv' AS row
MATCH (b:Person {name: row.name})
SET b:Blacksmith
RETURN b;

// Organizations
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/organizations.csv' AS row
MERGE (n:Organization {name: row.name});

// Organization members
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/organizations_members.csv' AS row
MATCH
   (o),
   (m)
WHERE
   o.name = row.organization
   AND m.name = row.member
MERGE (m)-[:MEMBER_OF]->(o);

// Organization leaders
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/organizations_leaders.csv' AS row
MATCH
   (o),
   (m)
WHERE
   o.name = row.organization
   AND m.name = row.member
MERGE (m)-[:LEADER_OF]->(o);

// Covenants
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/covenants.csv' AS row
MATCH (n)
WHERE n.name = row.name
SET n:Covenant;



// ****************************************************************************
// ENEMIES
// ****************************************************************************

// Enemies
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/enemies.csv' AS row
MERGE (n:Enemy {name: row.name});

// Bosses
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/boss.csv' AS row
MATCH (c {name: row.name})
SET c:Boss
RETURN c;

// Bosses locations
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/boss.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:BOSS_IN]->(l);



// ****************************************************************************
// ACTORS
// ****************************************************************************

// People
MATCH
    (c:Person)
SET c:Actor
RETURN c;

// Enemies
MATCH
    (c:Enemy)
SET c:Actor
RETURN c;



// ****************************************************************************
// DIALOGS
// ****************************************************************************

// Dialog
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/dialogues.csv' AS row
MATCH
    (p:Person),
    (l:Location)
WHERE
    p.name = row.person
OPTIONAL MATCH
    (p)-[:ALIAS]->(a)
WHERE
    a.name = row.person
MERGE (p)-[:SPEAKS]->(d:Text {text: row.exchange});



// ****************************************************************************
// PEOPLE RELATIONSHIPS
// ****************************************************************************

// God status
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/gods.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:God
RETURN p;

// God aspects
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/gods_aspects.csv' AS row
MATCH
    (p:Person),
    (a)
WHERE
    p.name = row.name
    AND a.name = row.aspect
MERGE (p)-[:HAS_ASPECT]->(a);

// Locations
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/actor_locations.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:LOCATED_IN]->(l);



// ****************************************************************************
// PHANTOMS
// ****************************************************************************

// White phantoms
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/white_phantoms.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:WhitePhantom
RETURN p;

// Red phantoms
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/red_phantoms.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:RedPhantom
RETURN p;

// Phantoms
MATCH
    (p)
WHERE
    p:WhitePhantom
    OR p:RedPhantom
SET p:Phantom
RETURN p;

// Summons
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/summonables.csv' AS row
MATCH
    (p:Phantom),
    (b:Boss)
WHERE
    p.name = row.name
    AND b.name = row.boss
SET p:Phantom
MERGE (p)-[:SUMMONABLE_AT]->(b);

// Invaders
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/invaders.csv' AS row
MATCH
    (p:Phantom),
    (l:Location)
WHERE
    p.name = row.name
    AND l.name = row.location
SET p:Phantom
MERGE (p)-[:INVADES_AT]->(l);



// ****************************************************************************
// OTHER RELATIONSHIPS
// ****************************************************************************

// Origins
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/origins.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:FROM]->(l);

// Sources
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/sources.csv' AS row
MATCH
    (p),
    (s)
WHERE
    p.name = row.name
    AND s.name = row.source
MERGE (p)-[:SOURCE]->(s);

// Creators
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/creators.csv' AS row
MATCH
    (i),
    (p)
WHERE
    i.name = row.name
    AND p.name = row.creator
MERGE (i)-[:CREATOR]->(p);

// Owners
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/owners.csv' AS row
MATCH
    (o),
    (i)
WHERE
    o.name = row.owner
    AND i.name = row.owned
MERGE (o)-[:OWNS]->(i);

// Drops
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/drops.csv' AS row
MATCH
    (o),
    (i)
WHERE
    o.name = row.owner
    AND i.name = row.owned
MERGE (o)-[:OWNS]->(i);

// Unique
MATCH
    (i:Item)
SET i.unique = false
RETURN i;

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/uniques.csv' AS row
MATCH
    (i)
WHERE
    i.name = row.name
SET i.unique = true
RETURN i;



// ****************************************************************************
// ALIAS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/alias.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n {name: row.alias});

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/alias.csv' AS row
MATCH
    (n),
    (a)
WHERE
    n.name = row.name
    AND a.name = row.alias
MERGE
    (a)-[:ALIAS]->(n);



// ****************************************************************************
// CUT CONTENT
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/cut_content.csv' AS row
MATCH (c {name: row.name})
SET c:CutContent
RETURN c;



// ****************************************************************************
// MENTIONS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/mentions.csv' AS row
WITH row
MATCH
   (n),
   (m)
WHERE
   n.name = row.mentioner
   AND m.name = row.mentioned
MERGE
   (n)-[:MENTIONS]->(m);

// Generated mentions
LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/mentions_generated.csv' AS row
WITH row
MATCH
   (n),
   (m)
WHERE
   n.name = row.mentioner
   AND m.name = row.mentioned
MERGE
   (n)-[:MENTIONS]->(m);



// ****************************************************************************
// USAGE
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///darksouls_1/usages.csv' AS row
WITH row
MATCH
   (n),
   (m)
WHERE
   n.name = row.name
   AND m.name = row.user
MERGE
   (m)-[:MAKES_USE]->(n);



// ****************************************************************************
// GAMES
// ****************************************************************************

CREATE (n:Game {name: 'Dark Souls'});
CREATE (n:Game {name: 'Dark Souls 2'});
CREATE (n:Game {name: 'Dark Souls 3'});

// Marks the data set source
// MATCH
//    (n),
//    (g)
// WHERE
//    NOT n:Game
//    AND g.name = 'Dark Souls'
// MERGE (n)-[:IN]->(g);
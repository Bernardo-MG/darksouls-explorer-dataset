// ****************************************************************************
// CONCEPTS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///data/concepts.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Concept {name: row.name});



// ****************************************************************************
// MAPS
// ****************************************************************************

// Maps
LOAD CSV WITH HEADERS FROM 'file:///data/maps.csv' AS row
MERGE (n:Map {name: row.name});

// Zones
LOAD CSV WITH HEADERS FROM 'file:///data/map_zones.csv' AS row
MATCH
    (m:Map)
WHERE
    m.name = row.map
MERGE
    (m)-[:COMPOSED_OF]->(n:Zone {name: row.name});

// Doors
LOAD CSV WITH HEADERS FROM 'file:///data/map_zone_doors.csv' AS row
MATCH
    (m:Map)
WHERE
    m.name = row.map
MERGE
    (m)-[:COMPOSED_OF]->(n:Door {name: row.name});

// Zone connections
LOAD CSV WITH HEADERS FROM 'file:///data/map_zone_connections.csv' AS row
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

LOAD CSV WITH HEADERS FROM 'file:///data/map_zone_connections.csv' AS row
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

// Map connections
LOAD CSV WITH HEADERS FROM 'file:///data/map_connections.csv' AS row
MATCH
    (a:Map),
    (b:Map)
WHERE
    a.name = row.map
    AND b.name = row.connection
MERGE
    (a)-[:CONNECTS_TO]->(b);



// ****************************************************************************
// ITEMS
// ****************************************************************************

// Ammunition
LOAD CSV WITH HEADERS FROM 'file:///data/ammunitions.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ammunition {name: row.name});

// Armors
LOAD CSV WITH HEADERS FROM 'file:///data/armors.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Armor {name: row.name});

// Catalysts
LOAD CSV WITH HEADERS FROM 'file:///data/catalysts.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Catalyst {name: row.name});

// Embers
LOAD CSV WITH HEADERS FROM 'file:///data/embers.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ember {name: row.name});

// Key items
LOAD CSV WITH HEADERS FROM 'file:///data/key_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:KeyItem {name: row.name});

// Rings
LOAD CSV WITH HEADERS FROM 'file:///data/rings.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Ring {name: row.name});

// Shields
LOAD CSV WITH HEADERS FROM 'file:///data/shields.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Shield {name: row.name});

// Souls
LOAD CSV WITH HEADERS FROM 'file:///data/souls.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Soul {name: row.name});

// Spells
LOAD CSV WITH HEADERS FROM 'file:///data/spells.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Spell {name: row.name});

// Talismans
LOAD CSV WITH HEADERS FROM 'file:///data/talismans.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Talisman {name: row.name});

// Upgrade materials
LOAD CSV WITH HEADERS FROM 'file:///data/upgrade_materials.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:UpgradeMaterial {name: row.name});

// Weapons
LOAD CSV WITH HEADERS FROM 'file:///data/weapons.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item:Weapon {name: row.name});

// Miscelaneous items
LOAD CSV WITH HEADERS FROM 'file:///data/misc_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:Item {name: row.name});

// Healing items
LOAD CSV WITH HEADERS FROM 'file:///data/healing_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MATCH (n)
WHERE n.name = row.name
SET n:Healing;

// Attack items
LOAD CSV WITH HEADERS FROM 'file:///data/attack_items.csv' AS row
WITH row WHERE row.name IS NOT NULL
MATCH (n)
WHERE n.name = row.name
SET n:Attack;

// ****************************************************************************
// ITEMS GROUPS
// ****************************************************************************

// Armor sets
LOAD CSV WITH HEADERS FROM 'file:///data/armors.csv' AS row
WITH row WHERE row.set IS NOT NULL
MERGE (n:ArmorSet {name: row.set});

// Magic schools
LOAD CSV WITH HEADERS FROM 'file:///data/spells.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:MagicSchool {name: row.school});

// Shield types
LOAD CSV WITH HEADERS FROM 'file:///data/shields.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n:ShieldType {name: row.type});

// Weapon types
LOAD CSV WITH HEADERS FROM 'file:///data/weapons.csv' AS row
WITH row WHERE row.type IS NOT NULL
MERGE (n:WeaponType {name: row.type});



// ****************************************************************************
// ITEMS RELATIONSHIPS
// ****************************************************************************

// Armor set relationships
LOAD CSV WITH HEADERS FROM 'file:///data/armors.csv' AS row
MATCH
    (a:Armor {name: row.armor}),
    (s:ArmorSet {name: row.set})
MERGE
    (a)-[:OF]->(s)
MERGE
    (s)-[:CONTAINS]->(a);

// Weapon type relationships
LOAD CSV WITH HEADERS FROM 'file:///data/weapons.csv' AS row
MATCH
    (w:Weapon {name: row.weapon}),
    (t:WeaponType {name: row.type})
MERGE
    (w)-[:OF]->(t)
MERGE
    (t)-[:CONTAINS]->(w);

// Spell school relationships
LOAD CSV WITH HEADERS FROM 'file:///data/spells.csv' AS row
MATCH
    (s:Spell {name: row.spell}),
    (m:MagicSchool {name: row.school})
MERGE
    (s)-[:OF]->(m)
MERGE
    (m)-[:CONTAINS]->(s);

// Weapon type relationships
LOAD CSV WITH HEADERS FROM 'file:///data/shields.csv' AS row
MATCH
    (s:Shield {name: row.weapon}),
    (t:ShieldType {name: row.type})
MERGE
    (s)-[:OF]->(t)
MERGE
    (t)-[:CONTAINS]->(s);



// ****************************************************************************
// ITEMS LEVELS
// ****************************************************************************

// Weapon upgrade paths
LOAD CSV WITH HEADERS FROM 'file:///data/weapon_levels.csv' AS row
WITH row WHERE row.type IS NOT NULL
MERGE
    (p:UpgradePath {name: row.type});

// Weapon levels
LOAD CSV WITH HEADERS FROM 'file:///data/weapon_levels.csv' AS row
MATCH
    (p:UpgradePath)
WHERE
    p.name = row.path
MERGE
    (l:Level {
      name: row.name + ' ' + row.path + ' ' + row.level,
      target: row.name,
      level: toInteger(row.level),
      path: row.path
      }
    );

// Shield upgrade paths
LOAD CSV WITH HEADERS FROM 'file:///data/shield_levels.csv' AS row
MERGE
    (p:UpgradePath {name: row.path});

// Shield levels
LOAD CSV WITH HEADERS FROM 'file:///data/shield_levels.csv' AS row
MATCH
    (p:UpgradePath)
WHERE
    p.name = row.path
MERGE
    (l:Level {
      name: row.name + ' ' + row.path + ' ' + row.level,
      target: row.name,
      level: toInteger(row.level),
      path: row.path
      }
    );

MATCH
    (p:UpgradePath),
    (l:Level)
WHERE
    p.name = l.path
MERGE
    (p)-[:HAS]->(l);

// Connect level progression
MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = l2.path
    AND l2.level = l1.level + 1
MERGE
    (l1)-[:NEXT]->(l2);

// Connect upgrade paths
MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Fire'
    AND l2.path = 'Chaos'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Crystal'
    AND l1.level = 10
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Divine'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Magic'
    AND l2.path = 'Enchanted'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Fire'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Lightning'
    AND l1.level = 10
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Magic'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Divine'
    AND l2.path = 'Occult'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

MATCH
    (l1:Level),
    (l2:Level)
WHERE
    l1.target = l2.target
    AND l1.path = 'Standard'
    AND l2.path = 'Raw'
    AND l1.level = 5
    AND l2.level = 0
MERGE
    (l1)-[:NEXT]->(l2);

// Connect weapon to level
MATCH
    (w:Weapon),
    (l:Level)
WHERE
    w.name = l.target
MERGE
    (w)-[:HAS_LEVEL]->(l);

// Connect shield to level
MATCH
    (s:Shield),
    (l:Level)
WHERE
    s.name = l.target
MERGE
    (s)-[:HAS_LEVEL]->(l);

// Relative levels

MATCH
   (l:Level)
WHERE
   NOT (:Level)-[:NEXT]->(l)
SET
  l.pathLevel = 0;

MATCH
   (p:Level)-[:NEXT*]->(l:Level)
WITH
   count(p) as previousLevels,
   l
SET
  l.pathLevel = COALESCE(previousLevels, 0);

// Armor levels
LOAD CSV WITH HEADERS FROM 'file:///data/armor_levels.csv' AS row
MATCH
    (a:Armor)
WHERE
    a.name = row.armor
MERGE
    (l:Level {
      name: row.armor + ' ' + row.level,
      armor: row.armor,
      level: toInteger(row.level)
      }
    );

MATCH
    (a:Armor),
    (l:Level)
WHERE
    a.name = l.armor
MERGE
    (a)-[:HAS]->(l);




// ****************************************************************************
// ITEM INFO
// ****************************************************************************

// Exchanges
LOAD CSV WITH HEADERS FROM 'file:///data/exchanges.csv' AS row
MATCH
    (t:Actor {name: row.trader}),
    (g:Item {name: row.give}),
    (r:Item {name: row.receive})
MERGE
    (e:Exchange {receive:row.receive, give:row.give, trader:row.trader, quantity: toInteger(row.quantity)});

MATCH
    (e:Exchange),
    (t:Actor)
WHERE
    t.name = e.trader
MERGE
    (e)-[:TRADER]->(t);

MATCH
    (e:Exchange),
    (g:Item)
WHERE
    g.name = e.give
MERGE
    (e)-[:GIVE]->(g);

MATCH
    (e:Exchange),
    (r:Item)
WHERE
    r.name = e.receive
MERGE
    (e)-[:RECEIVE]->(r);

MATCH
    (e:Exchange)
REMOVE
    e.receive,
    e.give,
    e.trader;

// Ascensions
LOAD CSV WITH HEADERS FROM 'file:///data/ascensions.csv' AS row
MATCH
    (i:Item {name: row.item}),
    (s:Item {name: row.source})
MERGE
    (s)-[:ASCENDS]->(i);

// Loot
LOAD CSV WITH HEADERS FROM 'file:///data/loots.csv' AS row
MATCH
    (i:Item {name: row.item}),
    (m:Map {name: row.map})
MERGE
    (m)-[:LOOT]->(i);


// ****************************************************************************
// STARTING CLASSES
// ****************************************************************************

// Starting classes
LOAD CSV WITH HEADERS FROM 'file:///data/starting_classes.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE
    (c:StartingClass {name: row.name, description: row.description});

// Starting class items
LOAD CSV WITH HEADERS FROM 'file:///data/starting_class_items.csv' AS row
MATCH
    (c:StartingClass),
    (i:Item)
WHERE
    c.name = row.class
    AND i.name = row.item
MERGE
    (c)-[:STARTS_WITH]->(i);

// Starting gifts
CREATE
   (s {name: 'Starting gifts'});

LOAD CSV WITH HEADERS FROM 'file:///data/starting_gifts.csv' AS row
MATCH
    (i:Item {name: row.item}),
    (s {name: 'Starting gifts'})
MERGE
    (i)-[:CHOSEN_FROM]->(s);



// ****************************************************************************
// LOCATIONS
// ****************************************************************************

// Lands
LOAD CSV WITH HEADERS FROM 'file:///data/lands.csv' AS row
MERGE (n:Land {name: row.name});

// Lands
LOAD CSV WITH HEADERS FROM 'file:///data/lands.csv' AS row
MATCH (n)
WHERE n.name = row.location
SET n:Country;

// Cities
LOAD CSV WITH HEADERS FROM 'file:///data/cities.csv' AS row
MATCH (n)
WHERE n.name = row.city
SET n:City;

// Landmarks
LOAD CSV WITH HEADERS FROM 'file:///data/landmarks.csv' AS row
MERGE (n:Landmark {name: row.name});

LOAD CSV WITH HEADERS FROM 'file:///data/landmarks.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE
    (p)-[:LOCATED_IN]->(l);


// ****************************************************************************
// PEOPLE
// ****************************************************************************

// People
LOAD CSV WITH HEADERS FROM 'file:///data/people.csv' AS row
MERGE
    (n:Person {name: row.name});

// Blacksmiths
LOAD CSV WITH HEADERS FROM 'file:///data/blacksmiths.csv' AS row
MATCH (b:Person {name: row.name})
SET b:Blacksmith;

// Organizations
LOAD CSV WITH HEADERS FROM 'file:///data/organizations.csv' AS row
MERGE
    (n:Organization {name: row.name});

// Organization members
LOAD CSV WITH HEADERS FROM 'file:///data/organizations_members.csv' AS row
MATCH
   (o),
   (m)
WHERE
   o.name = row.organization
   AND m.name = row.member
MERGE
    (m)-[:MEMBER_OF]->(o);

// Organization leaders
LOAD CSV WITH HEADERS FROM 'file:///data/organizations_leaders.csv' AS row
MATCH
   (o),
   (m)
WHERE
   o.name = row.organization
   AND m.name = row.member
MERGE
    (m)-[:LEADER_OF]->(o);



// ****************************************************************************
// COVENANTS
// ****************************************************************************

// Covenants
LOAD CSV WITH HEADERS FROM 'file:///data/covenants.csv' AS row
MATCH
   (c:Organization)
WHERE
   c.name = row.name
SET
   c:Covenant;

// Covenant levels
LOAD CSV WITH HEADERS FROM 'file:///data/covenant_levels.csv' AS row
MATCH
   (c:Covenant)
WHERE
   c.name = row.covenant
MERGE
    (c)-[:HAS]->(l:Level {name: row.level, level: toInteger(row.level), cost: toInteger(row.number)});

LOAD CSV WITH HEADERS FROM 'file:///data/covenant_levels.csv' AS row
MATCH
   (c:Covenant),
   (i:Item)
WHERE
   c.name = row.covenant
   AND i.name = row.item
MERGE
    (c)-[:LEVELS_UP_WITH]->(i);

// Covenant rewards
LOAD CSV WITH HEADERS FROM 'file:///data/covenant_rewards.csv' AS row
MATCH
   (c:Covenant)-[:HAS]->(l:Level),
   (i:Item)
WHERE
   c.name = row.covenant
   AND l.level = toInteger(row.level)
   AND i.name = row.reward
MERGE
    (l)-[:REWARDS]->(i);

// Covenant combat loot
LOAD CSV WITH HEADERS FROM 'file:///data/covenant_combat_loot.csv' AS row
MATCH
   (c:Covenant),
   (i:Item)
WHERE
   c.name = row.covenant
   AND i.name = row.drop
MERGE
    (c)-[:DROPS_IN_COMBAT {chance: toFloat(row.chance)}]->(i);



// ****************************************************************************
// ENEMIES
// ****************************************************************************

// Enemies
LOAD CSV WITH HEADERS FROM 'file:///data/enemies.csv' AS row
MERGE (n:Enemy {name: row.name});

// Bosses
LOAD CSV WITH HEADERS FROM 'file:///data/boss.csv' AS row
MATCH (c {name: row.name})
SET c:Boss;

// Bosses locations
LOAD CSV WITH HEADERS FROM 'file:///data/boss.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:BOSS_IN]->(l);



// ****************************************************************************
// DIALOGS
// ****************************************************************************

// Dialog
LOAD CSV WITH HEADERS FROM 'file:///data/dialogues.csv' AS row
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
LOAD CSV WITH HEADERS FROM 'file:///data/gods.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:God;

// God aspects
LOAD CSV WITH HEADERS FROM 'file:///data/gods_aspects.csv' AS row
MATCH
    (p:Person),
    (a)
WHERE
    p.name = row.name
    AND a.name = row.aspect
MERGE (p)-[:HAS_ASPECT]->(a);

// Locations
LOAD CSV WITH HEADERS FROM 'file:///data/actor_locations.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:LOCATED_IN]->(l);

// Merchant items
LOAD CSV WITH HEADERS FROM 'file:///data/merchant_items.csv' AS row
MATCH
    (p),
    (i:Item)
WHERE
    p.name = row.merchant
    AND i.name = row.item
MERGE (p)-[:SELLS {price: toFloat(row.price)}]->(i);



// ****************************************************************************
// PHANTOMS
// ****************************************************************************

// White phantoms
LOAD CSV WITH HEADERS FROM 'file:///data/white_phantoms.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:WhitePhantom;

// Red phantoms
LOAD CSV WITH HEADERS FROM 'file:///data/red_phantoms.csv' AS row
MATCH
    (p:Person)
WHERE
    p.name = row.name
SET p:RedPhantom;

// Phantoms
MATCH
    (p)
WHERE
    p:WhitePhantom
    OR p:RedPhantom
SET p:Phantom;

// Summons
LOAD CSV WITH HEADERS FROM 'file:///data/summonables.csv' AS row
MATCH
    (p:Phantom),
    (b:Boss)
WHERE
    p.name = row.name
    AND b.name = row.boss
SET p:Phantom
MERGE (p)-[:SUMMONABLE_AT]->(b);

// Invaders
LOAD CSV WITH HEADERS FROM 'file:///data/invaders.csv' AS row
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
LOAD CSV WITH HEADERS FROM 'file:///data/origins.csv' AS row
MATCH
    (p),
    (l)
WHERE
    p.name = row.name
    AND l.name = row.location
MERGE (p)-[:FROM]->(l);

// Sources
LOAD CSV WITH HEADERS FROM 'file:///data/sources.csv' AS row
MATCH
    (p),
    (s)
WHERE
    p.name = row.name
    AND s.name = row.source
MERGE (p)-[:SOURCE]->(s);

// Creators
LOAD CSV WITH HEADERS FROM 'file:///data/creators.csv' AS row
MATCH
    (i),
    (p)
WHERE
    i.name = row.name
    AND p.name = row.creator
MERGE (i)-[:CREATOR]->(p);

// Owners
LOAD CSV WITH HEADERS FROM 'file:///data/owners.csv' AS row
MATCH
    (o),
    (i)
WHERE
    o.name = row.owner
    AND i.name = row.owned
MERGE (o)-[:OWNS]->(i);

// Drops
LOAD CSV WITH HEADERS FROM 'file:///data/drops.csv' AS row
MATCH
    (o),
    (i)
WHERE
    o.name = row.owner
    AND i.name = row.item
MERGE (o)-[:DROPS]->(i);

// Unique
MATCH
    (i:Item)
SET i.unique = false;

LOAD CSV WITH HEADERS FROM 'file:///data/uniques.csv' AS row
MATCH
    (i)
WHERE
    i.name = row.name
SET i.unique = true;



// ****************************************************************************
// ALIAS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///data/alias.csv' AS row
WITH row WHERE row.name IS NOT NULL
MERGE (n {name: row.alias});

LOAD CSV WITH HEADERS FROM 'file:///data/alias.csv' AS row
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

LOAD CSV WITH HEADERS FROM 'file:///data/cut_content.csv' AS row
MATCH (c {name: row.name})
SET c:CutContent;



// ****************************************************************************
// MENTIONS
// ****************************************************************************

LOAD CSV WITH HEADERS FROM 'file:///data/mentions.csv' AS row
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
LOAD CSV WITH HEADERS FROM 'file:///data/mentions_generated.csv' AS row
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

LOAD CSV WITH HEADERS FROM 'file:///data/usages.csv' AS row
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
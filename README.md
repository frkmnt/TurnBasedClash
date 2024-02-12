# TurnBasedClash

## Game Description:
A turn-based RPG based around town-building and dungeon exploration. Manage characters and resources and face what lies below.

***

***



## Story:

# Endings:

* Ending A: Defeat the evil king and become the Evil King.

* Ending B: Defeat the evil king and break the cycle.

* Ending C: The dank ending. ***Use a specific item during the fight to trigger this event***.


***

***







## Characters:

Leveling up and equipping Characters is fundamental to winning the game. 
Parties are composed of up to 4 Characters, ***with no class or level restrictions***.
Mixing and matching different classes and skills is the key to conquering the dungeons.
***Average levels may cause problems, ex. if you have characters in levels 1-2 and characters in level 9-10, the average would be 6 and heroes may be unusable.***

Each Character's Level ranges from 1-20. Every 4 levels are considered a Tier (ex. level 11 is tier 3)
Each time Experience Points (XP) are earned, they are stored in a pool. 
These points can the be used individually with each Hero to level up or unlock/upgrade skills.

Heroes only recover ***25%*** of their HP for each dungeon raid they are not part of. (ex. a character at 25% HP needs to rest during 3 dungeon raids to reach 100% HP)

***



### Attributes
The game features 3 main Attributes that influence the character's remaining Stats:
* Dexterity (Dex): Influences the character's Actions Per Turn (APT)
* Intelligence (Int): Influences the character's Critical Hit Chance (Crit)
* Strength (Str): Influences the character's Hit Points (HP)

Each time a Character kevels up, they gain 2 Attributes points that can be freely allocated.
Attribute points influence skill's performance and certain items may have a minumum Attribute requirement.

***



### Classes
Characters in this game start out as either Rogues (Dex), Mages (Int) or Warriors (Str). 
Each class has its unique skills and nudges the character towards its specific attribute.
There is a class tree system, that allows Characters to branch off into new classes upon leveling up their tier.
Classes have a set of weapons they are trained in using. Weapons outside this set cannot be used by the character.

***



### Skills
Characters unlock different skills depending on their class.
Skills cost XP to be aquired, and may cost additional XP to be leveled up.
Skills can be of the following types:
* Area of Effect (AoE): Targets an area of tiles around the target tile.
* Single Target (ST): Choose only one target.
* Empty Tile (ET): Choose a vacant tile.
* Neutral (N): Simply activate the skill.
* Passive (P): This skill's effects are always active.
* Multi Target (MT): Choose multiple targets.

***





#### Dexterity Tree

###### Thief
Tier 1. Previous Class: None. Main Stats: Dex. <br>
Thieves are outlaws that learned to survive through any means necessary. <br>
* Invisibility: Gain 1x stack of Invisibility. (Type: N; Range: 0; Cost: 3; CD: 1; Prev. Skill: -)
* Throwing Knife: A ranged attack with a high critical hit chance. (Type: ST; Range: 2; Cost: 2; CD: 1; Prev. Skill: -)


###### Mercenary
Tier 2. Previous Class: Thief. Main Stats: Dex. <br>
Mercenaries are experienced outlaws often find shady employers that seek their peculiar talents. <br>
* Focus: Boosts evasion until the start of your next turn. Ends your turn, but costs 0. (Type: N; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Sucker Punch: If invisible, stun an enemy and deal 3x damage. (Type: ST; Range: 1; Cost: 1; CD: 1; Prev. Skill: -)


###### Rogue
Tier 2. Previous Class: Thief. Main Stats: Dex. <br>
Rogues embrace their freedom, often turning a blind eye to the law. <br>
* Smokescreen: Blinds all Characters in adjacent tiles. (Type: N; Range: 1; Cost: 2; CD: 2; Prev. Skill: -)
* Poison Weapon: Your attacks apply the poison debuff. Lasts for 2 turns. (Type: N; Range: 0; Cost: 1; CD: 3; Prev. Skill: -)


###### Duelist
Tier 3. Previous Class: Mercenary. Main Stats: Str. <br>
Duelists focus their might on challenging enemies. <br>
* Challenge: Force an enemy to attempt to target you, if possible. (Type: ST; Range: 3; Cost: 3; CD: 2; Prev. Skill: -)
* Parry: Gain 1x stacks of Parry. (Type: N; Range: 0; Cost: 2; CD: 0; Prev. Skill: -)


###### Ranger
Tier 3. Previous Class: Mercenary. Main Stats: Dex. <br>
Rangers are fearsome hunters that specialize in ranged weaponry. <br>
* Great Aim: Increase the range of all attacks. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Twin Shot: Attack two targets at once. (Type: MT; Range: 3; Cost: 1; CD: 1; Prev. Skill: -)
* Track: Decrease the target's defenses. It cannot become invisible. (Type: ST; Range: 2; Cost: 1; CD: 1; Prev. Skill: -)
* Bear Trap: Drops a bear trap that gives 1x stack of Rooted to any character that enters its tile.


###### Bard
Tier 3. Previous Class: Rogue. Main Stats: Int. <br>
Control over performative arts gives Bards an edge on the battlefield. <br>
* Perform: Until the start of your next turn, buff allies/debuff enemies in a 3x3 radius around you. (Range: N; Cost: 3; CD: 3; Prev. Skill: -)


###### Cutthroat
Tier 3. Previous Class: Rogue. Main Stats: Dex. <br>
Cutthroats prefer to fight from the shadows and confuse the enemy. <br>
* Fire in the Hole: Throw a bomb that explodes in a 3x3 radius. If thrown at an enemy, explodes immediatly. If thrown at an empty tile, explodes at the start of your next round. (Type: ET/ST; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)


###### Bounty Hunter
Tier 4. Previous Class: Duelist. Main Stats: Str. <br>
Bounty hunters double down on locking down enemies with powerful moves. <br>
* Peekaboo: Gain 1x stacks of Parry. Until your next turn, if you are attacked, gain the 1x stacks of Invisibility. (Type: N; Range: 0; Cost: 1; CD: 0; Prev. Skill: -)
* Cash In: Defeating an enemy targetted with Challange restores 10% HP.
* Landmine: Drops a land mine that explodes in a 2x2 radius when any character enters its tile.


###### Vigilante
Tier 4. Previous Class: Duelist. Main Stats: Dex. <br>
Vigilantes turn an enemy's overwhelming numbers against them. <br>
* Underwhelming Odds: When a target is Challanged, they lose armor for each adjacent enemy. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Challenge II: Can challenge up to 2 enemies. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: Challenge)


###### Sharpshooter
Tier 4. Previous Class: Ranger. Main Stats: Int. <br>
Sharpshooters prefer to focus on a single target from afar. <br>
* Cracking Shot: Attacking the same enemy repeatedly increases damage. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Opressive Fire: Each consecutive attack on the same enemy deals 10% increased damage, up to a max of 50%. 


###### Gunner
Tier 4. Previous Class: Ranger. Main Stats: Dex. <br>
Gunners are great at crowd control and area denial. <br>
* Volley Shot: Deal sustained damage to enemies in an area. Lasts for 2 Rounds. (Type: AOE; Range: 3; Cost: 2; CD: 0; Prev. Skill: -)
* Point Blank Blast: Push an enemy 5 tiles back in a straight line. If it collides with something, it received 2x stacks of stunned. If it collides with a character, that character receives 1x stack of stunned. (Type: ST; Range: 1; Cost: 3; CD: 0; Prev. Skill: -)


###### Trickster
Tier 4. Previous Class: Bard. Main Stats: Dex. <br>
Tricksters use visual magic to disrupt the enemy line. <br>
* Decoy: Gain 1x Invisibility. Create a decoy that lasts one turn and deals damage if attacked. (Type: ET; Range: 2; Cost: 2; CD: 2; Prev. Skill: -)


###### Virtuoso
Tier 4. Previous Class: Bard. Main Stats: Int. <br>
Virtuosos use auditory magic to disable enemy forces. <br>
* Charm: Target enemy focuses other enemies during their next turn. (Type: ST; Range: 4; Cost: 1; CD: 1; Prev. Skill: -)


###### Slasher
Tier 4. Previous Class: Cutthroat. Main Stats: Str. <br>
Slashers are great at positioning themselves among the enemy, unnoticed. <br>
* Shadow Step: Gain double your movement speed when invisible. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Death Dash: Dash forward, becoming invisible and attacking all adjacent enemies in your path. The dash is 2 tiles long, but stops and reveals you if anything is in the way. (Type: ET; Range: 2; Cost: 3; CD: 3; Prev. Skill: -)


###### Assassin
Tier 4. Previous Class: Cutthroat. Main Stats: Dex. <br>
Assassins use patience to slowly but steadily deal massive damage. <br>
* Patience: The longer you under the effects of Invisibility, the stronger your next attack will be. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Opportunistic Strike: Deal more damage based on total modifier stacks the target has. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)


###### Veteran
Tier 5. Previous Class: Vigilante/Bounty Hunter. Main Stats: Dex/Str. <br>
Earning the title of Veteran is no easy feat, they are among the most experienced professionals available.  <br>
* Shiver: When an enemy is targetted by Challenge, it receives 2x stacks of Stupefied and 2x stacks of Vulnerable.


###### Sniper
Tier 5. Previous Class: Sharpshooter/Gunner. Main Stats: Dex/Int. <br>
Snipers are masters of ranged warfare under any circumstances. <br>
* One with the Hunt: While invisible, ranged skills don't cancel invisibility. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)
* Sweet Spot: Each attack applies 1x Vulnerable to the target.


###### Grand Performer
Tier 5. Previous Class: Trickster/Virtuoso. Main Stats: Dex/Int. <br>
Grand Performers can dazzle entire audiences with their brilliant performances. <br>
* Grand Delusion: All enemies under the effects of Perform will receive 3x Vulnerable and 1x Stunned.


###### Ninja
Tier 5. Previous Class: Slasher/Assassin. Main Stats: Dex/Str. <br>
Mysterious experts of stealth and subterfuge. <br>
Deadly Shade: While invisible, walking into a tile adjacent to an enemy automatically triggers an attack. This doesn't cancel invisibility. (Type: P; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)



***





#### Intelligence Tree

###### Mage
Tier 1. Previous Class: None. Main Stats: Int. <br>
Mage is the commonly used term for those with magical powers. <br>
* Magic Shot (ST): Shoot a magic bolt at a target.
* Teleport (ET): Instantly move a few tiles away. (Type: ST; Range: 3; Cost: 2; CD: 1; Prev. Skill: -)


###### Wizard
Tier 2. Previous Class: Mage. Main Stats: Int. <br>
Wizards specialize in manipulating the magic around them. <br>
* Magic Missiles (ST): Shoot 3 magic bolts at a target. (Type: ST; Range: 4; Cost: 2; CD: 1; Prev. Skill: Magic Shot)
* Slicing Disc: Summon a disc at locatin that deals damage to all adjacent characters.


###### Sorcerer
Tier 2. Previous Class: Mage. Main Stats: Int. <br>
Those that focus on their innate magic power are called Sorcerers. <br>
* Amplify Magic: The next spell cast doesn't cost speed.


###### Cleric
Tier 3. Previous Class: Wizard. Main Stats: Str. <br>
Communion with higher forces grants Clerics divine powers. <br>
* Holy Missiles: **Shoot 3 magic bolts at a target, deals extra damage to unholy creatures. (Type: ST; Range: 4; Cost: 2; CD: 1; Prev. Skill: Magic Missiles)


###### Seer
Tier 3. Previous Class: Wizard. Main Stats: Int. <br>
Seers are wise mages that often act as counselors for nobility. <br>
* Demoralizing Field: Apply vulnerable to all characters in a 2x2 radius.


###### Enhancer
Tier 3. Previous Class: Sorcerer. Main Stats: Dex. <br>
Enhancers focus their magic on improving their bodies' properties. <br>
* Amplify Magic II: The next spell cast doesn't cost speed and deals 2x damage.


###### Psychic
Tier 3. Previous Class: Sorcerer. Main Stats: Int. <br>
Psychics use magic to tap into the powers of the mind. <br>
* Mind Muscle: Push an enemy 3x tiles in any direction. If it collides with something, it receives 1x stacks of stunned. If it collides with another character, that character receives 1x stack of stunned.
* Force Field: Receive 2x stacks of Shield.


###### Inquisitor
Tier 4. Previous Class: Cleric. Main Stats: Str. <br>
Inquisitors relentlessly chase evil that needs to be rooted out. <br>


###### Priest
Tier 4. Previous Class: Cleric. Main Stats: Int. <br>
Priests are well-versed in esoteric knowledge and rituals. <br>


###### Elementalist
Tier 4. Previous Class: Seer. Main Stats: Dex. <br>
Elementalists are masters of nature's elements. <br>


###### Summoner
Tier 4. Previous Class: Seer. Main Stats: Int. <br>
Summoners invoke various creatures to reinforce their ally's numbers. <br>
* Scratching Pole: Summons a target that will taunt enemies into attacking. It detonates upon receiving damage.


###### Battlemage
Tier 4. Previous Class: Enhancer. Main Stats: Dex. <br>
Battlemages use magic to amplify their martial skills in combat. <br>
* Scorching Mana: Deals extra damage to nearby enemies.


###### Blaster
Tier 4. Previous Class: Enhancer. Main Stats: Int. <br>
Blasters are adept at using ranged spells and dealing damage. <br>
* Wild Efect: 30% chance to inflict either 1x stack of Vulnerable, 1x stack of Stunned or 1x stack of Slowed to any target.


###### Telekineticist
Tier 4. Previous Class: Psychic. Main Stats: Str. <br>
Telekineticists manipulate the world around them using their mind. <br>


###### Mesmerizer
Tier 4. Previous Class: Psychic. Main Stats: Int. <br>
Mesmerizers tap into the unconsciousness of living things, molding them to their advantage. <br>


###### Paragon
Tier 5. Previous Class: Inquisitor/Priest. Main Stats: Int/Str. <br>
Paragons are beacons of hope, their presence greatly inspires their allies in the battlefield. br>


###### Arch Wizard
Tier 5. Previous Class: Elementalist/Summoner. Main Stats: Int/Dex. <br>
Arch Wizards are wise and versatile, their knowledge allowing them to adapt to any situation. <br>


###### War Caster
Tier 5. Previous Class: Battlemage/Blaster. Main Stats: Int/Dex. <br>
War Casters combine their mastery over magic with incredible martial prowess. <br>


###### Mind Breaker
Tier 5. Previous Class: Telekineticist/Mesmerizer. Main Stats: Int/Str. <br>
Mind Breakers are adept at both instilling fear and bolstering morale. <br>

***





#### Strength Tree

###### Fighter
Tier 1. Previous Class: None. Main Stats: Str. <br>
Fighters are durable melee combatants. <br>
* Brace: Gain defense until the start of your next turn. Ends your turn. (Type: N; Range: 0; Cost: 0; CD: 0; Prev. Skill: -)


###### Warrior
Tier 2. Previous Class: Fighter. Main Stats: Str. <br>
Warriors are fighter with experience and refined techniques. <br>


###### Barbarian
Tier 2. Previous Class: Fighter. Main Stats: Str. <br>
Barbarians are relentless fighters with great might. <br>


###### Monk
Tier 3. Previous Class: Warrior. Main Stats: Dex. <br>
Monks abandon traditional weapons and armor in favor of a purer approach to combat. They develop intricate combos and can weave between skills. <br>


###### Knight
Tier 3. Previous Class: Warrior. Main Stats: Str. <br>
Knights employ expert use of equipment while in conflict. <br>
* Shield Bash: Inflict 1x stacks of stun.


###### Berserker
Tier 3. Previous Class: Barbarian. Main Stats: Str. <br>
Berserkers are fueled by pure, unadultered rage. <br>


###### Bloodrager
Tier 3. Previous Class: Barbarian. Main Stats: Int. <br>
Bloodragers use blood magic to enhance their physical prowess. <br>


###### Way of Water
Tier 4. Previous Class: Monk. Main Stats: Dex. <br>
Way of Water monks focus on dodging and flowing between enemies. <br>
* Freezing Palm: Inflicts 2x stacks of Frozen. Then, if the target has 3 or more stacks of Frozen, refund 1x Speed.


###### Way of Rock
Tier 4. Previous Class: Monk. Main Stats: Str. <br>
Way of Rock monks focus on withstanding hits and reverting them back. <br>


###### Mystic Knight
Tier 4. Previous Class: Knight. Main Stats: Int. <br>
Mystic Knights use defensive magic to enhance their combat abilities. <br>


###### Vanguard
Tier 4. Previous Class: Knight. Main Stats: Str. <br>
Vanguards focus on locking down and controlling an area. <br>


###### Executioner
Tier 4. Previous Class: Berserker. Main Stats: Str. <br>
Executioners specialize in taking down large threats. <br>


###### Battle Dancer
Tier 4. Previous Class: Berserker. Main Stats: Dex. <br>
Battle Dancers weave through the battlefield while attacking enemies. <br>


###### Brute
Tier 4. Previous Class: Bloodrager. Main Stats: Str. <br>
Brutes unleash rage more efficiently, turning them into formidable foes. <br>


###### Hemomancer
Tier 4. Previous Class: Bloodrager. Main Stats: Int. <br>
Hemomancers use advanced blood magic, using weakened enemies to their advantage. <br>


###### Grandmaster
Tier 5. Previous Class: Way of Water/Way of Rock. Main Stats: Str/Dex. <br>
Grandmasters are experts at turning the enemies' strength against them. <br>


###### Paladin
Tier 5. Previous Class: Mystic Knight/Vanguard. Main Stats: Str/Int. <br>
Paladins are holy knights that gained the favour of the god of war. <br>
* Lay On Hands: Restore a character's HP and remove all their debuffs. (Type: ST; Range: 1; Cost: 2; CD: 2; Prev. Skill: -)


###### Scourge
Tier 5. Previous Class: Executioner/Battle Dancer. Main Stats: Str/Dex. <br>
Scourges are brutal fighters that can deal and withstand massive amounts of damage. <br>


###### Reaver
Tier 5. Previous Class: Brute/Hemomancer. Main Stats: Str/Int. <br>
Reavers are frightening warriores that become stronger the longer the battle rages on.

***

***






#### Enemies


* Caves:
  * Rat - Runs at the closest player and attacks.
  * Spiderling - Fast, runs at the closest player and inflicts poison.
  * Spider - Shoots webs that inflict Root.
  * Bat - Fast, has high evasion.
  * Worm
  * Glow Worm
  * Ant
  * Slime
  * Mushroom - Shoots spores around it that inflict poison.
  * Undead Miner
  * Giant Mole
 <br>



* Forest:
  * Bear
  * Unicorn
  * Owl
  * Bees
  * Boar
  * Harpy
  * Rock Golem
  * Roc
  * Bigfoot
  * Chimera
  * Gorgon
  * Griffin
  * Fae
  * Werewolf
  * Ent
  * Honeybadger
  * Giant Mantis
<br>



* Desert:
   * Scorpion
   * Acid scorpion
   * Wheel Spider
   * Cobra
   * Cactus Monster
   * Bandits/ Sandbenders
   * Mummy
   * Sand Digger 
   * Coyote
   * Sand Spirit
   * Tarantula Hawk
   * Sandspitter
   * Djinn
   * Sphynx
   * Tomb Mimic
   * Lizard
   * Sand Shark
<br>


* Volcanic:
  * Volcanic Snail
  * Lava Monster
  * Imps
  * Exploder
  * Magma Spitter
  * Fire Hound
  * Volcano Slime
  * Lava Crab
  * Wandering Volcano
  * Effigy
  * Ash Zombie
  * Dragon
  * Oni
  * Lava Strider - Spider than can run across lava pools.
<br>


* Snow:
  * Yeti
  * Sea Leopard
  * Walrus
  * Polar Bear
  * Snowman
  * Yuki-onna
  * Reindeer
  * Ice Elemental
  * Snow Harpy
  * Ice Spider
  * Ice Devil
  * Frost Walker - Walks slowly, but randomly sprints to the nearest playeand freezes them.
  * Snow Jellyfish
  * Crab
<br>


* Swamp/Poison:
  * Poison Toad
  * Vine Monster
  * Wasp
  * Mosquito
  * Mud Monster
  * Witch
  * Leech
  * Rotten Slime
  * Giant slug
  * Will o'Wisp
  * Corrupted Ent
  * Cultists
<br>


* Ghost
  * Lich
  * Skeleton Spider
  * Ghost
  * Zombie
  * Skeleton
  * Bone Snake
  * Giant Rat
  * Dungeon Slime - Large and fills enclosed spaces, moves slowly.
<br>


* Jungle:
  * Tarantula
  * Anaconda
  * Viper
  * Piranha
  * Wasp
  * Moss Monster
  * Panther
  * Tiger
  * Clay Golem
  * Carnivorous Plant
  * Giant Tortoise
  * Tiki Head
  * Monkey - Steals items
  * Gorilla
  * Poisonous Plant
  * Giant Centipede
<br>


* Royal/Sky:
  * Cherub
  * Hollow Armor
  * Wyvern
  * Holy Wisp
  * Flying Fish
  * Pegasus
<br>




***

***


#### Modifiers

Modifiers are all kinds of buffs/debuffs. They work around a system of stacks: each stack generally represents one use of the modifier.
Modifiers do not stack beyond their max value. A modifier's effects can increase depending on the amount of stacks.
Resistance to debuffs is represented through the amount of stacks a character loses on turn start (Ex: a character with 3x stun resistance will need 4x stun to be stunned for 1x turn).
At the start of each character's turn, a character loses stacks equal to their resistence to that specific modifier.  
If the same modifiers are stackable, the highest stack value will apply (ex. 2x fire vs 3x fire = 3x fire).
If the same modifiers are not stackable, the one with the highest total stacks will be applied, instead of added. 
If opposite modifiers are not stackable, the last modifier is applied.
Depending on the amount of stacks, the effects of the modifiers may change.


##### Buffs

* Invisibility:
  * 0-2 stacks: You are untargetable, but can still be damaged by certain attacks.
  * 3-4: You are untargetable, and are invulnerable to all damage.

* Shielded:
  * 0-2 stacks: The next damage instance received will consume a stack and deal no damage.
  * 3-4 stacks: The next damage instance received will consume a stack and deal no damage, or 3 stacks and apply no negative modifiers.

* Parry:
  * 1 stack: The next time a damage instance received will consume a stack and automatically use a weapon attack against the attacker, if adjacent.
  * 2-3 stacks: The next time a damage instance received will consume a stack and automatically use a weapon attack against the attacker, if adjacent. You will be dealt no damage.

* Speedy:
  * 0-2 stacks: Movement Speed increased by Total Stacks.
  * 3-4 stacks: Movement Speed increased by Total Stacks. You can move to 1 tile for free.

* Inspired:
  * 0-2: The next attack will deal Total Stacks *10 % more damage.




##### Debuffs

* On Fire:
  * 0-2 stacks: Receive damage at the end of your turn.
  * 3-4 stacks: Receive damage at the end of your turn. Adjacent characters have a chance to catch on fire. 

* Bleed:
  * 0-2 stacks: Take 6% of your HP as damage at the end of your turn, rounded up.
  * 3-5 stacks: Take 10% of your HP as damage at the end of your turn, rounded up.

* Poison: Receive small instances of damage at the start of your turn.

* Toxic: Receive damage at the start of your turn.

* Stunned (Max 2 stacks): Skip the next turn.

* Slowed:
  * 0-2 stacks: Movement Speed reduced by Total Stacks.
  * 3-4 stacks: Movement Speed reduced by Total Stacks. The first action each turn costs 1 action point more.

* Charmed: Will attack a random ally during the next turn.

* Stupefied: Accuracy reduced by 10% * Total Stacks.

* Vulnerable: Damage taken is amplified by 10% * Total Stacks.

* Rooted: Cannot move.

* Electrified:
  * 0-2 stacks: Take damage for each tile moved.
  * 3-4 stacks: Take damage for each tile moved. If you enter a body of water, you take 2 * damage, and anyone also in the body of water will take 1 * damage.

* Feeble (Max 5 stacks): Lose 1 * Total Stacks STR.

* Sluggish (Max 5 stacks): Lose 1 * Total Stacks DEX.

* Lethargic (Max 5 stacks): Lose 1 * Total Stacks INT.

* Explosive (Max 3 stacks): Explodes in a radius equal to Total Stacks. All stacks disappear after exploding.

* Frozen:
  * 0-2 stacks: Cannot attack or cast spells.
  * 3 stacks: Skip your next turn.
  * 4 stacks: Skip your next turn. The next attack you receive deals 2x damage.

 * Forgetful:
   * 1-2 stacks: Cannot use items.

* Slippery:
  * 1-2 stacks: Chance to move to a random tile instead of the targeted one.




### Weapons
Characters depend on their class to determine what kind of weapons they can use.
Each weapon has a different tile pattern in which they can attack. This is unique for each weapon.
In the diagrams below, "O" represents your character, "X" represents attackable tiles, and "_" represents non-attackable tiles.

* Sword: <br>
_ X _ <br>
X O X <br>
_ X _ <br>

* Axe: <br>

* Spear: <br>

* Hammer: <br>

* Whip: <br>

* Bow: <br>

* Longbow: <br>

* Dagger: <br>




## The Hub:

The Character's have set up a camp at the dungeon's entrance. A mysterious altar is the only nearby structure.
Before venturing into the dungeon, Characters rest at the Hub, where utilities and services are provided.
***Is is walled off by decaying ruins, with 3 entrances: A large one South, and two smaller ones East and West.***

Throughout the game, Materials and Gold can be collected in order to upgrade the Hub.
The Hub is composed of a 7x7 grid, where structures can be placed and built. 
Most structures are limited to 1, except Houses.
Heroes living in the Hub can be placed in the grid. This is their position during Sieges.

Occasionally, the Hub may be raided by outsiders, trying to pillage the valueable loot you are discovering.
This is a regular combat instance, using the Hub's layout for the map.
All present Characters take part in the raid. 
The opponent will attempt to attack your structures and steal your loot. 
NPCs in building react to being attacked and say a funny remark when you mouse over them.
After the first Raid, players may construct Defensive structures in the Hub.

***


### Structures

The Structures buildable in the Hub are as follows, in the order in which they appear:

* Dungeon Entrance:
Used to delve into the Dungeon with a Party.
Allows the selection of up to 4 Heroes.

* Mysterious Shrine: 
***This structure is only a visual indicator of progress through the dungeon's floors.***
This structure is present from the beggining of the game in a preset position and cannot be upgraded.
***If it is destroyed during a siege, you get a Game Over.***
***It changes its appearence as you delve deeper into the dungeons.***

* Caravan/Town Hall:
Manage your Heroes and Parties.
When the game starts, position the Caravan for free on any Hub tile.
Recruit new Heroes that appear ***after each dungeon.***
Dismiss current Heroes.
Upgrades allow better Heroes to show up, ***based on the average Hero level.***

* Merchant:
Buy/sell items found throughout the Dungeon for gold.
Buy weaker items that may be inconvenient to farm (potions, low tier materials, etc).
Sell your unwanted items for gold.
Upgrades unlock better items, lower prices and more gold for your items.

* Blacksmith: 
Craft/Upgrade equipment for your Heroes. 
Existing equipment can be upgraded.
Certain materials may be used to craft specific equipment.
Must be upgraded for each Level Tier.

* Barracks: 
Purchase/Upgrade skills for your Heroes.
Must be upgraded for each Level Tier.

* House:
Housing for Heroes. 
Each house allows 4 heroes to move into the Hub. They must be allocated to a specific House.
By default, up to 4 heroes can live in the Hub without any Houses.
Heroes allocated to a House and not in a dungeon recover 25% of their HP.
Each House allows 10 items to be stored.
By default, up to 10 items can be stored with a House.
When attacked during a raid, progressively drops random items from the storage. If it is destroyed, it must be repaired before storing further items.
Up to 4 Houses can be built.
Upgrades increase the HP heroes restore and the max item storage.

* Tavern: 
Provides different Buffs to Heroes going into the Dungeon.
Certain ingredients can be used to make potions/edible items that Heroes can take into the Dungeon.
Upgrades provide better/cheaper buffs, and better recipes for cooking.

* Siege Factory:
Used to construct defensive buildings like catapults and trebuchets.
These structures help defend the Hub during sieges.
Build gates and fortify the Hub's walls.
Decrease chance of being raided and increase raid cooldown.
Upgrades allow better siege structures to be built.

* Hospital:
Remove certain debuffs from Heroes.
Heal Heroes to full health in exchange for gold. 
Add a passive HP heal to all heroes not in a dungeon.
Upgrades reduce treatment costs and allow deadlier conditions to be treated.

* Church: 
Use certain items to allow characters to change their builds.
The more radical the change, the more expensive the item/gold cost.
In ascending order of cost: Skills -> Class -> Attribute Tree.
Upgrades allow the more expensive changes to be undertaken.

* ***Bank:***
Gain gold interest over time.

*** ***Fence:***
Sometimes, you can find their Henchmen that help you throughout the dungeon.

***


### NPCs

NPCs are characters that you will meet throughout the game. 

* Stair Guy: A mysterious figure that appears at inconvenient moments when traversing between locations. Will often offer help, but in a roundabout way. Fighting him is often hopeless, most likely resulting in one or more party member's deaths. The best way to approach him is by using dialogue and paying attention to the nuances of his conversation. 






## Dungeon Crawling:



***



#### Dungeon Levels

***

***










## Combat Instance:

***

***




## Items:

* Return Stone: Lets you forfeit a dungeon and return to the Hub.
* Potions: Potions provide different types of effects. They have an expiration date based on total turns taken without consuming them.




## Ideas:

* Certain challenges or achievements are presented to the player, which may unlock new content.
* Different endings.
* Potions have expiration dates.
* Karma system.

***

***








## Glossary:

Relevant concepts:
* APT: Actions Per Turn
* Attribute
* Class
* Character
* Combat
* Hub
* HP: Health Points
* Raid
* Stat
* XP: Experience Points

***

***










## References:

* [Syntax Tutorial](https://www.markdownguide.org/basic-syntax/)

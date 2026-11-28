-- WoW Forever consumable stacking (wowsims/forever, MIT, docs/rulings R-0054, evidence EV-0185, in-game checks of 23-24 Nov):
-- any number of elixirs and scrolls can be up at once, but each stat counts only its strongest elixir, scroll, Juju or raid buff
-- (Arcane Intellect, Power Word: Fortitude, Divine Spirit and their group forms overwrite the elixirs and scrolls of their stat;
-- Mark of the Wild, Blessing of Kings, Battle Shout and totems stack with them). One flask at a time, and flasks stack with
-- elixirs. The Blasted Lands buffs and Spirit of Zanza are one group. Scrolls of different stats now stack (SpellInfo.cpp no
-- longer makes SPELL_SPECIFIC_SCROLL exclusive). Aura types read from the 70707+ client SpellEffect.db2. Safe to run again.
--
-- 1400920 (rule 3, exclusive same effect, pinned to SPELL_AURA_MOD_STAT in SpellMgr::LoadSpellGroupStackRules): each stat
-- counts once, at the highest amount, whatever other effects the auras carry (Elixir of Ferocity beside Elixir of the Mongoose
-- keeps its Strength and adds no Agility). The 2% elixir crit stays in 1400910 (2026_11_18_03).
DELETE FROM `spell_group` WHERE `id` BETWEEN 1400920 AND 1400926;
INSERT INTO `spell_group` (`id`,`spell_id`) VALUES
-- elixirs: Minor Strength, Minor Agility, Lesser Agility, Ogre Strength, Wisdom, Giant Growth, Agility, Greater Agility,
-- Greater Intellect, Greater Strength, the Sages (old), Brute Force, the Mongoose
(1400920,2367),(1400920,2374),(1400920,3160),(1400920,3164),(1400920,3166),(1400920,8212),(1400920,11328),(1400920,11334),
(1400920,11396),(1400920,11405),(1400920,17535),(1400920,17537),(1400920,17538),
-- Forever elixirs: Cunning, the Owl, Sages, Minor/Lesser/plain/Greater Spirit, the Whale, Strength, Ferocity, the Grizzly,
-- Lesser Intellect, Intellect
(1400920,1250918),(1400920,1250940),(1400920,1250941),(1400920,1250974),(1400920,1250976),(1400920,1250978),(1400920,1250979),
(1400920,1250981),(1400920,1250984),(1400920,1250985),(1400920,1250986),(1400920,1250988),(1400920,1250989),
-- Juju Power
(1400920,16323),
-- scrolls I-IV: Intellect, Stamina, Spirit, Agility, Strength
(1400920,8096),(1400920,8097),(1400920,8098),(1400920,12176),
(1400920,8099),(1400920,8100),(1400920,8101),(1400920,12178),
(1400920,8112),(1400920,8113),(1400920,8114),(1400920,12177),
(1400920,8115),(1400920,8116),(1400920,8117),(1400920,12174),
(1400920,8118),(1400920,8119),(1400920,8120),(1400920,12179),
-- raid buffs that overwrite them: Arcane Intellect 1-5 and Arcane Brilliance, Power Word: Fortitude 1-6 and Prayer of
-- Fortitude 1-2, Divine Spirit 1-4 and Prayer of Spirit
(1400920,1459),(1400920,1460),(1400920,1461),(1400920,10156),(1400920,10157),(1400920,23028),
(1400920,1243),(1400920,1244),(1400920,1245),(1400920,2791),(1400920,10937),(1400920,10938),(1400920,21562),(1400920,21564),
(1400920,14752),(1400920,14818),(1400920,14819),(1400920,27841),(1400920,27681),
-- 1400921 (rule 1): Zanza, the Blasted Lands buffs (R.O.I.D.S., Lung Juice Cocktail, Ground Scorpok Assay, Cerebral Cortex
-- Compound, Gizzard Gum; both spell ids of each) and Spirit of Zanza, one at a time
(1400921,10667),(1400921,10668),(1400921,10669),(1400921,10670),(1400921,10671),(1400921,10672),(1400921,10690),(1400921,10691),
(1400921,10692),(1400921,10693),(1400921,24382),
-- 1400922 (rule 1): one flask, the four vanilla flasks (also kept in groups 1 and 2) and the Natural flasks
(1400922,17626),(1400922,17627),(1400922,17628),(1400922,17629),
(1400922,1293740),(1400922,1293741),(1400922,1293742),(1400922,1293743),
-- 1400923 (rule 4): maximum health, Elixir of Minor/Lesser Fortitude, Fortitude, Greater Fortitude, the Phalanx
(1400923,2378),(1400923,3593),(1400923,1250928),(1400923,1250931),(1400923,1250920),
-- 1400924 (rule 4): healing, Minor/Lesser/plain/Greater Cleric's Elixir
(1400924,1250922),(1400924,1250924),(1400924,1250925),(1400924,1250926),
-- 1400925 (rule 4): mana every 5 seconds, Mageblood Elixir and Minor/Lesser/Greater Mageblood (Mana Spring Totem stacks)
(1400925,24363),(1400925,1250942),(1400925,1250944),(1400925,1250948),
-- 1400926 (rule 4): physical damage, Elixir of Minor Force and Bogling Root
(1400926,1245249),(1400926,5665);

DELETE FROM `spell_group_stack_rules` WHERE `group_id` BETWEEN 1400920 AND 1400926;
INSERT INTO `spell_group_stack_rules` (`group_id`,`stack_rule`) VALUES
(1400920,3),(1400921,1),(1400922,1),(1400923,4),(1400924,4),(1400925,4),(1400926,4);

-- Armor (1400190, rule 4) gains Elixir of the Phalanx (500 armor beside its 400 health); spell damage of every school
-- (1400191, rule 4) gains Minor Arcane Elixir and Lesser Arcane Elixir.
DELETE FROM `spell_group` WHERE (`id` = 1400190 AND `spell_id` = 1250920) OR (`id` = 1400191 AND `spell_id` IN (1245244,1250971));
INSERT INTO `spell_group` (`id`,`spell_id`) VALUES (1400190,1250920),(1400191,1245244),(1400191,1250971);

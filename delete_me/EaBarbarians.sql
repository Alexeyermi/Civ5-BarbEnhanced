
CREATE TABLE EaEncampments ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,
							'Type' TEXT NOT NULL UNIQUE,
							'Description' TEXT DEFAULT NULL,			--This is tribe adjective to use; leave null to get adjective from EaBarbTribes
							'TribeAdjective' TEXT DEFAULT NULL,			--leave null to get adjective and encampment name from EaEncampments_TribeAdjectives table
							'UsePirateUnitNaming' BOOLEAN DEFAULT NULL,
							'PrereqTech' TEXT DEFAULT NULL,
							'RequiresCoastal' BOOLEAN DEFAULT NULL,	
							'UseWorldDensity' BOOLEAN DEFAULT NULL,			--rather than area density (used for sea units)
							'RequiredResource' TEXT DEFAULT NULL,
							'ResourceWeight' INTEGER DEFAULT 10,			--counts as this many plot specials
							'AdHocScore' INTEGER DEFAULT 0,			
							'NearbyPlotSpecial1' TEXT DEFAULT NULL,			--see types in EaBarbarians.lua
							'NearbyPlotSpecial2' TEXT DEFAULT NULL,
							'NearbyPlotSpecial3' TEXT DEFAULT NULL,
							'NearbyPlotSpecial4' TEXT DEFAULT NULL);

INSERT INTO EaEncampments (Type, Description,							TribeAdjective,						NearbyPlotSpecial1,	NearbyPlotSpecial2,	NearbyPlotSpecial3	) VALUES
('EA_ENCAMPMENT_WILDMEN',		'TXT_KEY_EA_ENCAMPMENT_WILDMEN',		'TXT_KEY_EA_ENCAMPMENT_WILDMEN_ADJ','Cold',				'Sea',				NULL				),
('EA_ENCAMPMENT_HORSETRIBE',	'TXT_KEY_EA_ENCAMPMENT_HORSETRIBE',		NULL,								'Flatland',			NULL,				NULL				),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'TXT_KEY_EA_ENCAMPMENT_ELEPHANTTRIBE',	NULL,								'Flatland',			'Forest',			'Jungle'			),	--should get it in most cases near plot resource
('EA_ENCAMPMENT_PIRATES',		'TXT_KEY_EA_ENCAMPMENT_PIRATES',		'TXT_KEY_EA_ENCAMPMENT_PIRATES_ADJ','Sea',				NULL,				NULL				),	
('EA_ENCAMPMENT_ORCS',			'TXT_KEY_EA_ENCAMPMENT_ORCS',			NULL,								'Jungle',			'Forest',			NULL				),	
('EA_ENCAMPMENT_OGRES',			'TXT_KEY_EA_ENCAMPMENT_OGRES',			NULL,								'Desert',			NULL,				NULL				);

UPDATE EaEncampments SET RequiresCoastal = 1, UseWorldDensity = 1, PrereqTech = 'TECH_SAILING', AdHocScore = 15 WHERE Type = 'EA_ENCAMPMENT_PIRATES';
UPDATE EaEncampments SET RequiredResource = 'RESOURCE_HORSE' WHERE Type = 'EA_ENCAMPMENT_HORSETRIBE';
UPDATE EaEncampments SET RequiredResource = 'RESOURCE_ELEPHANT' WHERE Type = 'EA_ENCAMPMENT_ELEPHANTTRIBE';

CREATE TABLE EaEncampments_Upgrades ('EncampmentType' TEXT NOT NULL, 'UpgradeType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_Upgrades (EncampmentType,	UpgradeType) VALUES
('EA_ENCAMPMENT_WILDMEN',		'EA_ENCAMPMENT_PIRATES'),
('EA_ENCAMPMENT_HORSETRIBE',	'EA_ENCAMPMENT_PIRATES'),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'EA_ENCAMPMENT_PIRATES');

CREATE TABLE EaEncampments_TechAwardByTurn ('TechType' TEXT NOT NULL, 'Turn' INTEGER NOT NULL UNIQUE);
--This table can force an encampment upgrade (or base or roaming unit upgrade) as if barbs have learned a tech (barbs don't really learn tech but actual barb techs have no effect in mod anyway)

INSERT INTO EaEncampments_TechAwardByTurn (TechType,	Turn) VALUES
('TECH_ARCHERY',		60),	--WARNING! Due to lazy implementation, Turn values must be unique integers
('TECH_BRONZE_WORKING',	70),	--Values are for Quick speed and Small/Tiny/Dual map; multipliers are:
('TECH_SAILING',		80),	--	Speed: Standard 1.5; Epic 2; Marathon 3
('TECH_MILLING',		90),	--  Size:  Standard 1.1; Large 1.2; Huge 1.3
('TECH_ALCHEMY',		120),
('TECH_IRON_WORKING',	130),
('TECH_CHEMISTRY',		140),
('TECH_WAR_HORSES',		150),
('TECH_SHIP_BUILDING',	160),
('TECH_WAR_ELEPHANTS',	170),
('TECH_BOWYERS',		180),
('TECH_NAVIGATION',		190),
('TECH_MACHINERY',		200),
('TECH_BEAST_BREEDING',	250);


/*
CREATE TABLE EaBarbTribes (	'ID' INTEGER PRIMARY KEY AUTOINCREMENT,
							'Type' TEXT NOT NULL UNIQUE,
							'Description' TEXT DEFAULT NULL,
							'EaEncampmentType' TEXT NOT NULL);

INSERT INTO EaBarbTribes (Type,	Description,	EaEncampmentType) VALUES
('EABARBTRIBE_CIMMERIAN',	'TXT_KEY_EABARBTRIBE_CIMMERIAN',	'ENCAMPMENT_BARBARIANS'),
('EABARBTRIBE_KHAZAR',		'TXT_KEY_EABARBTRIBE_KHAZAR',		'ENCAMPMENT_HORSETRIBE'),
('EABARBTRIBE_AB',			'TXT_KEY_EABARBTRIBE_AB',			'ENCAMPMENT_ELEPHANTTRIBE');


CREATE TABLE EaEncampments_TribeAdjectives ('EncampmentType' TEXT NOT NULL, 'Adjective' TEXT DEFAULT NULL, 'EncampmentName' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_TribeAdjectives (EncampmentType,	Adjective) VALUES
('ENCAMPMENT_BARBARIANS',	'Cimmerian'),
('ENCAMPMENT_HORSETRIBE',	'Khazar'),
('ENCAMPMENT_ELEPHANTTRIBE',	'Ab');
UPDATE EaEncampments_TribeAdjectives SET EncampmentName = 'TXT_KEY_EA_ENCAMPMENT';	--could use this to replace "Uygur Encampment" with "Uygur Settlement" or whatever
*/

--Order matters for the next 3 tables! The 1st and 2nd units encountered (and allowed by known techs) will be used for each given encompement type

CREATE TABLE EaEncampments_BaseUnits ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_BaseUnits (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_WILDMEN',		'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_WILDMEN',		'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_WILDMEN',		'UNIT_WARRIORS_BARB',			NULL					),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_LIGHT_INFANTRY_MAN',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_ARCHERS_MAN',				'TECH_ARCHERY'			),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_WARRIORS_MAN',			NULL					),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_LIGHT_INFANTRY_MAN',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_ARCHERS_MAN',				'TECH_ARCHERY'			),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_WARRIORS_MAN',			NULL					),
('EA_ENCAMPMENT_PIRATES',		'UNIT_ARQUEBUSSMEN_MAN',		'TECH_MACHINERY'		),
('EA_ENCAMPMENT_PIRATES',		'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_PIRATES',		'UNIT_CROSSBOWMEN_MAN',			'TECH_MILLING'			),
('EA_ENCAMPMENT_PIRATES',		'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_PIRATES',		'UNIT_ARCHERS_BARB',			'TECH_SAILING'			),		--looks strange, but barb known tech needed here to trigger base unit update with encampment update
('EA_ENCAMPMENT_ORCS',			'UNIT_WARRIORS_ORC',			NULL					),
('EA_ENCAMPMENT_OGRES',			'UNIT_OGRES',					NULL					);

--Lua assumes that roaming and sea units have unique association back to a specific encampmentID (unlike base units and their upgrades)
CREATE TABLE EaEncampments_RoamingUnits ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_RoamingUnits (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_WILDMEN',		'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_WILDMEN',		'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_WILDMEN',		'UNIT_WARRIORS_BARB',			NULL					),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_SAGITARII_MAN',			'TECH_MACHINERY'		),	--seems weird but we just need a high level tech
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_BOWED_CAVALRY_MAN',		'TECH_BOWYERS'			),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_EQUITES_MAN',				'TECH_WAR_HORSES'		),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_HORSE_ARCHERS_MAN',		'TECH_ARCHERY'			),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_HORSEMEN_MAN',			NULL					),	--Replace with BNW's UNIT_BARBARIAN_HORSEMAN below
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_MUMAKIL',					'TECH_BEAST_BREEDING'	),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_WAR_ELEPHANTS',			'TECH_WAR_ELEPHANTS'	),
('EA_ENCAMPMENT_ELEPHANTTRIBE',	'UNIT_MOUNTED_ELEPHANTS',		NULL					),
('EA_ENCAMPMENT_ORCS',			'UNIT_WARRIORS_ORC',			NULL					),
('EA_ENCAMPMENT_OGRES',			'UNIT_OGRES',					NULL					);


CREATE TABLE EaEncampments_SeaUnits ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_SeaUnits (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_PIRATES',		'UNIT_GALLEONS',				'TECH_NAVIGATION'		),		
('EA_ENCAMPMENT_PIRATES',		'UNIT_QUINQUEREMES',			'TECH_SHIP_BUILDING'	),		
('EA_ENCAMPMENT_PIRATES',		'UNIT_CARRACKS',				'TECH_CHEMISTRY'		),		
('EA_ENCAMPMENT_PIRATES',		'UNIT_TRIREMES',				'TECH_IRON_WORKING'		),	
('EA_ENCAMPMENT_PIRATES',		'UNIT_DROMONS',					'TECH_ALCHEMY'			),		
('EA_ENCAMPMENT_PIRATES',		'UNIT_BIREMES',					'TECH_BRONZE_WORKING'	),		
('EA_ENCAMPMENT_PIRATES',		'UNIT_GALLEYS_PIRATES',			NULL					);


INSERT INTO EaDebugTableCheck(FileName) SELECT 'EaBarbarians.sql';

--UPDATE EaEncampments_RoamingUnits SET UnitType = 'UNIT_BARBARIAN_HORSEMAN' WHERE UnitType = 'UNIT_HORSEMAN' AND 'UNIT_BARBARIAN_HORSEMAN' IN (SELECT Type FROM Units);


CREATE TABLE EaEncampments ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,
							'Type' TEXT NOT NULL UNIQUE,
							'Description' TEXT DEFAULT NULL,
							'CivAdjective' TEXT DEFAULT NULL,
							'PrereqTech' TEXT DEFAULT NULL,
							'UpgradeFrom' TEXT DEFAULT NULL,	--only if PrereqTech; the UpgradeFrom type will inherit plot preferences until then
							'BaseUnitType' TEXT NOT NULL,
							'RequiresCoastal' BOOLEAN DEFAULT NULL,	
							'RequiredResource' TEXT DEFAULT NULL,
							'NearbyPlotSpecial1' TEXT DEFAULT NULL,	--see types in EaBarbarians.lua
							'NearbyPlotSpecial2' TEXT DEFAULT NULL,
							'NearbyPlotSpecial3' TEXT DEFAULT NULL,
							'NearbyPlotSpecial4' TEXT DEFAULT NULL);

INSERT INTO EaEncampments (Type, Description,						CivAdjective,							PrereqTech,				UpgradeFrom,				BaseUnitType,			NearbyPlotSpecial1,	NearbyPlotSpecial2,	NearbyPlotSpecial3,	NearbyPlotSpecial4) VALUES
('EA_ENCAMPMENT_ORCS',			'TXT_KEY_EA_ENCAMPMENT_ORCS',		'TXT_KEY_EA_ENCAMPMENT_ORCS_ADJ',		NULL,					NULL,						'UNIT_WARRIORS_ORC',	'Forest',			'Jungle',			'Hills',			'Mountain'			),
('EA_ENCAMPMENT_OGRES',			'TXT_KEY_EA_ENCAMPMENT_OGRES',		NULL,									NULL,					NULL,						'UNIT_OGRES',			'Desert',			NULL,				NULL,				NULL				),
('EA_ENCAMPMENT_BARBARIANS',	'TXT_KEY_EA_ENCAMPMENT_BARBARIANS',	'TXT_KEY_EA_ENCAMPMENT_BARBARIANS_ADJ',	NULL,					NULL,						'UNIT_WARRIORS_BARB',	'Cold',				NULL,				NULL,				NULL				),
('EA_ENCAMPMENT_HORSETRIBE',	'TXT_KEY_EA_ENCAMPMENT_HORSETRIBE',	'TXT_KEY_EA_ENCAMPMENT_HORSETRIBE_ADJ',	'TECH_HORSEBACK_RIDING','EA_ENCAMPMENT_BARBARIANS',	'UNIT_WARRIORS_BARB',	'Flatland',			NULL,				NULL,				NULL				),
('EA_ENCAMPMENT_PIRATES',		'TXT_KEY_EA_ENCAMPMENT_PIRATES',	'TXT_KEY_EA_ENCAMPMENT_PIRATES_ADJ',	'TECH_SAILING',			'EA_ENCAMPMENT_BARBARIANS',	'UNIT_WARRIORS_BARB',	'Sea',				NULL,				NULL,				NULL				);

UPDATE EaEncampments SET RequiresCoastal = 1 WHERE Type = 'EA_ENCAMPMENT_PIRATES';
UPDATE EaEncampments SET RequiredResource = 'RESOURCE_HORSE' WHERE Type = 'EA_ENCAMPMENT_HORSETRIBE';

--Order matters for all 3 tables below. The 1st and 2nd units encountered and allowed by techs for a given encompement will be used

--Upgrades are to the BaseUnitType
CREATE TABLE EaEncampments_Upgrades ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_Upgrades (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_ARCHERS_BARB',			'TECH_ARCHERY'			),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_ARCHERS_BARB',			'TECH_ARCHERY'			),
('EA_ENCAMPMENT_PIRATES',		'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_PIRATES',		'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	);

--Lua assumes that roaming and sea units have unique association back to a specific encampmentID (unlike base units and their upgrades)
CREATE TABLE EaEncampments_RoamingUnits ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_RoamingUnits (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_ORCS',			'UNIT_WARRIORS_ORC',			NULL					),
('EA_ENCAMPMENT_OGRES',			'UNIT_OGRES',					NULL					),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_MEDIUM_INFANTRY_BARB',	'TECH_IRON_WORKING'		),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_ARCHERS_BARB',			'TECH_ARCHERY'			),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_LIGHT_INFANTRY_BARB',		'TECH_BRONZE_WORKING'	),
('EA_ENCAMPMENT_BARBARIANS',	'UNIT_WARRIORS_BARB',			NULL					),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_EQUITES_MAN',				'TECH_WAR_HORSES'		),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_BOWED_CAVALRY_MAN',		'TECH_BOWYERS'			),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_HORSEMEN_MAN',			'TECH_HORSEBACK_RIDING'	),
('EA_ENCAMPMENT_HORSETRIBE',	'UNIT_HORSE_ARCHERS_MAN',		'TECH_ARCHERY'			);


CREATE TABLE EaEncampments_SeaUnits ('EncampmentType' TEXT NOT NULL, 'UnitType' TEXT NOT NULL, 'TechType' TEXT DEFAULT NULL);
INSERT INTO EaEncampments_SeaUnits (EncampmentType,	UnitType,	TechType) VALUES
('EA_ENCAMPMENT_PIRATES',	'UNIT_GALLEYS_PIRATES',		'TECH_SAILING');





INSERT INTO EaDebugTableCheck(FileName) SELECT 'EaBarbarians.sql';
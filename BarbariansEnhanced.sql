-- Barbarians Enhanced
-- Author: Nutty
--------------------------------------------------------------
UPDATE Defines
	SET Value = -1
	WHERE Name = 'BARBARIAN_MAX_XP_VALUE';	--unlimited experience from barbs [will only apply to terrorists?]

CREATE TABLE MinorCivBarbarians (
	'Type' TEXT NOT NULL UNIQUE,
	'Description' TEXT,
	'Civilopedia' TEXT,
	'ShortDescription' TEXT,
	'Adjective' TEXT,
	'ArtDefineTag' TEXT,
	'DefaultPlayerColor' TEXT DEFAULT NULL,
	'ArtStyleType' TEXT DEFAULT NULL,
	'ArtStyleSuffix' TEXT DEFAULT NULL,
	'ArtStylePrefix' TEXT default NULL,
	'MinorCivTrait' TEXT NOT NULL,
	FOREIGN KEY (Description) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (Civilopedia) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (ShortDescription) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (Adjective) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (MinorCivTrait) REFERENCES MinorCivTraits(Type));
INSERT INTO MinorCivBarbarians (
	Type, Description, Civilopedia, ShortDescription, Adjective, ArtDefineTag, DefaultPlayerColor, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
	SELECT DISTINCT 'MINOR_CIV_BARBARIAN' || SUBSTR(CityName, 18), CityName, CityName, CityName, CityName,
	'ART_DEF_CIVILIZATION_BARBARIAN', 'PLAYERCOLOR_BARBARIAN', 'ARTSTYLE_BARBARIAN', '_AFRI', 'AFRICAN', 'MINOR_TRAIT_BARBARIAN'
	FROM Civilization_CityNames	WHERE CivilizationType = 'CIVILIZATION_BARBARIAN' ORDER BY RANDOM();
DELETE FROM MinorCivBarbarians
	WHERE Type IN (
	'MINOR_CIV_BARBARIAN_ASSYRIAN',
	'MINOR_CIV_BARBARIAN_HUN',
	'MINOR_CIV_BARBARIAN_OLMEC',
	'MINOR_CIV_BARBARIAN_PHEONICIAN',
	'MINOR_CIV_BARBARIAN_POLYNESIAN');
--UPDATE MinorCivBarbarians
--	SET ArtStyleSuffix = '_AFRI', ArtStylePrefix = 'AFRICAN'
--	WHERE Type IN (
--	'MINOR_CIV_BARBARIAN_ARYAN',
--	'MINOR_CIV_BARBARIAN_AVAR',
--	'MINOR_CIV_BARBARIAN_BACTRIAN',
--	'MINOR_CIV_BARBARIAN_BANTU',
--	'MINOR_CIV_BARBARIAN_CIRCASSIAN',
--	'MINOR_CIV_BARBARIAN_CUMAN',
--	'MINOR_CIV_BARBARIAN_GHUZZ',
--	'MINOR_CIV_BARBARIAN_HITTITE',
--	'MINOR_CIV_BARBARIAN_HURRIAN',
--	'MINOR_CIV_BARBARIAN_KHOISAN',
--	'MINOR_CIV_BARBARIAN_LIBYAN',
--	'MINOR_CIV_BARBARIAN_NUBIAN',
--	'MINOR_CIV_BARBARIAN_NUMIDIAN',
--	'MINOR_CIV_BARBARIAN_PARTHIAN',
--	'MINOR_CIV_BARBARIAN_PHEONICIAN',
--	'MINOR_CIV_BARBARIAN_SARMATIAN',
--	'MINOR_CIV_BARBARIAN_SHANGIAN');
UPDATE MinorCivBarbarians
	SET ArtStyleSuffix = '_AMER', ArtStylePrefix = 'AMERICAN'
	WHERE Type IN (
	'MINOR_CIV_BARBARIAN_ANASAZI',
	'MINOR_CIV_BARBARIAN_APACHE',
	'MINOR_CIV_BARBARIAN_CARIB',
	'MINOR_CIV_BARBARIAN_CHEHALIS',
	'MINOR_CIV_BARBARIAN_CHEROKEE',
	'MINOR_CIV_BARBARIAN_CHINOOK',
	'MINOR_CIV_BARBARIAN_ILLINOIS',
	'MINOR_CIV_BARBARIAN_NAVAJO',
	'MINOR_CIV_BARBARIAN_TEOIHUACAN',
	'MINOR_CIV_BARBARIAN_ZAPOTEC');
UPDATE MinorCivBarbarians
	SET ArtStyleSuffix = '_ASIA', ArtStylePrefix = 'ASIAN'
	WHERE Type IN (
	'MINOR_CIV_BARBARIAN_AINU',
	'MINOR_CIV_BARBARIAN_BULGAR',
	'MINOR_CIV_BARBARIAN_HARAPPAN',
	'MINOR_CIV_BARBARIAN_HSUNGNU',
	'MINOR_CIV_BARBARIAN_KHAZAK',
	'MINOR_CIV_BARBARIAN_KUSHANS',
	'MINOR_CIV_BARBARIAN_MAURYAN',
	'MINOR_CIV_BARBARIAN_SAKAE',
	'MINOR_CIV_BARBARIAN_TARTAR',
	'MINOR_CIV_BARBARIAN_YAYOI',
	'MINOR_CIV_BARBARIAN_YUECHI',
	'MINOR_CIV_BARBARIAN_ZHOU');
UPDATE MinorCivBarbarians
	SET ArtStyleSuffix = '_EURO', ArtStylePrefix = 'EUROPEAN'
	WHERE Type IN (
	'MINOR_CIV_BARBARIAN_ANGLE',
	'MINOR_CIV_BARBARIAN_ALEMANNI',
	'MINOR_CIV_BARBARIAN_BURGUNDIAN',
	'MINOR_CIV_BARBARIAN_CIMMERIAN',
	'MINOR_CIV_BARBARIAN_GAUL',
	'MINOR_CIV_BARBARIAN_GEPID',
	'MINOR_CIV_BARBARIAN_GOTH',
	'MINOR_CIV_BARBARIAN_JUTE',
	'MINOR_CIV_BARBARIAN_MAGYAR',
	'MINOR_CIV_BARBARIAN_SAXON',
	'MINOR_CIV_BARBARIAN_SCYTHIAN',
	'MINOR_CIV_BARBARIAN_THRACIAN',
	'MINOR_CIV_BARBARIAN_VANDAL',
	'MINOR_CIV_BARBARIAN_VISIGOTH');
UPDATE MinorCivBarbarians
	SET ArtStyleSuffix = '_MED', ArtStylePrefix = 'MEDITERRANEAN'
	WHERE Type IN (
	'MINOR_CIV_BARBARIAN_ESTRUSCAN',
	'MINOR_CIV_BARBARIAN_KASSITE',
	'MINOR_CIV_BARBARIAN_LIGURIAN',
	'MINOR_CIV_BARBARIAN_MINOAN',
	'MINOR_CIV_BARBARIAN_MYCENIAN',
	'MINOR_CIV_BARBARIAN_PHRYGIAN');

CREATE TABLE MinorCivPirates_temp (
	'Type' TEXT NOT NULL UNIQUE,
	'Description' TEXT,
	'Civilopedia' TEXT,
	'ShortDescription' TEXT,
	'Adjective' TEXT,
	'ArtDefineTag' TEXT,
	'DefaultPlayerColor' TEXT DEFAULT NULL,
	'ArtStyleType' TEXT DEFAULT NULL,
	'ArtStyleSuffix' TEXT DEFAULT NULL,
	'ArtStylePrefix' TEXT default NULL,
	'MinorCivTrait' TEXT NOT NULL,
	FOREIGN KEY (Description) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (Civilopedia) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (ShortDescription) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (Adjective) REFERENCES Language_en_US(Tag),
	FOREIGN KEY (MinorCivTrait) REFERENCES MinorCivTraits(Type));
INSERT INTO MinorCivPirates_temp (
		Type,								Description,								Civilopedia,								ShortDescription,							Adjective,									ArtDefineTag,						DefaultPlayerColor,			ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	MinorCivTrait			)
SELECT	'MINOR_CIV_PIRATE_ALGIERS',			'TXT_KEY_CITY_NAME_PIRATE_ALGIERS',			'TXT_KEY_CITY_NAME_PIRATE_ALGIERS',			'TXT_KEY_CITY_NAME_PIRATE_ALGIERS',			'TXT_KEY_CITY_NAME_PIRATE_ALGIERS',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_BARATARIA_BAY',	'TXT_KEY_CITY_NAME_PIRATE_BARATARIA_BAY',	'TXT_KEY_CITY_NAME_PIRATE_BARATARIA_BAY',	'TXT_KEY_CITY_NAME_PIRATE_BARATARIA_BAY',	'TXT_KEY_CITY_NAME_PIRATE_BARATARIA_BAY',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_BARBADOS',		'TXT_KEY_CITY_NAME_PIRATE_BARBADOS',		'TXT_KEY_CITY_NAME_PIRATE_BARBADOS',		'TXT_KEY_CITY_NAME_PIRATE_BARBADOS',		'TXT_KEY_CITY_NAME_PIRATE_BARBADOS',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AMER',		'AMERICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_BIAS_BAY',		'TXT_KEY_CITY_NAME_PIRATE_BIAS_BAY',		'TXT_KEY_CITY_NAME_PIRATE_BIAS_BAY',		'TXT_KEY_CITY_NAME_PIRATE_BIAS_BAY',		'TXT_KEY_CITY_NAME_PIRATE_BIAS_BAY',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_CABO_ROJO',		'TXT_KEY_CITY_NAME_PIRATE_CABO_ROJO',		'TXT_KEY_CITY_NAME_PIRATE_CABO_ROJO',		'TXT_KEY_CITY_NAME_PIRATE_CABO_ROJO',		'TXT_KEY_CITY_NAME_PIRATE_CABO_ROJO',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_CLEW_BAY',		'TXT_KEY_CITY_NAME_PIRATE_CLEW_BAY',		'TXT_KEY_CITY_NAME_PIRATE_CLEW_BAY',		'TXT_KEY_CITY_NAME_PIRATE_CLEW_BAY',		'TXT_KEY_CITY_NAME_PIRATE_CLEW_BAY',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_CUBA',			'TXT_KEY_CITY_NAME_PIRATE_CUBA',			'TXT_KEY_CITY_NAME_PIRATE_CUBA',			'TXT_KEY_CITY_NAME_PIRATE_CUBA',			'TXT_KEY_CITY_NAME_PIRATE_CUBA',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_DUNKIRK',			'TXT_KEY_CITY_NAME_PIRATE_DUNKIRK',			'TXT_KEY_CITY_NAME_PIRATE_DUNKIRK',			'TXT_KEY_CITY_NAME_PIRATE_DUNKIRK',			'TXT_KEY_CITY_NAME_PIRATE_DUNKIRK',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_EYL',				'TXT_KEY_CITY_NAME_PIRATE_EYL',				'TXT_KEY_CITY_NAME_PIRATE_EYL',				'TXT_KEY_CITY_NAME_PIRATE_EYL',				'TXT_KEY_CITY_NAME_PIRATE_EYL',				'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_GHAR_AL_MILH',	'TXT_KEY_CITY_NAME_PIRATE_GHAR_AL_MILH',	'TXT_KEY_CITY_NAME_PIRATE_GHAR_AL_MILH',	'TXT_KEY_CITY_NAME_PIRATE_GHAR_AL_MILH',	'TXT_KEY_CITY_NAME_PIRATE_GHAR_AL_MILH',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_GULANGYU_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_GULANGYU_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_GULANGYU_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_GULANGYU_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_GULANGYU_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_JOLO',			'TXT_KEY_CITY_NAME_PIRATE_JOLO',			'TXT_KEY_CITY_NAME_PIRATE_JOLO',			'TXT_KEY_CITY_NAME_PIRATE_JOLO',			'TXT_KEY_CITY_NAME_PIRATE_JOLO',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_JUAN_FERNANDEZ',	'TXT_KEY_CITY_NAME_PIRATE_JUAN_FERNANDEZ',	'TXT_KEY_CITY_NAME_PIRATE_JUAN_FERNANDEZ',	'TXT_KEY_CITY_NAME_PIRATE_JUAN_FERNANDEZ',	'TXT_KEY_CITY_NAME_PIRATE_JUAN_FERNANDEZ',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_KENNERY_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_KENNERY_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_KENNERY_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_KENNERY_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_KENNERY_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_LA_MARSA',		'TXT_KEY_CITY_NAME_PIRATE_LA_MARSA',		'TXT_KEY_CITY_NAME_PIRATE_LA_MARSA',		'TXT_KEY_CITY_NAME_PIRATE_LA_MARSA',		'TXT_KEY_CITY_NAME_PIRATE_LA_MARSA',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_MADAGASCAR',		'TXT_KEY_CITY_NAME_PIRATE_MADAGASCAR',		'TXT_KEY_CITY_NAME_PIRATE_MADAGASCAR',		'TXT_KEY_CITY_NAME_PIRATE_MADAGASCAR',		'TXT_KEY_CITY_NAME_PIRATE_MADAGASCAR',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_MALACCA_STRAIT',	'TXT_KEY_CITY_NAME_PIRATE_MALACCA_STRAIT',	'TXT_KEY_CITY_NAME_PIRATE_MALACCA_STRAIT',	'TXT_KEY_CITY_NAME_PIRATE_MALACCA_STRAIT',	'TXT_KEY_CITY_NAME_PIRATE_MALACCA_STRAIT',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_NEVIS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_NEVIS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_NEVIS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_NEVIS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_NEVIS_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_NEW_PROVIDENCE',	'TXT_KEY_CITY_NAME_PIRATE_NEW_PROVIDENCE',	'TXT_KEY_CITY_NAME_PIRATE_NEW_PROVIDENCE',	'TXT_KEY_CITY_NAME_PIRATE_NEW_PROVIDENCE',	'TXT_KEY_CITY_NAME_PIRATE_NEW_PROVIDENCE',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AMER',		'AMERICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_OCRACOKE',		'TXT_KEY_CITY_NAME_PIRATE_OCRACOKE',		'TXT_KEY_CITY_NAME_PIRATE_OCRACOKE',		'TXT_KEY_CITY_NAME_PIRATE_OCRACOKE',		'TXT_KEY_CITY_NAME_PIRATE_OCRACOKE',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_PORT_ROYAL',		'TXT_KEY_CITY_NAME_PIRATE_PORT_ROYAL',		'TXT_KEY_CITY_NAME_PIRATE_PORT_ROYAL',		'TXT_KEY_CITY_NAME_PIRATE_PORT_ROYAL',		'TXT_KEY_CITY_NAME_PIRATE_PORT_ROYAL',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_QESHM_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_QESHM_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_QESHM_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_QESHM_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_QESHM_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_ROGUES_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ROGUES_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ROGUES_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ROGUES_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ROGUES_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_SAINT_MALO',		'TXT_KEY_CITY_NAME_PIRATE_SAINT_MALO',		'TXT_KEY_CITY_NAME_PIRATE_SAINT_MALO',		'TXT_KEY_CITY_NAME_PIRATE_SAINT_MALO',		'TXT_KEY_CITY_NAME_PIRATE_SAINT_MALO',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_SEVERNDROOG',		'TXT_KEY_CITY_NAME_PIRATE_SEVERNDROOG',		'TXT_KEY_CITY_NAME_PIRATE_SEVERNDROOG',		'TXT_KEY_CITY_NAME_PIRATE_SEVERNDROOG',		'TXT_KEY_CITY_NAME_PIRATE_SEVERNDROOG',		'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_SOUTH_SULAWESI',	'TXT_KEY_CITY_NAME_PIRATE_SOUTH_SULAWESI',	'TXT_KEY_CITY_NAME_PIRATE_SOUTH_SULAWESI',	'TXT_KEY_CITY_NAME_PIRATE_SOUTH_SULAWESI',	'TXT_KEY_CITY_NAME_PIRATE_SOUTH_SULAWESI',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_ASIA',		'ASIAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_ST_MARYS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ST_MARYS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ST_MARYS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ST_MARYS_ISLAND',	'TXT_KEY_CITY_NAME_PIRATE_ST_MARYS_ISLAND',	'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_TORTUGA',			'TXT_KEY_CITY_NAME_PIRATE_TORTUGA',			'TXT_KEY_CITY_NAME_PIRATE_TORTUGA',			'TXT_KEY_CITY_NAME_PIRATE_TORTUGA',			'TXT_KEY_CITY_NAME_PIRATE_TORTUGA',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_EURO',		'EUROPEAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_TRIPOLI',			'TXT_KEY_CITY_NAME_PIRATE_TRIPOLI',			'TXT_KEY_CITY_NAME_PIRATE_TRIPOLI',			'TXT_KEY_CITY_NAME_PIRATE_TRIPOLI',			'TXT_KEY_CITY_NAME_PIRATE_TRIPOLI',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE'	UNION ALL
SELECT	'MINOR_CIV_PIRATE_TUNIS',			'TXT_KEY_CITY_NAME_PIRATE_TUNIS',			'TXT_KEY_CITY_NAME_PIRATE_TUNIS',			'TXT_KEY_CITY_NAME_PIRATE_TUNIS',			'TXT_KEY_CITY_NAME_PIRATE_TUNIS',			'ART_DEF_CIVILIZATION_BARBARIAN',	'PLAYERCOLOR_BARBARIAN',	'ARTSTYLE_BARBARIAN',	'_AFRI',		'AFRICAN',		'MINOR_TRAIT_PIRATE';
CREATE TABLE MinorCivPirates
	AS SELECT * FROM MinorCivPirates_temp ORDER BY RANDOM();
DROP TABLE MinorCivPirates_temp;

CREATE TABLE MinorCivBarbarian_CityNames (
	'MinorCivType' TEXT,
	'CityName' TEXT NOT NULL,
	FOREIGN KEY (MinorCivType) REFERENCES MinorCivBarbarians(Type));
INSERT INTO MinorCivBarbarian_CityNames (
		MinorCivType,	CityName	)
SELECT	Type,			Description
	FROM MinorCivBarbarians;

CREATE TABLE MinorCivPirate_CityNames (
	'MinorCivType' TEXT,
	'CityName' TEXT NOT NULL,
	FOREIGN KEY (MinorCivType) REFERENCES MinorCivPirates(Type));
INSERT INTO MinorCivPirate_CityNames (
		MinorCivType,	CityName	)
SELECT	Type,			Description
	FROM MinorCivPirates;

CREATE TABLE MinorCivBarbarian_Flavors (
	'MinorCivType' TEXT,
	'FlavorType' TEXT,
	'Flavor' INTEGER DEFAULT -1,
	FOREIGN KEY (MinorCivType) REFERENCES MinorCivBarbarians(Type),
	FOREIGN KEY (FlavorType) REFERENCES Flavors(Type));
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_CITY_DEFENSE',	7		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_DEFENSE',		7		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_EXPANSION',		0		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_GROWTH',		0		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_NAVAL',			0		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_NUKE',			0		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_OFFENSE',		10		
	FROM MinorCivBarbarians;
INSERT INTO MinorCivBarbarian_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_WONDER',		0		
	FROM MinorCivBarbarians;

CREATE TABLE MinorCivPirate_Flavors (
	'MinorCivType' TEXT,
	'FlavorType' TEXT,
	'Flavor' INTEGER DEFAULT -1,
	FOREIGN KEY (MinorCivType) REFERENCES MinorCivPirates(Type),
	FOREIGN KEY (FlavorType) REFERENCES Flavors(Type));
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_CITY_DEFENSE',	7		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_DEFENSE',		7		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_EXPANSION',		0		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_GROWTH',		0		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_NAVAL',			10		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_NUKE',			0		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_OFFENSE',		0		
	FROM MinorCivPirates;
INSERT INTO MinorCivPirate_Flavors (
		MinorCivType,	FlavorType,				Flavor	)
SELECT	Type,			'FLAVOR_WONDER',		0		
	FROM MinorCivPirates;

--INSERT INTO MinorCivilizations SELECT * FROM MinorCivBarbarians;
--INSERT INTO MinorCivilizations SELECT * FROM MinorCivPirates;

INSERT INTO MinorCivTraits (
		Type,						Description,						TraitIcon,						TraitTitleIcon,				BackgroundImage						)
SELECT	'MINOR_TRAIT_BARBARIAN',	'TXT_KEY_MINOR_TRAIT_BARBARIAN',	'CityStateMilitaristic.dds',	'barbarianpopuptop300.dds',	'citystatebackgroundmilitary.dds'	UNION ALL
SELECT	'MINOR_TRAIT_PIRATE',		'TXT_KEY_MINOR_TRAIT_PIRATE',		'CityStateMilitaristic.dds',	'barbarianpopuptop300.dds',	'citystatebackgroundmilitary.dds'	;

--=======
-- UNITS
--=======
UPDATE Civilization_UnitClassOverrides
	SET UnitType = CASE UnitClassType
	WHEN 'UNITCLASS_ARCHER'				THEN 'UNIT_BARBARIAN_AXMAN'
	WHEN 'UNITCLASS_CHARIOT_ARCHER'		THEN 'UNIT_BARBARIAN_ARCHER'	END
	WHERE CivilizationType = 'CIVILIZATION_BARBARIAN';
INSERT INTO Civilization_UnitClassOverrides (
		CivilizationType,			UnitClassType,					UnitType					)
SELECT	'CIVILIZATION_BARBARIAN',	'UNITCLASS_PIKEMAN',			'UNIT_BARBARIAN_CLANSMAN'	UNION ALL
SELECT	'CIVILIZATION_BARBARIAN',	'UNITCLASS_COMPOSITE_BOWMAN',	'UNIT_BARBARIAN_HORNBOWMAN'	UNION ALL
SELECT	'CIVILIZATION_BARBARIAN',	'UNITCLASS_CROSSBOWMAN',		'UNIT_BARBARIAN_JAVELINEER'	UNION ALL
SELECT	'CIVILIZATION_BARBARIAN',	'UNITCLASS_LONGSWORDSMAN',		'UNIT_BARBARIAN_SLAYER'		UNION ALL
SELECT	'CIVILIZATION_BARBARIAN',	'UNITCLASS_KNIGHT',				'UNIT_BARBARIAN_CHAMPION'	;
--GALLEY
--Schooner, Sloop, Corvette, Brigantine?

--PROMOTION_FREE_PILLAGE_MOVES?
--PROMOTION_DOUBLE_PLUNDER?

--Brute
--UPDATE Units
--	SET Combat = 8
--	WHERE Type = 'UNIT_BARBARIAN_WARRIOR';
--Tribesman
UPDATE Units
	SET Description = 'TXT_KEY_UNIT_BARBARIAN_TRIBESMAN', Combat = 11
	WHERE Type = 'UNIT_BARBARIAN_SPEARMAN';
--Hand-Axe [now replaces Archer instead of Chariot Archer]
UPDATE Units
	SET Combat = 7, RangedCombat = 8, Cost = 40
	WHERE Type = 'UNIT_BARBARIAN_AXMAN';
UPDATE Unit_ClassUpgrades
	SET UnitClassType = 'UNITCLASS_COMPOSITE_BOWMAN'
	WHERE UnitType = 'UNIT_BARBARIAN_AXMAN';
--Marauder
UPDATE Units
	SET Description = 'TXT_KEY_UNIT_BARBARIAN_MARAUDER', Combat = 14
	WHERE Type = 'UNIT_BARBARIAN_SWORDSMAN';
--Huntsman [replaces Chariot Archer]
UPDATE Units
	SET Description = 'TXT_KEY_UNIT_BARBARIAN_HUNTSMAN', Combat = 8, RangedCombat = 11, Cost = 56, Range = 1
	WHERE Type = 'UNIT_BARBARIAN_ARCHER';
UPDATE Unit_ClassUpgrades
	SET UnitClassType = 'UNITCLASS_CROSSBOWMAN'
	WHERE UnitType = 'UNIT_BARBARIAN_ARCHER';
--Raider
UPDATE Units
	SET Description = 'TXT_KEY_UNIT_BARBARIAN_RAIDER', Combat = 13, Moves = 3
	WHERE Type = 'UNIT_BARBARIAN_HORSEMAN';
--Clansman
INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
	SELECT	'UNIT_BARBARIAN_CLANSMAN', 'TXT_KEY_UNIT_BARBARIAN_CLANSMAN', Civilopedia, Strategy, Help, Requirements, 15, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_PIKEMAN', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
	FROM Units WHERE Type = 'UNIT_PIKEMAN';
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_BARBARIAN_CLANSMAN', UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_PIKEMAN';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_BARBARIAN_CLANSMAN', UnitClassType
	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_PIKEMAN';
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_BARBARIAN_CLANSMAN', FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_PIKEMAN';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_BARBARIAN_CLANSMAN', PromotionType
	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_PIKEMAN';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_BARBARIAN_CLANSMAN', ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_PIKEMAN';
--Javelineer
INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
	SELECT	'UNIT_BARBARIAN_JAVELINEER', 'TXT_KEY_UNIT_BARBARIAN_JAVELINEER', Civilopedia, Strategy, Help, Requirements, 5, 13, Cost, Moves, Immobile, 2, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_COMPOSITE_BOWMAN', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
	FROM Units WHERE Type = 'UNIT_COMPOSITE_BOWMAN';
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_BARBARIAN_JAVELINEER', UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_BARBARIAN_JAVELINEER', UnitClassType
	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_BARBARIAN_JAVELINEER', FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_BARBARIAN_JAVELINEER', PromotionType
	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_BARBARIAN_JAVELINEER', ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';
--Hornbowman
INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
	SELECT	'UNIT_BARBARIAN_HORNBOWMAN', 'TXT_KEY_UNIT_BARBARIAN_HORNBOWMAN', Civilopedia, Strategy, Help, Requirements, 15, 16, Cost, Moves, Immobile, 2, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_BARBARIAN_ARCHER', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
	FROM Units WHERE Type = 'UNIT_CROSSBOWMAN';
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_BARBARIAN_HORNBOWMAN', UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_CROSSBOWMAN';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_BARBARIAN_HORNBOWMAN', UnitClassType
	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CROSSBOWMAN';
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_BARBARIAN_HORNBOWMAN', FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_CROSSBOWMAN';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_BARBARIAN_HORNBOWMAN', PromotionType
	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CROSSBOWMAN';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_BARBARIAN_HORNBOWMAN', ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_CROSSBOWMAN';
--Slayer
INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
	SELECT	'UNIT_BARBARIAN_SLAYER', 'TXT_KEY_UNIT_BARBARIAN_SLAYER', Civilopedia, Strategy, Help, Requirements, 21, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_LONGSWORDSMAN', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
	FROM Units WHERE Type = 'UNIT_LONGSWORDSMAN';
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_BARBARIAN_SLAYER', UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_LONGSWORDSMAN';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_BARBARIAN_SLAYER', UnitClassType
	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_LONGSWORDSMAN';
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_BARBARIAN_SLAYER', FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_LONGSWORDSMAN';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_BARBARIAN_SLAYER', PromotionType
	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LONGSWORDSMAN';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_BARBARIAN_SLAYER', ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_LONGSWORDSMAN';
--Champion
INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
	SELECT	'UNIT_BARBARIAN_CHAMPION', 'TXT_KEY_UNIT_BARBARIAN_CHAMPION', Civilopedia, Strategy, Help, Requirements, 18, RangedCombat, Cost, 3, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_KNIGHT', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
	FROM Units WHERE Type = 'UNIT_KNIGHT';
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_BARBARIAN_CHAMPION', UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_KNIGHT';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_BARBARIAN_CHAMPION', UnitClassType
	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_KNIGHT';
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_BARBARIAN_CHAMPION', FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_KNIGHT';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_BARBARIAN_CHAMPION', PromotionType
	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_KNIGHT';
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_BARBARIAN_CHAMPION', ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_KNIGHT';
--Galley
--INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness, UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas)
--	SELECT	'UNIT_BARBARIAN_GALLEY', 'TXT_KEY_UNIT_GALLEY', 'TXT_KEY_UNIT_GALLEY_PEDIA', 'TXT_KEY_UNIT_GALLEY_STRATEGY', Help, Requirements, Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
--			'ART_DEF_UNIT_BARBARIAN_GALLEY', UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, ProjectPrereq, SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas
--	FROM Units WHERE Type = 'UNIT_GALLEY';
--INSERT INTO Unit_AITypes (UnitType, UnitAIType)
--	SELECT 'UNIT_BARBARIAN_GALLEY', UnitAIType
--	FROM Unit_AITypes WHERE UnitType = 'UNIT_GALLEY';
--INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
--	SELECT 'UNIT_BARBARIAN_GALLEY', UnitClassType
--	FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_GALLEY';
--INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
--	SELECT 'UNIT_BARBARIAN_GALLEY', FlavorType, Flavor
--	FROM Unit_Flavors WHERE UnitType = 'UNIT_GALLEY';
--INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
--	SELECT 'UNIT_BARBARIAN_GALLEY', PromotionType
--	FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GALLEY';
--INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
--	SELECT 'UNIT_BARBARIAN_GALLEY', ResourceType, Cost
--	FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_GALLEY';
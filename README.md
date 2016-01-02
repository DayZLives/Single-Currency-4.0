Single Currency 4.0
A combination of SC 2.0 and SC 3.0.

#NOTICE
I do not own or intend to take any credit for the code in these files.
All i have done is rearrange the files found on the thread below into a more
'user friendly' format and provided installation instructions for people
who want to add this addon to their server.

##http://epochmod.com/forum/index.php?/topic/34765-alpha-release-single-currency-40-banking-storage/

#CREDITS

* Zupa - Creator of SC Storage
* Maca - Original private single currency.
* Peterbeer -  for putting all fixes together in 1 pack.
* Soul - Hives modifications and code changes for it.
* Rocu - Great help on forums and fixes.
* GTX Gaming - Modifications to allow 2.0 & 3.0 to work together.

#INSTALLATION INSTRUCTIONS

These instructions are suitable for custom servers who may already have other addons installed.
If you are installing this on a new server you will need to have knowledge of creating custom
dayz files such as 'compiles.sqf' and 'variables.sqf'. I may add more instructions later.

I have made the instructions as clear as possible but there are a lot of edits so if you 
are not familiar with the basics of scripting you may get lost.

#MOVE THE FILES

First let's move the files into position.

1. Drag the files from 'MISSION' into the root of your mission PBO.

1. Drag the files from 'SERVER' into the root of your server PBO.

1. Drag the DLL files from 'DLL\ROOT' to the root of your arma installation folder.
I recommend you make a backup of your current DLL files just incase!

1. Drag the DLL files from 'DLL\SERVER' to your '@DayZ_Epoch_Server' folder.
Again i recommend you make a backup of your current DLL just incase!

1. Execute the SQL script from the 'SQL' folder on your database.
This just creates the 'Banking_Data' table.

#MISSION PBO

##IN YOUR 'init.sqf'

1. ADD THE FOLLOWING
	
	```
	call compile preprocessFileLineNumbers "custom\singlecurrency\CoinInit.sqf";
	call compile preprocessFileLineNumbers "custom\singlecurrency\BankInit.sqf";
	```
	
	RIGHT BELOW
	
	```
	progressLoadingScreen 0.5;
	```

1. ADD THE FOLLOWING
	
	```
	execVM "custom\singlecurrency\compile\playerHud.sqf";
	execVM "custom\singlecurrency\config\bankmarkers.sqf";
	```
	
	RIGHT BELOW
	
	```
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	```

##IN YOUR 'description.ext'

1. ADD THE FOLLOWING
	
	```
	#include "custom\singlecurrency\traders\cfgServerTrader.hpp"
	```
	
	AT THE VERY TOP OF THE FILE

1. IF YOU DONT ALREADY HAVE A 'class RscTitles {}'

	ADD THE FOLLOWING
	
	```
	class RscTitles {
		//Single Currency
		class ZSC_Money_Display {
			idd = -1;
			fadeout=0;
			fadein=0;
			duration = 20;
			name= "ZSC_Money_Display";
			onLoad = "uiNamespace setVariable ['ZSC_Money_Display', _this select 0]";
			class controlsBackground {
				class ZSC_Status
				{
					idc = 4900;
					type = 13;
					size = 0.040;
					x = safezoneX + (safezoneW -0.35);
					y = safezoneY + 0.40 * safezoneW;
					w = 0.35; h = 0.20;
					colorText[] = {1,1,1,1};
					lineSpacing = 3;
					colorBackground[] = {0,0,0,0};
					text = "";
					style = 0x02;
					shadow = 2;
					font = "Zeppelin32";
					sizeEx = 0.023;
					class Attributes {
						align = "right";
					};
				};
			};
		};
	};
	```	
	
	AT THE BOTTOM OF THE FILE

1.	IF YOU DO ALREADY HAVE A 'class RscTitles {...}'

	ADD THE FOLLOWING
	
	```
	//Single Currency
	class ZSC_Money_Display {
		idd = -1;
		fadeout=0;
		fadein=0;
		duration = 20;
		name= "ZSC_Money_Display";
		onLoad = "uiNamespace setVariable ['ZSC_Money_Display', _this select 0]";
		class controlsBackground {
			class ZSC_Status
			{
				idc = 4900;
				type = 13;
				size = 0.040;
				x = safezoneX + (safezoneW -0.35);
				y = safezoneY + 0.40 * safezoneW;
				w = 0.35; h = 0.20;
				colorText[] = {1,1,1,1};
				lineSpacing = 3;
				colorBackground[] = {0,0,0,0};
				text = "";
				style = 0x02;
				shadow = 2;
				font = "Zeppelin32";
				sizeEx = 0.023;
				class Attributes {
					align = "right";
				};
			};
		};
	};
	```
	
	SOMEWHERE INSIDE OF 'Class RscTitles{...}'

1. ADD THE FOLLOWING

	```
	#include "custom\singlecurrency\config\defines.hpp"
	```

	RIGHT ABOVE
	
	```
	class RscTitles {
	```
	
	NOTE: This has to be ABOVE the 'RscTitles' block!

1. ADD
	
	```
	#include "custom\singlecurrency\config\ZSCdefines.hpp"
	#include "custom\singlecurrency\config\ZSCdialogs.hpp"
	#include "custom\singlecurrency\config\ATMdefines.hpp"
	#include "custom\singlecurrency\config\ATMdialogs.hpp"
	#include "custom\singlecurrency\transfer\transferdefines.hpp"
	#include "custom\singlecurrency\transfer\transferdialog.hpp"
	```
	
	TO THE BOTTOM OF THE FILE

##IN YOUR 'fn_selfactions.sqf' IF YOU DONT HAVE ONE CREATE ONE

1. ADD
	
	```
	//Storage
	if(_typeOfCursorTarget in ZSC_MoneyStorage && (player distance _cursorTarget < 5)) then {
		if (s_bank_dialog < 0) then {
				s_bank_dialog = player addAction ["Money Storage", "custom\singlecurrency\actions\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];	
		};
	} else {
     	player removeAction s_bank_dialog;
		s_bank_dialog = -1;
	};

	// Vehicle Storage
	if( _isVehicle && !_isMan &&_isAlive && !_isMan && !locked _cursorTarget && !(_cursorTarget isKindOf "Bicycle") && (player distance _cursorTarget < 5)) then {		
		if (s_bank_dialog2 < 0) then {
			s_bank_dialog2 = player addAction ["Money Storage", "custom\singlecurrency\actions\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};			
	} else {		
		player removeAction s_bank_dialog2;
		s_bank_dialog2 = -1;
	};
	
	//Banking 
	if(_typeOfCursorTarget in Bank_Object and (player distance _cursorTarget < 3)) then {		
		if (s_bank_dialog3 < 0) then {
			s_bank_dialog3 = player addAction ["Bank ATM", "custom\singlecurrency\actions\atm_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	if (s_bank_dialog4 < 0) then {
		s_bank_dialog4 = player addAction ["Transfer Money", "custom\singlecurrency\transfer\transfer_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
	};		
	} else {		
		player removeAction s_bank_dialog3;
		s_bank_dialog3 = -1;
		player removeAction s_bank_dialog4;
		s_bank_dialog4 = -1;
	};

	_banker = _cursorTarget getVariable["BankerBot",0];

	if((_banker == 1) and (player distance _cursorTarget < 3)) then {		
			if (s_bank_dialog5 < 0) then {
				s_bank_dialog5 = player addAction ["Mr. Teller", "custom\singlecurrency\actions\atm_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
			};
		if (s_bank_dialog6 < 0) then {
			s_bank_dialog6 = player addAction ["Transfer Money", "custom\singlecurrency\transfer\transfer_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};				
		} else {		
			player removeAction s_bank_dialog5;
			s_bank_dialog5 = -1;
			player removeAction s_bank_dialog6;
			s_bank_dialog6 = -1;
	};
	```
	
	RIGHT ABOVE
	
	```
	if(_typeOfCursorTarget in DZE_UnLockedStorage && _ownerID != "0" && (player distance _cursorTarget < 3)) then {
	```

1. ADD THE FOLLOWING 
	
	```
	//Give Money
	if (_isMan and _isAlive and !_isZombie and !_isAnimal and !(_traderType in serverTraders)) then {
		if (s_givemoney_dialog < 0) then {
			s_givemoney_dialog = player addAction [format["Give Money to %1", (name _cursorTarget)], "custom\singlecurrency\actions\give_player_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_givemoney_dialog;
		s_givemoney_dialog = -1;
	};
	```
	
	ABOVE
	
	```
	if(_typeOfCursorTarget in dayz_fuelpumparray) then {
	```

1. ADD THE FOLLOWING
	
	```
	//Banking
	player removeAction s_givemoney_dialog;
	s_givemoney_dialog = -1;
	player removeAction s_bank_dialog;
	s_bank_dialog = -1;
	player removeAction s_bank_dialog2;
	s_bank_dialog2 = -1;
	player removeAction s_bank_dialog3;
	s_bank_dialog3 = -1;
	player removeAction s_bank_dialog4;
	s_bank_dialog4 = -1;
	player removeAction s_bank_dialog5;
	s_bank_dialog5 = -1;
	
	player removeAction s_bank_dialog6;
	s_bank_dialog6 = -1;
	```
	
	BELOW
	
	```
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	```

##IN YOUR 'variables.sqf' IF YOU DON'T HAVE ONE CREATE ONE

1. ADD

	```
	s_givemoney_dialog = -1;
	s_bank_dialog = -1;
	s_bank_dialog2 = -1;
	s_bank_dialog3 = -1;
	s_bank_dialog4 = -1;
	s_bank_dialog5 = -1;
	s_bank_dialog6 = -1;
	```
	
	* AFTER
	
	```
	s_player_heli_lift = -1;
	s_player_heli_detach = -1;
	s_player_lockUnlock_crtl = -1;
	```
	
##IN YOUR 'player_switchModel.sqf' IF YOU DON'T HAVE ONE CREATE ONE

1. ADD THE FOLLOWING
	
	```
	_cashMoney = player getVariable["cashMoney",0];
	```
	
	RIGHT AFTER
	
	```
	_weapons = weapons player;
	_countMags = call player_countMagazines; 
	_magazines = _countMags select 0;
	```

1. ADD THE FOLLOWING
	
	```
	player setVariable ["cashMoney",_cashMoney,true];
	```
	
	TO THE BOTTOM OF THE FILE

1. REPLACE
	
	```
	//Create New Character
	_group 		= createGroup west;
	_newUnit 	= _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];

	_newUnit 	setPosATL _position;
	_newUnit 	setDir _dir;
	```
	
	WITH
	
	```
	_group = createGroup west;
	_newUnit = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
	[_newUnit] joinSilent createGroup WEST;
	_newUnit setPosATL _position;
	_newUnit setDir _dir;
	_newUnit setVariable ["cashMoney",_cashMoney,true];
	```

##IN YOUR 'player_unlockVault.sqf' IF YOU DON'T HAVE ONE USE THE ONE PROVIDED

1. ADD THE FOLLOWING
	
	```
	_objMoney	= _obj getVariable["bankMoney",0];
	```
	
	RIGHT AFTER
	
	```
	_dir = direction _obj;
	_pos	= _obj getVariable["OEMPos",(getposATL _obj)];
	_objectID 	= _obj getVariable["ObjectID","0"];
	_objectUID	= _obj getVariable["ObjectUID","0"];
	```

1. ADD THE FOLLOWING
	
	```
	_holder setVariable ["bankMoney", _objMoney, true];
	```
	
	RIGHT AFTER
	
	```
	_holder setVariable["CharacterID",_ownerID,true];
	_holder setVariable["ObjectID",_objectID,true];
	_holder setVariable["ObjectUID",_objectUID,true];
	_holder setVariable ["OEMPos", _pos, true];
	```

##IN YOUR 'player_lockVault.sqf' IF YOU DON'T HAVE ONE CREATE ONE

1. ADD THE FOLLOWING
	
	```
	_objMoney	= _obj getVariable["bankMoney",0];
	```
	
	RIGHT AFTER 
	
	```
	_ownerID = _obj getVariable["CharacterID","0"];
	_objectID 	= _obj getVariable["ObjectID","0"];
	_objectUID	= _obj getVariable["ObjectUID","0"];
	```

1. ADD THE FOLLOWING
	
	```
	_holder setVariable ["bankMoney", _objMoney, true];
	```
	
	RIGHT AFTER
	
	```
	_holder setVariable["CharacterID",_ownerID,true];
	_holder setVariable["ObjectID",_objectID,true];
	_holder setVariable["ObjectUID",_objectUID,true];
	_holder setVariable ["OEMPos", _pos, true];
	```

#SERVER PBO

##IN YOUR 'server_monitor.sqf'

NOTE: the " _intentory' variable can be called "_inventory" at your files, so change my code to that, if it's the case).

1. ADD THE FOLLOWING
	
	```
	if( count (_inventory) > 3)then{
		_object setVariable ["bankMoney", _inventory select 3, true];
	}else{
	        _object setVariable ["bankMoney", 0, true];
	};
	```
	
	RIGHT ABOVE
	
	```
	if (_type in DZE_LockedStorage) then {
		// Fill variables with loot
		_object setVariable ["WeaponCargo", (_inventory select 0),true];
		_object setVariable ["MagazineCargo", (_inventory select 1),true];
		_object setVariable ["BackpackCargo", (_inventory select 2),true];
	} else {
	```
	
##IN YOUR 'server_functions.sqf'

1. ADD THE FOLLOWING
	
	```
	#include "\z\addons\dayz_server\bankzones\bankinit.sqf"
	```
	
	AT THE BOTTOM OF THE FILE
	
##IN YOUR 'server_playerSync.sqf'

1. REPLACE
	
	```
	_playerGear = [weapons _character,_magazines];
	```
	
	WITH
	
	```
	_playerGear = [weapons _character,_magazines, _character getVariable["cashMoney",0]];
	```

1. REPLACE
	
	```
	_key = format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity];
	```
	
	WITH
	
	```
	_key = format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity,_cashMoney];
	```

1. ADD THE FOLLOWING
	
	```
	_cashMoney = ["cashMoney",_character] call server_getDiff2;
	```
	
	RIGHT AFTER
	
	```
	_killsH = 		["humanKills",_character] call server_getDiff;
	_headShots = 	["headShots",_character] call server_getDiff;
	_humanity = 	["humanity",_character] call server_getDiff2;
	```
	
##IN YOUR 'player_login.sqf'

1. REPLACE

	```
	_key = format["CHILD:203:%1:%2:%3:",_charID,[_wpns,_mags],[_bcpk,[],[]]];
	```
	
	WITH
	
	```
	_key = format["CHILD:203:%1:%2:%3:",_charID,[_wpns,_mags,0],[_bcpk,[],[]]];
	```
	
##IN YOUR 'server_updateObject.sqf'

1. REPLACE
	
	```
	_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
	];
	```
	
	WITH
	
	```
	_inventory = [
		getWeaponCargo _object,
		getMagazineCargo _object,
		getBackpackCargo _object,
		_object getVariable["bankMoney",0]
	];
	```
	
##IN YOUR 'server_playerSetup.sqf'

1. ADD THE FOLLOWING

	```
	_playerName = name _playerObj;
	```
	
	AFTER
	
	```
	_characterID = _this select 0;
	_playerObj = _this select 1;
	_playerID = getPlayerUID _playerObj;
	```
	
1. ADD THE FOLLOWING

	```
	_cashMoney = 0;
	_bankMoney = 0;
	```
	
	AFTER
	
	```
	_worldspace = 	[];

	_state = 		[];
	```
	
1. ADD THE FOLLOWING

	```
	_cashMoney = 	_primary select 7;
	```
	
	RIGHT AFTER
	
	```
	_worldspace = 	_primary select 4;
	_humanity =		_primary select 5;
	_lastinstance =	_primary select 6;
	```
	
1. ADD THE FOLLOWING

	```
	_playerObj setVariable ["moneychanged",0,true];	
	_playerObj setVariable ["bankchanged",0,true];	
	```
	
	RIGHT AFTER
	
	```
	_playerObj setVariable["zombieKills",(_stats select 0),true];
	_playerObj setVariable["headShots",(_stats select 1),true];
	_playerObj setVariable["humanKills",(_stats select 2),true];
	_playerObj setVariable["banditKills",(_stats select 3),true];
	_playerObj addScore (_stats select 1);
	```
	
1. REPLACE

	```
	//record for Server JIP checks
	_playerObj setVariable["zombieKills_CHK",0];
	_playerObj setVariable["humanKills_CHK",0,true];
	_playerObj setVariable["banditKills_CHK",0,true];
	_playerObj setVariable["headShots_CHK",0];
	```
	
	WITH
	
	```
	//record for Server JIP checks
	_playerObj setVariable["zombieKills_CHK",0,true];
	_playerObj setVariable["humanKills_CHK",0,true];
	_playerObj setVariable["banditKills_CHK",0,true];
	_playerObj setVariable["headShots_CHK",0,true];
	```
	
1. ADD THE FOLLOWING

	```
	_playerObj setVariable ["cashMoney",_cashMoney,true];
	_playerObj setVariable ["cashMoney_CHK",_cashMoney];
	```
	
	RIGHT AFTER
	
	```
	//_playerObj setVariable["worldspace",_worldspace,true];
	//_playerObj setVariable["state",_state,true];
	_playerObj setVariable["lastPos",getPosATL _playerObj];
	```
	
1. ADD THE FOLLOWING

	```
	_key2 = format["CHILD:298:%1:",_playerID];
	_primary2 = _key2 call server_hiveReadWrite;
	if(count _primary2 > 0) then {
		if((_primary2 select 0) != "ERROR") then {
			_bankMoney = _primary2 select 1;
			_playerObj setVariable["bankMoney",_bankMoney,true];
			_playerObj setVariable["bankMoney_CHK",_bankMoney];
		} else {
			_playerObj setVariable["bankMoney",0,true];
			_playerObj setVariable["bankMoney_CHK",0];
		};
	} else {
		_playerObj setVariable["bankMoney",0,true];
		_playerObj setVariable["bankMoney_CHK",0];
	};
	```
	
	RIGHT ABOVE
	
	```
	PVDZE_plr_Login = nil;
	PVDZE_plr_Login2 = nil;
	```
	
##ALL DONE

#Have I missed anything?
If i've missed something or you need more detail please let me know. I'll try to keep these instructions
as clear and up to date as possible.

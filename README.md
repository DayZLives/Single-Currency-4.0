Single Currency 4.0
Recompiled from GTX Gaming's 1 Click Install version.

I did not write nor am i taking credit for any of the code in these files.
I am simply re-compiling and creating a tutorial for anyone who wants to add
this to their own server.


#MISSION PBO

##IN YOUR 'init.sqf'

1. ADD
	```
	call compile preprocessFileLineNumbers "custom\singlecurrency\CoinInit.sqf";
	call compile preprocessFileLineNumbers "custom\singlecurrency\BankInit.sqf";
	```
	* BELOW
	```
	progressLoadingScreen 0.6;
	```
	NOTE: These lines MUST be after your compiles.sqf is loaded.


1. ADD
	```
	execVM "custom\singlecurrency\compile\playerHud.sqf";
	execVM "custom\singlecurrency\config\bankmarkers.sqf";
	```
	* BELOW
	```
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	```

##IN YOUR 'description.ext'

1. ADD
	```
	#include "custom\singlecurrency\traders\cfgServerTrader.hpp"
	```
	* AT THE VERY TOP

1. ADD
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
	* AT THE BOTTOM OF THE FILE

	IF YOU ALREADY HAVE 'class RscTitles {}' JUST ADD	
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
	* INSIDE OF 'RscTitles{}'

	NOTE: Do not define 'class RscTitles{}' twice! It will cause your server to crash on start.

1. ADD
	```
	#include "custom\singlecurrency\config\defines.hpp"
	```
	* ABOVE
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
	* TO THE BOTTOM OF THE FILE

##IN YOUR 'fn_selfactions.sqf' IF YOU DONT HAVE ONE USE THE ONE PROVIDED

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
	* ABOVE
	```
	if(_typeOfCursorTarget in DZE_UnLockedStorage && _ownerID != "0" && (player distance _cursorTarget < 3)) then {
	```

1. ADD 
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
	* ABOVE
	```
	if(_typeOfCursorTarget in dayz_fuelpumparray) then {
	```

1. ADD
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
	* BELOW
	```
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	```

##IN YOUR 'player_switchModel.sqf' IF YOU DON'T HAVE ONE USE THE ONE PROVIDED

1. ADD
	```
	_cashMoney = player getVariable["cashMoney",0];
	```
	* AFTER
	```
	_weapons = weapons player;
	_countMags = call player_countMagazines; 
	_magazines = _countMags select 0;
	```

1. ADD
	```
	player setVariable ["cashMoney",_cashMoney,true];
	```
	* TO THE BOTTOM OF THE FILE

1. REPLACE
	```
	//Create New Character
	_group 		= createGroup west;
	_newUnit 	= _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];

	_newUnit 	setPosATL _position;
	_newUnit 	setDir _dir;
	```
	* WITH
	```
	_group = createGroup west;
	_newUnit = _group createUnit [_class,dayz_spawnPos,[],0,"NONE"];
	[_newUnit] joinSilent createGroup WEST;
	_newUnit setPosATL _position;
	_newUnit setDir _dir;
	_newUnit setVariable ["cashMoney",_cashMoney,true];
	```

##IN YOUR 'player_unlockVault.sqf' IF YOU DON'T HAVE ONE USE THE ONE PROVIDED

1. ADD
	```
	_objMoney	= _obj getVariable["bankMoney",0];
	```
	* AFTER
	```
	_dir = direction _obj;
	_pos	= _obj getVariable["OEMPos",(getposATL _obj)];
	_objectID 	= _obj getVariable["ObjectID","0"];
	_objectUID	= _obj getVariable["ObjectUID","0"];
	```

1. ADD
	```
	_holder setVariable ["bankMoney", _objMoney, true];
	```
	* AFTER
	```
	_holder setVariable["CharacterID",_ownerID,true];
	_holder setVariable["ObjectID",_objectID,true];
	_holder setVariable["ObjectUID",_objectUID,true];
	_holder setVariable ["OEMPos", _pos, true];
	```

##IN YOUR 'player_lockVault.sqf' IF YOU DON'T HAVE ONE USE THE ONE PROVIDED

1. ADD
	```
	_objMoney	= _obj getVariable["bankMoney",0];
	```
	* AFTER 
	```
	_ownerID = _obj getVariable["CharacterID","0"];
	_objectID 	= _obj getVariable["ObjectID","0"];
	_objectUID	= _obj getVariable["ObjectUID","0"];
	```

1. ADD
	```
	_holder setVariable ["bankMoney", _objMoney, true];
	```
	* AFTER
	```
	_holder setVariable["CharacterID",_ownerID,true];
	_holder setVariable["ObjectID",_objectID,true];
	_holder setVariable["ObjectUID",_objectUID,true];
	_holder setVariable ["OEMPos", _pos, true];
	```

#SERVER PBO

##IN YOUR 'server_updateObject.sqf'

1. REPLACE
	```
	_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
	];
	```
	* WITH
	```
	_inventory = [
		getWeaponCargo _object,
		getMagazineCargo _object,
		getBackpackCargo _object,
		_object getVariable["bankMoney",0]
	];
	```

##IN YOUR 'server_monitor.sqf'

NOTE: the " _intentory' variable can be called "_inventory" at your files, so change my code to that, if it's the case).

1. ADD
	```
	if( count (_inventory) > 3)then{
		_object setVariable ["bankMoney", _inventory select 3, true];
	}else{
	        _object setVariable ["bankMoney", 0, true];
	};
	```
	* ABOVE
	```
	if (_type in DZE_LockedStorage) then {
		// Fill variables with loot
		_object setVariable ["WeaponCargo", (_inventory select 0),true];
		_object setVariable ["MagazineCargo", (_inventory select 1),true];
		_object setVariable ["BackpackCargo", (_inventory select 2),true];
	} else {
	```

##IN YOUR 'server_playerSync.sqf'

1. REPLACE
	```
	_playerGear = [weapons _character,_magazines];
	```
	* WITH
	```
	_playerGear = [weapons _character,_magazines, _character getVariable["cashMoney",0]];
	```

1. REPLACE
	```
	_key = format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity];
	```
	* WITH
	```
	_key = format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity,_cashMoney];
	```

1. ADD
	```
	_cashMoney = ["cashMoney",_character] call server_getDiff2;
	```
	* AFTER
	```
	_killsH = 		["humanKills",_character] call server_getDiff;
	_headShots = 	["headShots",_character] call server_getDiff;
	_humanity = 	["humanity",_character] call server_getDiff2;
	```
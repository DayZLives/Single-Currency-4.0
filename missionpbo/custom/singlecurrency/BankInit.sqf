#include "BankConfig.sqf" 

ATMDialogTransferAmount = 23000;
ATMDialogPlayerBalance = 23001;
ATMDialogBankBalance = 23002;

ATMDialogUpdateAmounts = {
	ctrlSetText [AtmDialogPlayerBalance, format["%1 %2", (player getVariable ['cashMoney', 0] call BIS_fnc_numberText), CurrencyName]];
	ctrlSetText [AtmDialogBankBalance, format["%1 %2", (player getVariable ['bankMoney', 0] call BIS_fnc_numberText), CurrencyName]];
};

ATMDialogWithdrawAmount = {

	private ["_amount","_bank","_wealth"];

	_amount = parseNumber (_this select 0);	
	_bank = player getVariable ["bankMoney", 0];
	_wealth = player getVariable["cashMoney",0];
	
	if(_amount > 999999) exitWith { cutText ["You can not withdraw more then 999,999 coins at once.", "PLAIN DOWN"]; };
	if(_amount < 1 or _amount > _bank) exitWith { cutText ["You can not withdraw more than is in your bank.", "PLAIN DOWN"]; };

	player setVariable["cashMoney",(_wealth + _amount),true];
	player setVariable["bankMoney",(_bank - _amount),true];

	PVDZE_plr_Save = [player,(magazines player),true,true] ;
	publicVariableServer "PVDZE_plr_Save";

	PVDZE_bank_Save = [player];
	publicVariableServer "PVDZE_bank_Save";

	cutText [format["You have withdrawn %1 %2.", [_amount] call BIS_fnc_numberText, CurrencyName], "PLAIN DOWN"];

};

ATMDialogDepositAmount = {

	private ["_amount","_bank","_wealth"];

	_amount = parseNumber (_this select 0);
	_bank = player getVariable ["bankMoney", 0];
	_wealth = player getVariable["cashMoney",0];

	if(_amount > 999999) exitWith { cutText ["You can not deposit more then 999,999 coins at once.", "PLAIN DOWN"]; };
    if (_amount < 1 or _amount > _wealth) exitWith { cutText ["You can not deposit more than you have.", "PLAIN DOWN"]; };

	if(LimitOnBank && ((_bank + _amount ) >  MaxBankMoney )) then {
	if( (getPlayerUID player in DonatorBank ) && ((_bank + _amount ) <  MaxDonatorBankMoney )) then { 
		player setVariable["cashMoney",(_wealth - _amount),true];
		player setVariable["bankMoney",(_bank + _amount),true];		
		cutText [format["You have deposited %1 %2.", [_amount] call BIS_fnc_numberText, CurrencyName], "PLAIN DOWN"];			
	} else {
		cutText [format["You can only have a max of %1 %3, donators %2", [MaxBankMoney] call BIS_fnc_numberText,[MaxDonatorBankMoney] call BIS_fnc_numberText,CurrencyName], "PLAIN DOWN"];
	};
	} else {
		player setVariable["cashMoney",(_wealth - _amount),true];
		player setVariable["bankMoney",(_bank + _amount),true];
		cutText [format["You have deposited %1 %2", [_amount] call BIS_fnc_numberText, CurrencyName], "PLAIN DOWN"];
	};

	PVDZE_plr_Save = [player,(magazines player),true,true] ;
	publicVariableServer "PVDZE_plr_Save";
	PVDZE_bank_Save = [player];
	publicVariableServer "PVDZE_bank_Save";

};


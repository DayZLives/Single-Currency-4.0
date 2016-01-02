private ["_player","_amount","_savings","_newwealth", "_result"];			
_player =  _this select  0;
_amount =  _this select  1;
_result = false;	
_savings = _player getVariable["cashMoney",0];
_player setVariable["cashMoney",_savings + _amount, true];
PVDZE_plr_Save = [_player,(magazines _player),true,true] ;
publicVariableServer "PVDZE_plr_Save";
_player setVariable ["moneychanged",1,true];					
_newwealth = _player getVariable["cashMoney",0];		
if (_newwealth >= _savings) then { _result = true; };			
_result
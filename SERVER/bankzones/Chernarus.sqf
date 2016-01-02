if (isServer) then {
// Banker - in Stary Trade City
_unit_1301 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [6324.71, 7787, 0.00143433], [], 0, "CAN_COLLIDE"];
  _unit_1301 = _this;
	_this setDir 64;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};

// Banker - in Bash Trade City
_unit_1302 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [4057.35, 11662.7, 0.000128174], [], 0, "CAN_COLLIDE"];
  _unit_1302 = _this;
  _this setDir 47;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};

// Banker - in Klen Trade City
_unit_1303 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [11461, 11348.6, 0.00143433], [], 0, "CAN_COLLIDE"];
  _unit_1303 = _this;
  _this setDir 312;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};

};

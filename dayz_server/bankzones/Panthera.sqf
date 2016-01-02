if (isServer) then {
// Banker
_unit_222 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [4770.4067, 7482.2651, -1.6927719e-005], [], 0, "CAN_COLLIDE"];
  _unit_222 = _this;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};


// Banker
_unit_224 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [4431.1997, 1616.5604, 1.9073486e-006], [], 0, "CAN_COLLIDE"];
  _unit_224 = _this;
  _this setDir -85.139679;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};

// Banker
_unit_226 = objNull;
if (true) then
{
  _this = createAgent ["Functionary1_EP1_DZ", [8252.4922, 15494.612, 0.22058211], [], 0, "CAN_COLLIDE"];
  _unit_226 = _this;
  _this setDir 93.33667;
  _this setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0; this setVariable [""BankerBot"",1,true];";
  _this setUnitAbility 0.60000002;
_this allowDammage false; _this disableAI 'FSM'; _this disableAI 'MOVE'; _this disableAI 'AUTOTARGET'; _this disableAI 'TARGET'; _this setBehaviour 'CARELESS'; _this forceSpeed 0; _this enableSimulation false;_this setVariable ["BankerBot",1,true];};

};



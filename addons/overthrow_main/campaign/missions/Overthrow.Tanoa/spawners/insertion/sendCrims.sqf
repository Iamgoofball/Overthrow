private ["_pos","_town","_townPos","_drop","_group","_start","_stability","_vehtype","_num","_count","_police","_group","_tgroup","_wp","_attackdir","_vehtype","_civ"];

_leaderpos = _this select 0;
_numcrim = _this select 1;
_town = _this select 2;
_townPos = server getVariable _town;

_region = server getVariable format["region_%1",_town];
_mob = _townPos call nearestMobster;
_mobpos = _mob select 0;
if !([_mobpos,_region] call fnc_isInMarker) exitWith {[_town,1] call stability};

_num = server getVariable [format ["numcrims%1",_town],0];
server setVariable [format ["numcrims%1",_town],_num + _numcrim,false];	

_group = creategroup east;

_count = 0;
_start = [[[_mobpos,40]]] call BIS_fnc_randomPos;
while{_count < _numcrim} do {
	
	_civ = _group createUnit [OT_CRIM_Unit, _start, [],0, "NONE"];
	[_civ] joinSilent nil;
	[_civ] joinSilent _group;
	_civ setRank "SERGEANT";
	_civ setCombatMode "RED";
	
	[_civ,_town] call initCriminal;
	_count = _count + 1;
	_start = [[[_mobpos,40]]] call BIS_fnc_randomPos;
};	

_dir = [_leaderpos,_mobpos] call BIS_fnc_dirTo;
_moveto = [_leaderpos,300,_dir] call SHK_pos;

_move = _group addWaypoint [_moveto,0];
_move setWaypointType "MOVE";
_move setWaypointSpeed "FULL";
_move setWaypointBehaviour "COMBAT";

_move = _group addWaypoint [_leaderpos,0];
_move setWaypointType "GUARD";
_move setWaypointSpeed "NORMAL";
_move setWaypointBehaviour "STEALTH";

_group call distributeAILoad;

_group
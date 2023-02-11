private _msize = 150;
private _test = _this;

if(_test isEqualType "") then {
    if ((_test in OT_capitals) || (_test in OT_sprawling)) then {
        _msize = 500;
    };
    _test = server getvariable _test;
};

// uniform sampling density inside a circle of 100m and decreasing density outside of it, up to _msize
private _rand = random 100;
private _pos = _test getPos [(_rand + random (_msize - _rand)), random 360];
private _roads = _pos nearRoads 100;
if(count _roads > 0) exitWith {
    getPosATL (_roads select 0)
};
_pos

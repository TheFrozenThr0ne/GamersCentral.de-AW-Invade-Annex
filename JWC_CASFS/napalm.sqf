  _pos = _this select 0;
  _expire = _this select 1;

  if (time > _expire) exitWith {};

  _obj = createAgent ["Logic", [_pos select 0, _pos select 1, 0], [] , 0 , "CAN_COLLIDE"];

  tmp = _obj;

  [tmp] spawn
  {
    _source = _this select 0;
    while {true} do
    {
      _source say3D "fire";
      _time = time + 13;
      waitUntil{(time >= _time) || (!alive _source)};
      if (!alive _source) exitWith {};
    };
  };

  [tmp] spawn
  {
    _obj1 = _this select 0;
    while {true} do
    {
      if (((player distance _obj1) <= 100)) then
      {
        _color = ppEffectCreate ["ColorCorrections", 1234];
        _color ppEffectEnable true;
        _color ppEffectAdjust [0.25, 1, 0, [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]];
        _color ppEffectCommit 1;
        player say3D "pain";
        sleep 0.5;
        ppEffectDestroy _color;
      };
      if (!alive _obj1) exitWith {};
      sleep 0.5;
    };
  };

  _pos = getPosATL _obj;
  _pos1 = [(_pos select 0), (_pos select 1)+20, 0];
  _pos1x = [(_pos select 0)-10, (_pos select 1)+10, 0];
  _pos2 = [(_pos select 0)-20, (_pos select 1), 0];
  _pos2x = [(_pos select 0)-10, (_pos select 1)-10, 0];
  _pos3 = [(_pos select 0), (_pos select 1)-20, 0];
  _pos3x = [(_pos select 0)+10, (_pos select 1)-10, 0];
  _pos4 = [(_pos select 0)+20, (_pos select 1), 0];
  _pos4x = [(_pos select 0)+10, (_pos select 1)+10, 0];

  _smoke1 = "#particlesource" createVehicleLocal [(_pos1 select 0),(_pos1 select 1)-5,-2];
  _smoke1 setParticleClass "BigDestructionSmoke";
  _smoke1 setParticleFire [1,1,1];

  _smoke2 = "#particlesource" createVehicleLocal [(_pos2 select 0)+5,(_pos2 select 1),-2];
  _smoke2 setParticleClass "BigDestructionSmoke";
  _smoke2 setParticleFire [1,1,1];

  _smoke3 = "#particlesource" createVehicleLocal [(_pos3 select 0),(_pos3 select 1)+5,-2];
  _smoke3 setParticleClass "BigDestructionSmoke";
  _smoke3 setParticleFire [1,1,1];

  _smoke4 = "#particlesource" createVehicleLocal [(_pos4 select 0)-5,(_pos4 select 1),-2];
  _smoke4 setParticleClass "BigDestructionSmoke";
  _smoke4 setParticleFire [1,1,1];

  _smoke5 = "#particlesource" createVehicleLocal [(_pos1x select 0),(_pos1x select 1)-5,-2];
  _smoke5 setParticleClass "BigDestructionSmoke";
  _smoke5 setParticleFire [1,1,1];

  _smoke6 = "#particlesource" createVehicleLocal [(_pos2x select 0)+5,(_pos2x select 1),-2];
  _smoke6 setParticleClass "BigDestructionSmoke";
  _smoke6 setParticleFire [1,1,1];

  _smoke7 = "#particlesource" createVehicleLocal [(_pos3x select 0),(_pos3x select 1)+5,-2];
  _smoke7 setParticleClass "BigDestructionSmoke";
  _smoke7 setParticleFire [1,1,1];

  _smoke8 = "#particlesource" createVehicleLocal [(_pos4x select 0)-5,(_pos4x select 1),-2];
  _smoke8 setParticleClass "BigDestructionSmoke";
  _smoke8 setParticleFire [1,1,1];

  _color = [1, 1, 1];
  _velocity = wind;

  _ps1 = "#particlesource" createVehicleLocal _pos1;
  _ps1 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps1 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps1 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps1 setDropInterval 0.022;

  _ps2 = "#particlesource" createVehicleLocal _pos1;
  _ps2 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps2 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps2 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps2 setDropInterval 0.006;

  _ps3 = "#particlesource" createVehicleLocal _pos2;
  _ps3 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps3 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps3 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps3 setDropInterval 0.022;
 
  _ps4 = "#particlesource" createVehicleLocal _pos2;
  _ps4 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps4 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps4 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps4 setDropInterval 0.006;

  _ps5 = "#particlesource" createVehicleLocal _pos3;
  _ps5 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps5 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps5 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps5 setDropInterval 0.022;
 
  _ps6 = "#particlesource" createVehicleLocal _pos3;
  _ps6 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps6 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps6 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps6 setDropInterval 0.006;

  _ps7 = "#particlesource" createVehicleLocal _pos4;
  _ps7 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps7 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps7 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps7 setDropInterval 0.022;
 
  _ps8 = "#particlesource" createVehicleLocal _pos4;
  _ps8 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps8 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps8 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps8 setDropInterval 0.006;

  _ps9 = "#particlesource" createVehicleLocal _pos1x;
  _ps9 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps9 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps9 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps9 setDropInterval 0.022;
 
  _ps10 = "#particlesource" createVehicleLocal _pos1x;
  _ps10 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps10 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps10 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps10 setDropInterval 0.006;

  _ps11 = "#particlesource" createVehicleLocal _pos2x;
  _ps11 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps11 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps11 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps11 setDropInterval 0.022;
 
  _ps12 = "#particlesource" createVehicleLocal _pos2x;
  _ps12 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps12 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps12 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps12 setDropInterval 0.006;

  _ps13 = "#particlesource" createVehicleLocal _pos3x;
  _ps13 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps13 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps13 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps13 setDropInterval 0.022;
 
  _ps14 = "#particlesource" createVehicleLocal _pos3x;
  _ps14 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps14 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps14 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps14 setDropInterval 0.006;

  _ps15 = "#particlesource" createVehicleLocal _pos4x;
  _ps15 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 1, 12, 0], "", "Billboard", 1, 2 + random 3, [0, 0, 5], _velocity, 1, 1.1, 1, 0, [.3 + (random 1)], [_color + [0], _color + [0.31], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps15 setParticleRandom [3, [5 + (random 1), 4 + (random 1), 7], [random 4, random 4, 2], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps15 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps15 setDropInterval 0.022;
 
  _ps16 = "#particlesource" createVehicleLocal _pos4x;
  _ps16 setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 3, 12, 0], "", "Billboard", 1, 1 + random 1, [5, 5, 4], _velocity, 1, 1.1, 1, 0, [.5 + (random .5)], [_color + [0], _color + [0.35], _color + [0]], [1000], 1, 0, "", "", 1];
  _ps16 setParticleRandom [3, [1 + (random 1), 4 + (random 1), 9], [random 5, random 2, 1], 14, 3, [0, 0, 0, .1], 1, 0];
  _ps16 setParticleCircle [1, [0.5, 0.5, 0]];
  _ps16 setDropInterval 0.006;

  waitUntil{time > _expire};

  deleteVehicle _obj;
  deleteVehicle _smoke1;
  deleteVehicle _smoke2;
  deleteVehicle _smoke3;
  deleteVehicle _smoke4;
  deleteVehicle _smoke5;
  deleteVehicle _smoke6;
  deleteVehicle _smoke7;
  deleteVehicle _smoke8;
  deleteVehicle _ps1;
  deleteVehicle _ps2;
  deleteVehicle _ps3;
  deleteVehicle _ps4;
  deleteVehicle _ps5;
  deleteVehicle _ps6;
  deleteVehicle _ps7;
  deleteVehicle _ps8;
  deleteVehicle _ps9;
  deleteVehicle _ps10;
  deleteVehicle _ps11;
  deleteVehicle _ps12;
  deleteVehicle _ps13;
  deleteVehicle _ps14;
  deleteVehicle _ps15;
  deleteVehicle _ps16;

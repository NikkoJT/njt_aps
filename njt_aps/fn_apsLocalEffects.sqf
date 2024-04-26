// APS - LOCAL EFFECTS MODULE
// This function generates particle effects when the APS activates.

params ["_projectilePos","_vehicle"];

private _emitter1 = "#particlesource" createVehicleLocal _projectilePos;
private _emitter2 = "#particlesource" createVehicleLocal (getPosATL _vehicle);
private _emitter3 = "#particlesource" createVehicleLocal (getPosATL _vehicle) vectorAdd (getPosATL _vehicle vectorFromTo _projectilePos);

_emitter1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,18,[0,0,0],[0,0,0],1,1.00,0.8,0.15,[4,15],[[0.158897,0.143513,0.116593,0.693464],[0.6,0.6,0.6,0.15],[0.7,0.7,0.7,0.06],[1,1,1,0.01]],[0.5],0.2,0.1,"","","",0,false,0,[[0,0,0,0]],[0,1,0]];
_emitter1 setParticleRandom [2,[3,3,6],[0,0,0],10,0.3,[0,0,0,0.3],0,0,360,0];
_emitter1 setParticleCircle [0,[0,0,0]];
_emitter1 setParticleFire [0,0,0];
_emitter1 setDropInterval 0.005;

_emitter2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,12,13,0],"","Billboard",1,15,[0,0,0],[0,0,0.01],0,1.276,1,0.03,[0.8,5,9,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12],[[0.2,0.2,0.2,0.2],[0.2,0.2,0.2,0.16],[0.2,0.2,0.2,0.12],[0.2,0.2,0.2,0.1],[0.2,0.2,0.2,0.8],[0.2,0.2,0.2,0.6],[0.2,0.2,0.2,0.3],[0.2,0.2,0.2,0.01]],[1000],0.1,0.02,"","","",0,false,0,[[0,0,0,0]]];
_emitter2 setParticleRandom [5,[10,10,1],[0.4,0.4,0.1],30,0.3,[0,0,0,0],0,0,1,0];
_emitter2 setParticleCircle [10,[0,0,0]];
_emitter2 setParticleFire [0,0,0];
_emitter2 setDropInterval 0.09;

_emitter3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,2,[0,0,0],[0,0,0.2],0,0.05,0.05,0.05,[3,4,5],[[0.5,0.4,0.3,0.06],[0.5,0.4,0.3,0.11],[0.5,0.4,0.3,0.06],[0.5,0.4,0.3,0.05],[0.5,0.4,0.3,0.015],[0.6,0.5,0.4,0]],[1000],0.1,0.05,"","","",0,false,0,[[0,0,0,0]]];
_emitter3 setParticleRandom [1,[2,2,0.2],[3,3,0.15],20,0.2,[0,0,0,0],0,0,0,0];
_emitter3 setParticleCircle [1,[1,1,0]];
_emitter3 setDropInterval 0.001;

uisleep 1;
deleteVehicle _emitter1;
deleteVehicle _emitter3;
uisleep 2;
deleteVehicle _emitter2;
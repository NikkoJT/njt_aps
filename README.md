# njt_aps
Active Protection System for Arma 3 vehicles

WARNING:    
This system relies on high-frequency scanning for projectiles. Low frame rate on the shooter's machine can make the system less reliable, especially at close range with high-velocity projectiles.

This system uses remoteExec. If your CfgRemoteExec is restrictive, the system may not work properly.

_APS uses continuous local checking to detect and destroy projectiles that threaten the protected vehicle._

OPERATION:    
The system automatically detects nearby Shells, Rockets, and Missiles, and destroys them if they're on a collision course with the vehicle.    
Destroying the projectile causes a small explosion that is hazardous to infantry.    
The APS detection range is 50m by default. Projectiles in that range will be monitored for about 2 seconds to determine if they're on an impact trajectory.    
Fast-moving projectiles fired from closer than the detection range may not be identified in time to successfully intercept, although the system may try anyway.    

The system can be toggled off or on by the vehicle commander. On a newly-configured vehicle, the system is OFF by default.
 
The system activates for 2 seconds and does not automatically recharge.
A player with the Engineer trait can reload the APS from outside the vehicle. This recharges the APS.

NOTE:    
This system relies on the presence of the Folk ARPS FA3 Enhanced FCS module to display HUD warnings for players. If that module is not present in the mission, this system will not display visual warnings for APS activations and state changes.
The system also expects the FA3 Briefing to be present to display its briefing tab. If it's not, you'll need to modify the fn_apsBriefing.sqf file to change the relevant waitUntil.

EXECUTION:
Run this code on all machines and JIP:
`[_vehicle] call njt_fnc_apsInit;`
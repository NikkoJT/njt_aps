# njt_aps
Active Protection System for Arma 3 vehicles

WARNING:    
This system is currently in beta and isn't guaranteed to work properly.

APS uses continuous local checking to detect and destroy projectiles that threaten the protected vehicle.

OPERATION:    
The system automatically detects nearby Shells, Rockets, and Missiles, and destroys them if they're on a collision course with the vehicle.    
Destroying the projectile causes a small explosion that is hazardous to infantry.    
The APS detection range is 90m by default. Projectiles in that range will be monitored for about half a second to determine if they're on an impact trajectory.    
Fast-moving projectiles fired from closer than the detection range may not be identified in time to successfully intercept, although the system may try anyway.    

The system can be toggled off or on by the vehicle commander.

CONFIGURATION:    
The system has two main modes of operation and one modifier that can be applied to either mode. The system is configured in init.sqf.    
1. Cooldown    
In this mode, the system activates for 2 seconds and then has a cooldown period before it can activate again. The cooldown period can be specified.
2. Single-use    
In this mode, the system activates for 2 seconds and does not automatically recharge.
3. Modifier    
The system can be set to allow manual reloading. When this is enabled, a player with the Engineer trait can reload the APS from outside the vehicle. This resets the cooldown, and recharges the APS if it's in single-use mode.

NOTE:    
This system relies on the presence of the Folk ARPS F3 Enhanced FCS module to display HUD warnings for players. If that module is not present in the mission, this system must be modified to remove those warnings.

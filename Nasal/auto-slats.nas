# Deploys or retracts slats based on speed
# The slats are said to retract when speed is under around 120 km/h 
# It also depends on incidence, but so far I didn't find a way to retrieve incidence in the property tree
# That will be a rough approximation then :)



var autoslats = func {

	var airspeed = getprop("/velocities/airspeed-kt");
	if ( airspeed < 68 and airspeed > 64 )
		{
		var slatout = 17 -( airspeed / 4 );
		setprop("/controls/flight/slats", slatout);
		} 
	if ( airspeed >= 68 )
		{
		setprop("/controls/flight/slats", 0.0);
		}
	if ( airspeed <= 64 )
		{
		setprop("/controls/flight/slats", 1.0);
		}
	settimer(autoslats,0);
}

autoslats();

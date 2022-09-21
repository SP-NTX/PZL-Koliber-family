#Fuel.nas
# Ale fajne! normalnie NTX to wykorzysta

var fuel_selector = func {
	var selected  = getprop("/controls/fuel/selector");

	setprop("/controls/fuel-valve/from-tank_0", 0);
	setprop("/controls/fuel-valve/from-tank_1", 0);

	if(selected == -1) {
		setprop("/controls/fuel-valve/from-tank_0", 1);
		setprop("/controls/fuel-valve/from-tank_1", 0);
	}
	if(selected == 0) {
		setprop("/controls/fuel-valve/from-tank_0", 0);
		setprop("/controls/fuel-valve/from-tank_1", 0);
	}
	if(selected == 1) {
	setprop("/controls/fuel-valve/from-tank_0", 0);
		setprop("/controls/fuel-valve/from-tank_1", 1);
	}
};
setlistener("/controls/fuel/selector", fuel_selector);


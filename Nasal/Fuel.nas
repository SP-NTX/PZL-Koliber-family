#Fuel.nas
#Spis pomocy:
# Ale fajne! normalnie NTX to wykorzysta

#Ustawiamy przełącznik zbiorników paliwa

var FuelSelector=func {
var selected  = getprop("/controls/fuel-selector");

    setprop("/controls/engines/engine[0]/feed", 3);

if(selected == -1) {
    setprop("/controls/engines/engine[0]/feed", 0);

    }
if(selected == 0) {
    setprop("/controls/engines/engine[0]/feed", 3);
    }
if(selected == 1) {
    setprop("/controls/engines/engine[0]/feed", 1);
    }
settimer(FuelSelector, 0);
};

FuelSelector();


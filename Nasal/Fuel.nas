#Fuel.nas
#Spis pomocy:
#pa28-181

#Ustawiamy przełącznik zbiorników paliwa

var FuelSelector=func {
var selected  = getprop("/controls/fuel-selector");

setprop("/consumables/fuel/tank[0]/selected", 0);
setprop("/consumables/fuel/tank[1]/selected", 0);

if(selected == -1) {
    setprop("/consumables/fuel/tank[0]/selected", 1);
    setprop("/consumables/fuel/tank[1]/selected", 0);
    }
if(selected == 0) {
    setprop("/consumables/fuel/tank[0]/selected", 0);
    setprop("/consumables/fuel/tank[1]/selected", 0);
    }
if(selected == 1) {
    setprop("/consumables/fuel/tank[0]/selected", 0);
    setprop("/consumables/fuel/tank[1]/selected", 1);
    }
settimer(FuelSelector, 0);
};

FuelSelector();


# Funkcje pomocnicze. Nie wszystkie dane potrzebne do działania
# kokpitu są dostepne. Niektóre z nich trzeba przetworzyć aby mieć
# to co chcemy.
# EGT Exhaust Gas Temperature - temperatura gazów spalinowych
# CHT Cylinder Head Temperature - temperatura głowic silnika
# GPH Gallons Per Hour - spalanie galonów na godzinę
var disengage_starter_timer = maketimer(2, func { props.globals.setBoolValue("/controls/engines/engine/starter", 0); });
disengage_starter_timer.singleShot = 1;

var autostart = func {
	props.globals.setBoolValue("/controls/electric/battery-switch", 1);
	props.globals.setBoolValue("/controls/engines/engine/master-alt", 1);
	props.globals.setBoolValue("/controls/switches/alternator", 1);
	props.globals.setBoolValue("/controls/switches/battery", 1);
	props.globals.setBoolValue("/controls/switches/turn-coordinator", 1);
	props.globals.setBoolValue("/controls/switches/beacon", 1);
	props.globals.setIntValue("/controls/engines/engine/magnetos", 3);
	props.globals.setIntValue("/controls/engines/engine/primer-pump", 6);
	props.globals.setDoubleValue("/controls/engines/engine/throttle", 0.15);
	props.globals.setDoubleValue("/controls/engines/engine/mixture", 1);
	props.globals.setIntValue("/controls/fuel/selector", 1);
	props.globals.setBoolValue("/controls/engines/engine/starter", 1);
	disengage_starter_timer.start();
}

#*********** KONTROLKA ALTERNATORA *******************
#Dodałem napięcie /systems/electrical/outputs/alt-light
# Muszę wykorzystać jakiś dodatkowy punkt odczytu dla
# lampki.
var AltLight = func{
	var voltage = getprop("systems/electrical/outputs/alt-light");
	var amper = getprop("systems/electrical/suppliers/alternator");
	var rpm = getprop("engines/engine/rpm") or 0.00;
	var AltSwitch = getprop("controls/switches/alternator");

	if (voltage == 24 and amper < 12) {
		setprop("controls/engines/engine/master-alt", 1);
	} else {
		setprop("controls/engines/engine/master-alt", 0);
	}
	settimer(AltLight, 0);
}

var ClickStart = func(){
	var fuelpump = getprop("controls/engines/engine[0]/fuel-pump");
	var masterbat = getprop("controls/engines/engine/master-bat");
#	if (fuelpump == "0") {setprop("controls/engines/engine/magnetos", 0);}
	if (masterbat == 0) {setprop("controls/engines/engine/magnetos", 0);}
	settimer(ClickStart, 1);
}

var CarbTemp = func(){
    var temp = getprop("/environment/temperature-degc");
    var heatingswitch = getprop("/controls/anti-ice/engine/carb-heat");
    var rpm = getprop("/engines/engine/rpm") or 0.0;
    if (heatingswitch != 1 and rpm <= 1000){
        setprop("/engines/engine/carb-temp-degc", temp);
    } else if (heatingswitch !=1 and rpm > 1000){
        var temp += 5;
        setprop("/engines/engine/carb-temp-degc", temp);
    } else if (heatingswitch = 1){
   	 setprop("/engines/engine/carb-temp-degc", 20);
    }
    
    settimer(CarbTemp, 0);
}
#Carburettor icing probability


#*************Wywolanie funkcji*************#
#ClickStart();
AltLight();
CarbTemp();

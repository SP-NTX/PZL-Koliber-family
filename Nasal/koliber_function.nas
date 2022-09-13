# Funkcje pomocnicze. Nie wszystkie dane potrzebne do działania
# kokpitu są dostepne. Niektóre z nich trzeba przetworzyć aby mieć
# to co chcemy.
# EGT Exhaust Gas Temperature - temperatura gazów spalinowych
# CHT Cylinder Head Temperature - temperatura głowic silnika
# GPH Gallons Per Hour - spalanie galonów na godzinę

#******************* USTAWIENIA POCZĄTKOWE **************************
# ------------------ the initial settings ---------------------------#
setprop("instrumentation/nav/power-btn", "False");
setprop("controls/engines/engine/magnetos", 0);
#setprop("/consumables/fuel/tank[0]/selected",0);
#setprop("/consumables/fuel/tank[1]/selected",0);
var time1 = 1;
var time2 = 2;
var time3 = 3;
var time4 = 4;
var time5 = 5;

#*********** KONTROLKA ALTERNATORA *******************
#Dodałem napięcie /systems/electrical/outputs/alt-light
# Muszę wykorzystać jakiś dodatkowy punkt odczytu dla
# lampki.
var AltLight = func{
	var voltage = getprop("systems/electrical/outputs/alt-light");
	var amper = getprop("systems/electrical/suppliers/alternator");
	var rpm = getprop("engines/engine/rpm") or 0.00;
	var sumrpm = rpm+1;
	var AltSwitch = getprop("controls/switches/alternator");

	if (voltage == "24" and amper < "12") {
		setprop("controls/engines/engine/master-alt", 1);
	}
	else{
		setprop("controls/engines/engine/master-alt", 0);
	}
	settimer(AltLight,0);
}

var ClickStart = func(){
	var fuelpump = getprop("controls/engines/engine[0]/fuel-pump");
	var masterbat = getprop("controls/engines/engine/master-bat");
#	if (fuelpump == "0") {setprop("controls/engines/engine/magnetos", 0);}
	if (masterbat == "0") {setprop("controls/engines/engine/magnetos", 0);}
	settimer(ClickStart, time1);
}

var CarbTemp = func(){
    var temperatura = getprop("/environment/temperature-degc");
    var heatingswitch = getprop("/controls/anti-ice/engine/carb-heat");
    var rpm = getprop("engines/engine/rpm") or 0.00;
    if (heatingswitch != 1 and rpm <= "1000"){
        setprop("engines/engine/carb-temp-degc", temperatura);
    }
    else if (heatingswitch !=1 and rpm > "1000"){
        var temperatura-=5;
        setprop("/engines/engine/carb-temp-degc", temperatura);
    }
    else if (heatingswitch = 1){
    setprop("/engines/engine/carb-temp-degc", 20);
    }
    
    settimer(CarbTemp,0);
}
#Carburettor icing probability


#*************Wywolanie funkcji*************#
#ClickStart();
AltLight();
CarbTemp();
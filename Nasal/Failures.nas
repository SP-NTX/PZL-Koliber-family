var pitot_fail = func {
    var pitot_heat = getprop("controls/anti-ice/pitot-heat");
    var oat = getprop("environment/temperature-degc");
    var dew_point = getprop("environment/dewpoint-degc");

    ## Set a mark ##
    if ((oat <= 0 and oat <= dew_point) and pitot_heat != 1) {
        setprop("hazards/icing/pitot",1);
    } else {
        setprop("hazards/icing/pitot",0);
    }
            ####### Set custom timer #####
    if ((oat <= 0 and oat <= dew_point) and pitot_heat != 1) {
        pitot_icing_time = getprop("sim/time/elapsed-sec");
    }
    if ((oat > 0 or oat > dew_point) or pitot_heat == 1) {
        pitot_no_icing_time = getprop("sim/time/elapsed-sec");
    }

        ######## Set icing index based on timer #######
    if (oat <= 0 and oat <= dew_point and pitot_heat != 1){
        pitot_icing_index = pitot_icing_time - pitot_no_icing_time
    }
              #### Icing ####   
    if (oat <= 0 and oat <= dew_point and pitot_heat != 1) {

        if ((getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-pitot_icing_index)>0) {
            setprop("instrumentation/airspeed-indicator/indicated-speed-kt",  getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-pitot_icing_index);
	} else {
            setprop("instrumentation/airspeed-indicator/serviceable",0);
	    setprop("instrumentation/altimeter[0]/serviceable",0);
            setprop("instrumentation/altimeter[1]/serviceable",0);
            setprop("instrumentation/vertical-speed-indicator/serviceable",0);
	    setprop("instrumentation/vertical-speed-indicator/indicated-speed-fpm",0);
	    setprop("instrumentation/airspeed-indicator/indicated-speed-kt",0);
	}
    }

              ### Deicing ###
    if ((oat > 0 or oat > dew_point or pitot_heat == 1) and getprop("instrumentation/airspeed-indicator/serviceable") == 0) {
	setprop("instrumentation/altimeter[0]/serviceable",1);
	setprop("instrumentation/altimeter[1]/serviceable",1);
	setprop("instrumentation/vertical-speed-indicator/serviceable",1);
        if (getprop("instrumentation/airspeed-indicator/indicated-speed-kt") < getprop("velocities/airspeed-kt")) {
	    setprop("instrumentation/airspeed-indicator/indicated-speed-kt", getprop("instrumentation/airspeed-indicator/indicated-speed-kt") + 0.1);
	} else {
            setprop("instrumentation/airspeed-indicator/serviceable",1);
	    pitot_icing_index = 0
	}
    }

    settimer(pitot_fail,0);
}

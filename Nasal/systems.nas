# PZL Koliber 160A Systems
# Copyright (c) 2024 SP-NTX

var FUEL = {

	Switches: {
		Primer: {
			position: props.globals.getNode("/controls/engines/engine/primer-pump-pos"),
			primerN: props.globals.getNode("/controls/engines/engine/primer"),
		},
	},

	Valve: {
		fromTank0: props.globals.getNode("/controls/fuel-valve/from-tank_0"),
        fromTank1: props.globals.getNode("/controls/fuel-valve/from-tank_1"),
		selector: props.globals.getNode("/controls/fuel/selector"),
	},

	init: func() {
		me.Valve.fromTank0.setBoolValue(0);
		me.Valve.fromTank0.setBoolValue(0);
		me.Valve.selector.setValue(0);
		me.Switches.Primer.position.setBoolValue(0);
		me.Switches.Primer.primerN.setValue(0);
	},

};

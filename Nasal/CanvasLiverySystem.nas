# SP-NTX's Canvas Livery System
# Copyright (C) SP-NTX 2022-2025

var liveryCanvas = canvas.new({
  "name": "Livery System",
  "size": [2048, 2048],
  "view": [2048, 2048],
  "mipmapping": 1 
});
var liveryCanvasSeats = canvas.new({
  "name": "Seats System",
  "size": [2048, 2048],
  "view": [2048, 2048],
  "mipmapping": 1 
});

var root = liveryCanvas.createGroup();
var seatroot = liveryCanvasSeats.createGroup();
var update = func(){
var layers = {};
var path="Aircraft/PZL-Koliber-family/Models/"; # IF YOU WANT TO USE IT WITH OTHER AIRCRAFTS JUST CHANGE THIS
var image= getprop('sim/model/livery/texture');
layers[image] = root.createChild("image")
     .setFile(path~image)
     .setSize(2048,2048);
print ('1>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>',path~image);
layers[image].show();
liveryCanvas.addPlacement({"node": "fuselage"});
liveryCanvas.addPlacement({"node": "fuselage.011"}); 
liveryCanvas.addPlacement({"node": "fuselage.002"}); 
liveryCanvas.addPlacement({"node": "canopy-back"}); 
##liveryCanvas.addPlacement({"node": "canopy-front"}); # TEXTURE FOR THIS HAS NOT BEEN SET YET
liveryCanvas.addPlacement({"node": "hstab"});
liveryCanvas.addPlacement({"node": "vstab"});
liveryCanvas.addPlacement({"node": "RudderTrimTab"});
liveryCanvas.addPlacement({"node": "left-aileron"});
liveryCanvas.addPlacement({"node": "right-aileron"});
liveryCanvas.addPlacement({"node": "left-flap"});
liveryCanvas.addPlacement({"node": "right-flap"});
liveryCanvas.addPlacement({"node": "left-slat"});
liveryCanvas.addPlacement({"node": "right-slat"});
liveryCanvas.addPlacement({"node": "wing"});
liveryCanvas.addPlacement({"node": "wing.001"});
var seatimage= getprop('sim/model/livery/seats');
print ('2>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>',path~seatimage);
layers[seatimage] = seatroot.createChild("image")
     .setFile(path~seatimage)
     .setSize(2048,2048);

layers[seatimage].show();
liveryCanvasSeats.addPlacement({"node": "Cube.003"});
liveryCanvasSeats.addPlacement({"node": "Cube.007"}); 

};
setlistener("sim/model/livery/livery-change", func {
update();
setprop("sim/model/livery/livery-change", 0);
}, 1, 0);

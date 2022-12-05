var liveryCanvas = canvas.new({
  "name": "Livery System",
  "size": [2048, 2048],
  "view": [2048, 2048],
  "mipmapping": 1 
});

var root = liveryCanvas.createGroup();
var update = func(){
var layers = {};
var path="Aircraft/PZL-Koliber-family/Models/"; # IF YOU WANT TO USE IT WITH OTHER AIRCRAFTS JUST CHANGE THIS
var image= getprop('/sim/model/livery/texture');
layers[image] = root.createChild("image")
     .setFile(path~image)
     .setSize(2048,2048);

layers[image].show();
liveryCanvas.addPlacement({"node": "fuselage"}); # AND THOSE WITH THE OBJECTS THAT LIVERY NEED TO BE APPLIED
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
};
setlistener("/sim/model/livery/livery-change", func {
update();
setprop("/sim/model/livery/livery-change", 0);
}, 1, 0);
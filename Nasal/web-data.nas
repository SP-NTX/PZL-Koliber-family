var currentVersion = io.readfile(getprop("/sim/aircraft-dir") ~ "/version.txt");
var webVersion = 0;
var updateVersion = 0;
var break = 0;
var notUseWeb = 0;


var update = func(){
	webVersion = http.load("")
}
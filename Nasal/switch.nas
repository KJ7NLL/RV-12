# switch.nas | namespace switch
# KJ7NLL, Phoenix

var enginerun = getprop("/engines/engine/running");
var p1 = getprop("/controls/switches/pump1");
var p2 = getprop("/controls/switches/pump2");
var serv = getprop("/systems/electrical/serviceable");
var master = getprop("/controls/switches/master");

var switchloop = func() {
  if (serv and master) {
    # elec is op
    setprop("controls/electrical/master",1);
    setprop("controls/electrical/pump1",p1);
    setprop("controls/electrical/pump2",p2);
    setprop("controls/electrical/alt",enginerun);
  } else {
    # cut power
    setprop("controls/electrical/master",0);
    setprop("controls/electrical/pump1",0);
    setprop("controls/electrical/pump2",0);
    setprop("controls/electrical/alt",0);
  }
}



switchtimer = maketimer(0,switchloop);
switchtimer.start();
print("switches.nas: Ready");

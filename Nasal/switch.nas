# switch.nas | namespace switch
# KJ7NLL, Phoenix
setprop("/controls/switches/master",0);
setprop("/systems/electrical/serviceable",1);
setprop("/controls/switches/pump1",0);
setprop("/controls/switches/pump2",0);

var switchloop = func() {
  if (getprop("/controls/switches/master") == 1 and getprop("/systems/electrical/serviceable") == 1) {
    # elec is op
  print("START AE");
    setprop("/controls/electric/master",1);
    setprop("/controls/electric/pump1",getprop("/controls/switches/pump1"));
    setprop("/controls/electric/pump2",getprop("/controls/switches/pump2"));
    setprop("/controls/electric/alt",getprop("/engines/engine/running"));
  } else {
    # cut power
    # print("STOP AE");
    setprop("/controls/electric/master",0);
    setprop("/controls/electric/pump1",0);
    setprop("/controls/electric/pump2",0);
    setprop("/controls/electric/alt",0);
  }
}

var starter = func() {
  if (getprop("/controls/switches/master") == 1 and getprop("/systems/electrical/serviceable") == 1) {
    setprop("controls/engines/engine/starter",1);
    print("STARTENG AE");
  } else {
    setprop("controls/engines/engine/starter",0);
  }

}

# Set magnetos with lane switches. Maybe later will try to implement true lanes. :)
var laneset = func {
    var laneA = getprop("/controls/switches/laneA") or 0;
    var laneB = getprop("/controls/switches/laneB") or 0;

    setprop("controls/engines/engine/magnetos", laneA + (laneB * 2));
}

setlistener("/controls/switches/laneA", laneset);
setlistener("/controls/switches/laneB", laneset);

switchtimer = maketimer(0,switchloop);
switchtimer.start();
print("switches.nas: Ready");

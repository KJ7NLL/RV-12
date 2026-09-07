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


switchtimer = maketimer(0,switchloop);
switchtimer.start();
print("switches.nas: Ready");

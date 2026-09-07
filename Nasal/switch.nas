# switch.nas | namespace switch
# KJ7NLL, Phoenix


var switchloop = func() {
  var enginerun = getprop("/engines/engine/running") or 0;
  var p1 = getprop("/controls/switches/pump1") or 0;
  var p2 = getprop("/controls/switches/pump2") or 0;
  var serv = getprop("/systems/electrical/serviceable") or 0;
  var master = getprop("/controls/switches/master") or 0;

  if (serv and master) {
    # elec is op
    setprop("/controls/electric/master",1);
    setprop("/controls/electric/pump1",p1);
    setprop("/controls/electric/pump2",p2);
    setprop("/controls/electric/alt",enginerun);
  } else {
    # cut power
    setprop("/controls/electric/master",0);
    setprop("/controls/electric/pump1",0);
    setprop("/controls/electric/pump2",0);
    setprop("/controls/electric/alt",0);
  }
}

var starter = func() {
  if (master and serv) {
    setprop("controls/engines/engine/starter",1);
  } else {
    setprop("controls/engines/engine/starter",0);
  }
}


switchtimer = maketimer(0,switchloop);
switchtimer.start();
print("switches.nas: Ready");

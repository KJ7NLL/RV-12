# KV-12 inital startup
# KJ7NLL, Phoenix (phny)

# Set magnetos with lane switches. Maybe later will try to implement true lanes. :)
var laneset = func {
    var laneA = getprop("/controls/switches/laneA") or 0;
    var laneB = getprop("/controls/switches/laneB") or 0;

    setprop("controls/engines/engine[0]/magnetos", laneA + (laneB * 2));
}

setlistener("/controls/switches/laneA", laneset);
setlistener("/controls/switches/laneB", laneset);

# phny pilot head movement
setprop("kv12/head-hdg-deg",0); # Head moving gimmick
setprop("kv12/head-ptc-deg",0); # Head moving gimmick
var updatehead = func { # Head movement thingy
  if (getprop("sim/current-view/internal") == 1) { # only move head while in cockpit
    setprop("kv12/head-hdg-deg",getprop("sim/current-view/heading-offset-deg"));
    setprop("kv12/head-ptc-deg",getprop("sim/current-view/pitch-offset-deg"));
  }
}
# the maketimer
headupdate = maketimer(0.05,updatehead);

# Loop Control

# FDM 
setlistener("sim/signals/fdm-initialized", func {
   headupdate.start();
});

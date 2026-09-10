# RV-12 inital startup
# KJ7NLL, Phoenix (phny)

# phny pilot head movement
setprop("rv-12/head-hdg-deg",0); # Head moving gimmick
setprop("rv-12/head-ptc-deg",0); # Head moving gimmick
var updatehead = func { # Head movement thingy
  if (getprop("sim/current-view/internal") == 1) { # only move head while in cockpit
    setprop("rv-12/head-hdg-deg",getprop("sim/current-view/heading-offset-deg"));
    setprop("rv-12/head-ptc-deg",getprop("sim/current-view/pitch-offset-deg"));
  }
}
# the maketimera
headupdate = maketimer(0.05,updatehead);

var updatemixture = func {
  setprop("controls/engines/engine/mixture", getprop("controls/engines/engine/mixture-ecu-calc"))
}

# the maketimere
mixtureupdate = maketimer(0.05,updatemixture);

# Loop Control

# FDM 
setlistener("sim/signals/fdm-initialized", func {
   headupdate.start();
   mixtureupdate.start();
});

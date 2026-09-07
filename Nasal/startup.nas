# Set magnetos with lane switches. Maybe later will try to implement true lanes. :)
var laneset = func {
    var laneA = getprop("/controls/switches/laneA") or 0;
    var laneB = getprop("/controls/switches/laneB") or 0;

    setprop("controls/engines/engine[0]/magnetos", laneA + (laneB * 2));
}

setlistener("/controls/switches/laneA", laneset);
setlistener("/controls/switches/laneB", laneset);

# Make fuel pumps have a function.
var pumpset = func {
    if (getprop("/controls/switches/pump1") == false and getprop("/controls/switches/pump2") == false)
        setprop("/engines/engine[0]/running", false);
}

setlistener("/engines/engine[0]/running", pumpset)
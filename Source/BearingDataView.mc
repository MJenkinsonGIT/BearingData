//
// BearingData Data Field View
// Displays the user's current compass heading in degrees and direction
//

import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

//! Main data field view class
class BearingDataView extends WatchUi.DataField {

    // Declare member variables here to hold computed values
    private var _heading as Float or Null;

    //! Constructor
    public function initialize() {
        DataField.initialize();
        // Initialise member variables here
        _heading = null;
    }

    //! Called once when layout is first determined
    public function onLayout(dc as Dc) as Void {
        // Leave empty unless caching layout dimensions
    }

    //! Called periodically by the system to update calculations
    public function compute(info as Activity.Info) as Void {
        var raw = info.currentHeading;
        if (raw != null) {
            _heading = raw * (180.0 / Math.PI);
        } else {
            _heading = null;
        }
    }

    //! Called by the system to render the data field
    public function onUpdate(dc as Dc) as Void {
        // Get background color and set contrasting foreground
        var bgColor = getBackgroundColor();
        var fgColor = Graphics.COLOR_WHITE;
        if (bgColor == Graphics.COLOR_WHITE) {
            fgColor = Graphics.COLOR_BLACK;
        }

        // Clear the screen
        dc.setColor(fgColor, bgColor);
        dc.clear();

        // Get screen dimensions
        var width = dc.getWidth();
        var height = dc.getHeight();
        var xCenter = width / 2;

        // Draw the compass heading
        dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        var display = (_heading != null) ? (_heading as Float).format("%.0f") + "°" : "--";
        dc.drawText(xCenter, height / 2 - 25, Graphics.FONT_SMALL, display, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        // Draw the direction
        var direction = "";
        if (_heading != null) {
            if (_heading >= 337.6 || _heading < 22.5) {
  direction = "North";
}
            else if (_heading >= 22.6 && _heading < 67.5) {
  direction = "North-East";
}
            else if (_heading >= 67.6 && _heading < 112.5) {
  direction = "East";
}
            else if (_heading >= 112.6 && _heading < 157.5) {
  direction = "South-East";
}
            else if (_heading >= 157.6 && _heading < 202.5) {
  direction = "South";
}
            else if (_heading >= 202.6 && _heading < 247.5) {
  direction = "South-West";
}
            else if (_heading >= 247.6 && _heading < 292.5) {
  direction = "West";
}
            else {
  direction = "North-West";
}
        }
        dc.drawText(xCenter, height / 2 + 20, Graphics.FONT_XTINY, direction, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
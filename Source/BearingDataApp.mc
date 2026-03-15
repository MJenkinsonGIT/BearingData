//
// BearingData Data Field
// Displays the user's current compass heading in degrees
//

import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

//! Main application class
class BearingDataApp extends Application.AppBase {

    //! Constructor
    public function initialize() {
        AppBase.initialize();
    }

    //! Return the initial view
    function getInitialView() as [WatchUi.Views] or [WatchUi.Views, WatchUi.InputDelegates] {
        return [new BearingDataView()];
    }
}

//! Application entry point
function getApp() as Application.AppBase {
    return Application.getApp();
}
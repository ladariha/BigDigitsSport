using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TestView extends Ui.View {

	var refreshTimer;


    function initialize() {
        View.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
    	Sys.println("onLayout called");
    	setLayout(Rez.Layouts.MainLayout(dc));
    }
    
    function update() {
    	refreshTimer.stop();
    	refreshTimer.start(method(:update),60000,true);
    	Ui.requestUpdate();
    }
    

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
  function onShow() {
		refreshTimer = new Timer.Timer();
        refreshTimer.start(method(:update),60000,true);
		Ui.requestUpdate();
    }
    
   //! Update the view
    function onUpdate(dc) {
		Sys.println("onUpdate called");
    	var app = App.getApp();
		var time = app.timeNow();
    	var hour = (time / 3600) % 24;
		var min = (time / 60) % 60;
		//var sec = time % 60;

		var pmAm = "";

		if(System.getDeviceSettings().is24Hour) {
			if(0 == time) {
				hour = 24;
			}
			else {
				hour = hour % 24;
			}
		}
		else {
			if(12 > hour) {
				pmAm = "AM";
			}
			else {
				pmAm = "PM";
			}
			hour = 1 + (hour + 11) % 12;
		}

    	var timeStr = format("$1$:$2$", [hour.format("%01d"), min.format("%02d")]);
		app.printView(dc, "CAS / " + (System.getSystemStats().battery * 100).toNumber() / 100 + "%", timeStr, pmAm);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    	refreshTimer.stop();
    }

}

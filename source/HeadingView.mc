using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Act;

class HeadingView extends Ui.View {

	var refreshTimer;
	
    //! Load your resources here
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
    }
   
	function initialize() {
        View.initialize();
    }

	function update() {
    	refreshTimer.stop();
    	refreshTimer.start(method(:update),App.getApp().REFRESH_INTERVAL,true);
    	Ui.requestUpdate();
    }
    
    function pause(){
    	refreshTimer.stop();
    }
    
    function resume(){
   		refreshTimer.start(method(:update),App.getApp().REFRESH_INTERVAL,true);
    	Ui.requestUpdate();
    }
    
    function onShow(refreshInterval) {
		refreshTimer = new Timer.Timer();
        refreshTimer.start(method(:update),App.getApp().REFRESH_INTERVAL,true);
		Ui.requestUpdate();
    }
    
    function onHide() {
    	refreshTimer.stop();
    }

   //! Update the view
    function onUpdate(dc) {
    	var app = App.getApp();
    	var heading = Act.getActivityInfo().currentHeading;
    	if(heading == null){
    		heading = 0;	
    	}
    	heading = heading * 180 /  3.14159;
		app.printViewString(dc, "SMER / " + (System.getSystemStats().battery * 100).toNumber() / 100 + "%", getHeadingString(heading), "");
		
    }
    
    function getHeadingString(degrees){
    	if (degrees >= 337 && degrees < 22){// north
    		return "S";
    	}
    	if (degrees >= 22 && degrees < 67){// NE
    		return "SV";
    	}
    	if (degrees >= 67 && degrees < 112){// E
    		return "V";
    	}
    	if (degrees >= 112 && degrees < 157){// SE
    		return "JV";
    	}
    	if (degrees >= 157 && degrees < 202){// S
    		return "J";
    	}
    	if (degrees >= 202 && degrees < 247){// SW
    		return "JZ";
    	}
    	if (degrees >= 247 && degrees < 292){// W
    		return "Z";
    	}
    	return "SZ";
    
    }
}

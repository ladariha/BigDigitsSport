using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Act;

class CaloriesView extends Ui.View {

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
    	var cal = Act.getActivityInfo().calories;
    	if(cal == null){
    		cal = 0;	
    	}
		app.printView(dc, "Kalorie / " + (System.getSystemStats().battery * 100).toNumber() / 100 + "%", cal, "kcal");
		
    }
}

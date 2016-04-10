using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Act;

class ElapsedTimeView extends Ui.View {

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
    	var time = Act.getActivityInfo().elapsedTime;
    	if(time == null){
    		time = 0;	
    	}
    	time = time / 1000;
    	var hour = (time / 3600) % 24;
		var min = (time / 60) % 60;
		var sec = time % 60;
    	
		app.printView(dc, "CAS JIZDY / " + (System.getSystemStats().battery * 100).toNumber() / 100 + "%", hour + ":" + min + ":" + sec);
		
    }
}

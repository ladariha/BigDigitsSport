using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Position as Position;
using Toybox.Sensor as Sensor;

class TestApp extends App.AppBase {

	const MAIN_X = 102;
	const MAIN_Y = 74;
	const DESC_Y = 125;
	
	const REFRESH_INTERVAL = 2000;
	
	var currentView = 0;
	var currentViewInstance = null;
	var currentSession = null;
	enum {
		TIME_VIEW = 0,
		SPEED_VIEW = 1,
		AVERAGE_VIEW = 2,
		DISTANCE_VIEW = 3,
		ELAPSED_TIME_VIEW = 4,
		MAX_SPEED_VIEW = 5,
		CALORIES_VIEW = 6,
		HEADING_VIEW = 7,
		ASCENT_VIEW = 8,
		DESCENT_VIEW = 9,
		ALTITUDE_VIEW = 10
	}
	const VIEW_COUNTS = 11;

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart() {
    	//Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method(:onPosition) );
		Sensor.enableSensorEvents( null );
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
		currentSession = new SportSession();
    }
    
    
    function getSession(){
    	return currentSession;
    }
    
    function onPosition(info) 
    {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    // save data
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new TestView(), new MainDelegate(), new TestMenuDelegate()];
    }
    
     function timeNow() {
    	return (Time.now().value() + System.getClockTime().timeZoneOffset);
    }

    function timeToday() {
    	return (timeNow() - (timeNow() % 86400));
    }
    
    
    function getNextView(){
    	var nextView = (currentView + 1) % VIEW_COUNTS;
    	currentView = nextView;
    	return initializeView(currentView);
    }
    
    function getPreviousView(){
    	var nextView = (currentView - 1) % VIEW_COUNTS;
    	currentView = nextView;
    	return initializeView(currentView);
    }
    
    function setInitialView(){
    	return initializeView(TIME_VIEW);
    }
    
    function getCurrentView(){
    	return initializeView(currentView);
    }
    
    function initializeView(viewValue){
    	if(viewValue == TIME_VIEW){
    		currentViewInstance = new TestView();
    	} else if(viewValue == AVERAGE_VIEW){
    		currentViewInstance = new AverageSpeedView();
    	} else if(viewValue == DISTANCE_VIEW){
    		currentViewInstance = new DistanceView();
    	} else if(viewValue == ELAPSED_TIME_VIEW){
    		currentViewInstance = new ElapsedTimeView();
    	} else if(viewValue == MAX_SPEED_VIEW){
    		currentViewInstance = new MaxSpeedView();
    	} else if(viewValue == CALORIES_VIEW){
    		currentViewInstance = new CaloriesView();
    	} else if(viewValue == HEADING_VIEW){
    		currentViewInstance = new HeadingView();
    	} else if(viewValue == ASCENT_VIEW){
    		currentViewInstance = new AscentView();
    	} else if(viewValue == DESCENT_VIEW){
    		currentViewInstance = new DescentView();
    	} else if(viewValue == ALTITUDE_VIEW){
    		currentViewInstance = new AltitudeView();
    	} else {
    		currentViewInstance = new CurrentSpeedView();
    	}
    	return currentViewInstance;
    }
    
    function pauseViewRefresh(){
    	if(currentView != null){
    		currentView.pause();	
    	}
    }
    
    function toString(value){
    	if(value instanceof Toybox.Lang.String){
    		return value;
    	}
    	if(value instanceof Toybox.Lang.Float){
    		return value.format("%.2f");
    	}
    	if(value instanceof Toybox.Lang.Number){
    		return value + "";
    	}
    	
    	return value;
    	
    }
    
    
    function printView(dc, description, mainText, secondaryText){
		dc.clear();
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
		mainText = toString(mainText);
		dc.drawText(MAIN_X, MAIN_Y, Gfx.FONT_NUMBER_THAI_HOT, mainText, 5);
		if(secondaryText != null){
			var textW = dc.getTextWidthInPixels(mainText, Gfx.FONT_NUMBER_THAI_HOT);
			var col2 = MAIN_X + 1 + textW / 2;
			dc.drawText(col2, MAIN_Y, Gfx.FONT_MEDIUM, toString(secondaryText), 6);
		}
		
		dc.drawText(MAIN_X, DESC_Y, Gfx.FONT_LARGE, toString(description), 5);
		//draw0(dc, 0);
		//draw1(dc, 40);
		//draw0(dc, 80);
		//draw0(dc, 120);
		
		
    }
    
    function printViewString(dc, description, mainText, secondaryText){
		dc.clear();
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
		mainText = toString(mainText);
		dc.drawText(MAIN_X, MAIN_Y, Gfx.FONT_LARGE, mainText, 5);
		if(secondaryText != null){
			var textW = dc.getTextWidthInPixels(mainText, Gfx.FONT_LARGE);
			var col2 = MAIN_X + 1 + textW / 2;
			dc.drawText(col2, MAIN_Y, Gfx.FONT_MEDIUM, toString(secondaryText), 6);
		}
		
		dc.drawText(MAIN_X, DESC_Y, Gfx.FONT_LARGE, toString(description), 5);
		//draw0(dc, 0);
		//draw1(dc, 40);
		//draw0(dc, 80);
		//draw0(dc, 120);
		
		
    }
    
    
    function stopApp(){
    // Cloase ant channel
    // stop session
    // save session
    
    }
    
    function draw0(dc, xoffset){
     dc.fillRectangle(20 + xoffset, 10,10, 100);
     dc.fillRectangle(40 + xoffset, 10,10, 100);
     dc.fillRectangle(30 + xoffset, 10,10, 10);
     dc.fillRectangle(30 + xoffset, 100,10, 10);
    }
    
    function draw1(dc, xoffset){
     dc.fillRectangle(40 + xoffset, 10,10, 100);
    }
    

}

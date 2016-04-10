using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class MainDelegate extends Ui.InputDelegate {

    var app;
    var askingForSave = false;

    function onKey(event) {
    var key = event.getKey();
    Sys.println(key);
    	if(Ui.KEY_ESC == key) {
			onEscape();
      	} else if(Ui.KEY_MENU == key) {
			onMenu();
      	} else if(Ui.KEY_UP == key) {
			onPreviousPage();
		} else if(Ui.KEY_DOWN == key) {
		 	onNextPage();
		} else if(Ui.KEY_POWER == key) {
			onPower();
		} else if(Ui.KEY_ENTER == key){
			onEnter();
		}
		return true;
	}

	function onSwipe(event) {
        if(Ui.SWIPE_LEFT == event.getDirection()) {
            onNextPage();
        } else if(Ui.SWIPE_RIGHT == event.getDirection()) {
            onPreviousPage();
        }
        return true;
    }

    function onTap(event) {
       	onNextPage();
        return true;
    }

    function onNextPage() {
		Ui.switchToView(app.getNextView(), new MainDelegate(), Ui.SLIDE_LEFT);
    }

    function onPreviousPage() {
		Ui.switchToView(app.getPreviousView(), new MainDelegate(), Ui.SLIDE_RIGHT);
    }


    function onEnter() {
		app.getSession().toggle();
		return;
	}

	function onMenu() {
		Ui.pushView(new Rez.Menus.MainMenu(), new TestMenuDelegate(), Ui.SLIDE_UP);
		return true;
    }

	function onEscape() {
		if(!askingForSave){
		 	askingForSave = true;
		 	Ui.pushView(new Ui.Confirmation("Ulozit?"), new SaveSessionDelegate(), Ui.SLIDE_LEFT);
		} else if (askingForSave){
			// cancelled action
			Ui.switchToView(app.getCurrentView(), new MainDelegate(), Ui.SLIDE_RIGHT);
		} 
		
 		//app.stopApp();
		//Ui.popView(Ui.SLIDE_RIGHT);
	}

	function onPower() {
	app.stopApp();
	return true;
	}

	function initialize() {
		Ui.InputDelegate.initialize();
		app = App.getApp();
	}
}

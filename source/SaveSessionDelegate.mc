using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class SaveSessionDelegate extends Ui.ConfirmationDelegate {

	function initialize(){
		Ui.ConfirmationDelegate.initialize();
	}


    function onResponse(value) {

        if(value) {

            App.getApp().getSession().save();
        }
        else {

        	App.getApp().getSession().discard();
        }
    }
}
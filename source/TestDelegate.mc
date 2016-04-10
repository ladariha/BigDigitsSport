using Toybox.WatchUi as Ui;

class TestDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new TestMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

}
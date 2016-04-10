using Toybox.ActivityRecording as Activity;
using Toybox.System as Sys;

class SportSession{
	var session = null;

	function start(){
		if(session == null){
			session = Activity.createSession({ :sport => Activity.SPORT_GENERIC, :name => "Sport" });
		}
		session.start();
	}

	function pause(){
		session.stop();
	}
	
	function stop(){
		session.stop();
	}
	
	function save(){
		session.save();
	}
	
	function discard(){
		session.discard();
	}
	
	function isRunning(){
	return session != null && session.isRecording();
	}
	
	function toggle(){
		if(isRunning()){
			stop();
		} else {
			start();
		}
		Sys.println(session.isRecording());
	}
	
	

}
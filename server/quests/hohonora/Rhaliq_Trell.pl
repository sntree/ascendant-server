sub EVENT_SAY {
		if($text=~/Hail/i) {
			quest::say("Weakling! How dare you approach me.  Access to Lord Marrs temple is reserved only for the honorable!  You will never be [ready]...");
		}

		if($text=~/ready/i) {
			quest::say("Be warned, $name, if you believe you are ready, you will fail, even if you can kill Lord Marrs servants! Defend the innocents one chamber at a time; return and tell me you are [ready] once each chamber is secure.");
			quest::signalwith(211087, 3, 0); # tell #Rhaliq_Trell_Trigger to begin / advance a chamber
		}
}

sub EVENT_SIGNAL {
	# The controller tells us the trial has concluded -- step aside until the spawn timer resets us.
	quest::depop_withtimer();
}
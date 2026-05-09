
sub EVENT_SPAWN {
	#check for our event data bucket and see if we should even be up
	my $inst = $instanceid || 0;
	if(quest::get_data("ssra_cursed_$inst") ne "") {
		quest::depop_withtimer();
	}
}

sub EVENT_DEATH_COMPLETE {
	quest::signalwith(162279,1,0); #cursed_ten
}
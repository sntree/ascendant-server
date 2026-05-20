
sub _ssra_cursed_key {
	my $inst = $instanceid || 0;
	return "ssra_cursed_0" unless $inst > 0;

	my $dz = quest::get_expedition();
	if ($dz) {
		my $uuid = $dz->GetUUID();
		return "ssra_cursed_dz_$uuid" if $uuid ne "";
	}

	return "ssra_cursed_inst_$inst";
}

sub EVENT_SPAWN {
	#check for our event data bucket and see if we should even be up
	if(quest::get_data(_ssra_cursed_key()) ne "") {
		quest::depop_withtimer();
	}
}

sub EVENT_DEATH_COMPLETE {
	quest::signalwith(162279,1,0); #cursed_ten
}
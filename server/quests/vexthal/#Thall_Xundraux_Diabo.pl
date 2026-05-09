# Warder control for 2nd raid target(s) on 2nd floor of vexthal

sub EVENT_SPAWN {
	quest::spawn2(158091,0,0,880.0,0,126.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158091,0,0,941.0,0,126.1,380); # NPC: Akhevan_Warder
	quest::spawn2(158091,0,0,755.7,0,126.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158091,0,0,740.0,45.0,126.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158091,0,0,740.0,-45.0,126.1,126); # NPC: Akhevan_Warder
}

sub EVENT_DEATH_COMPLETE {
  quest::depopall(158091);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_thallxundraux_" . $account_id, $char_name);
	my $first_key = "first_kill_thallxundraux";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Thall Xundraux Diabo for the first time on this server!");
	}
}

#End of File, Zone:vexthal  NPC:158011 -- #Thall_Xundraux_Diabo

# Warder control for 1st raid target(s) on 2nd floor of vexthal

sub EVENT_SPAWN {
	quest::spawn2(158090,0,0,1736.1,-250.1,115.6,0); # NPC: Akhevan_Warder
	quest::spawn2(158090,0,0,1736.1,250.1,115.6,254); # NPC: Akhevan_Warder
}

sub EVENT_DEATH_COMPLETE {
  quest::depopall(158090);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_thallvakelun_" . $account_id, $char_name);
	my $first_key = "first_kill_thallvakelun";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Thall Va Kelun for the first time on this server!");
	}
}

#End of File, Zone:vexthal  NPC:158008 -- #Thall_Va_Kelun

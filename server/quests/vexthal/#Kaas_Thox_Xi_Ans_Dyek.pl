# Warder control for first raid target on 1st floor of vexthal

sub EVENT_SPAWN {
	quest::spawn2(158087,0,0,626.0,256.0,6.25,380); # NPC: Akhevan_Warder
	quest::spawn2(158087,0,0,626.0,-256.0,6.25,380); # NPC: Akhevan_Warder
}

sub EVENT_DEATH_COMPLETE {
	quest::depopall(158087);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_kaasthoxansdyek_" . $account_id, $char_name);
	my $first_key = "first_kill_kaasthoxansdyek";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Kaas Thox Xi Ans Dyek for the first time on this server!");
	}
}

#End of File, Zone:vexthal  NPC:158013 -- #Kaas_Thox_Xi_Ans_Dyek

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_rumblecrush_" . $account_id, $char_name);
	my $first_key = "first_kill_rumblecrush";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Rumblecrush for the first time on this server!");
	}
}

# EOF zone: umbral ID: 176002 NPC: Rumblecrush

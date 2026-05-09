sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_vadyn_" . $account_id, $char_name);
	my $first_key = "first_kill_vadyn";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain The Va`Dyn for the first time on this server!");
	}
}

# EOF zone: akheva ID: 179178 NPC: The_Va`Dyn

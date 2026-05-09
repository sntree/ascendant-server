sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_kaasthoxatenhra_" . $account_id, $char_name);
	my $first_key = "first_kill_kaasthoxatenhra";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Kaas Thox Xi Aten Ha Ra for the first time on this server!");
	}
}

# EOF zone: vexthal ID: 158007 NPC: Kaas_Thox_Xi_Aten_Ha_Ra

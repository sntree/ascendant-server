sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_servitorofluclin_" . $account_id, $char_name);
	my $first_key = "first_kill_servitorofluclin";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Servitor of Luclin for the first time on this server!");
	}
}

# EOF zone: griegsend ID: 163013 NPC: Servitor_of_Luclin

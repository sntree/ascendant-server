sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_thoughthorror_" . $account_id, $char_name);
	my $first_key = "first_kill_thoughthorror";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Thought Horror Overfiend for the first time on this server!");
	}
}

# EOF zone: thedeep ID: 164078 NPC: Thought_Horror_Overfiend

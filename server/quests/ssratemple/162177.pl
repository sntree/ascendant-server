sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_archlichrhag_" . $account_id, $char_name);
	my $first_key = "first_kill_archlichrhag";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Arch Lich Rhag`Zadune for the first time on this server!");
	}
}

# EOF zone: ssratemple ID: 162177 NPC: Arch_Lich_Rhag`Zadune

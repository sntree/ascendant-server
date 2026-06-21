# NPCID: 200007 #_Carprin_Deatharn (Crypt of Decay) - PoP raid kill flag + server first
sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_carprin_" . $account_id, $char_name);

	my $first_key = "first_kill_carprin";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Carprin Deatharn for the first time on this server!");
	}
}

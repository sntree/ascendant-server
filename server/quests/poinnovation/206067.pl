# NPCID: 206067 #Xanamech_Nezmirthafen (Plane of Innovation) - PoP raid kill flag + server first
sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_xanamech_" . $account_id, $char_name);

	my $first_key = "first_kill_xanamech";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Xanamech Nezmirthafen for the first time on this server!");
	}
}

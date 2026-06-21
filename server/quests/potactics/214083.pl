# NPCID: 214083 Vallon_Zek (Drunder, Plane of Tactics) - PoP raid kill flag + server first
sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_vallonzek_" . $account_id, $char_name);

	my $first_key = "first_kill_vallonzek";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Vallon Zek for the first time on this server!");
	}
}

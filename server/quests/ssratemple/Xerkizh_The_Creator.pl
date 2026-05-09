#Just a little flavor for when XTC kills someone.

sub EVENT_SLAY {
  quest::say("Odd, we normally have to drag sacrifices kicking and screaming, but this one all but throws himself at us.");
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_xerkizh_" . $account_id, $char_name);
	my $first_key = "first_kill_xerkizh";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Xerkizh The Creator for the first time on this server!");
	}
}

#Submitted by: Jim Mills
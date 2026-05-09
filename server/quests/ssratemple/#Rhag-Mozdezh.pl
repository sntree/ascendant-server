# second part of the arch lich rhag`zadune cycle
#

sub EVENT_DEATH_COMPLETE {
  quest::unique_spawn(162177,0,0,420,-144,270.1,0); # spawn rhag`mozdezh
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_rhagmozdezh_" . $account_id, $char_name);
	my $first_key = "first_kill_rhagmozdezh";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Rhag`Mozdezh for the first time on this server!");
	}
}

# EOF zone: ssratemple ID: 162178 NPC: #Rhag`Mozdezh


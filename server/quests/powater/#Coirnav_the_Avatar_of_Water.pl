#216094 - Real #Corirnav_the_Avatar_of_Water

sub EVENT_SIGNAL {
  if($signal == 7){ #Event kickout emote
    quest::shout("Violaters of this plane be banished from this domain!");
  }
}

sub EVENT_DEATH_COMPLETE {
  quest::signalwith(216107,5,0); # NPC: #coirnav_controller
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_coirnav_" . $account_id, $char_name);

	my $first_key = "first_kill_coirnav";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Coirnav, the Avatar of Water, for the first time on this server!");
	}
}
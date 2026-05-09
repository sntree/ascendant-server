# signal burrower beast whether success or failure
#

sub EVENT_SPAWN {
  quest::settimer("countdown",1800);
}

sub EVENT_TIMER {
  if ($timer eq "countdown") {
    quest::signalwith(164098,101,0); # NPC: The_Burrower_Beast
    quest::depop();
  }
}

sub EVENT_DEATH_COMPLETE {
  quest::signalwith(164098,201,0); # NPC: The_Burrower_Beast
  quest::stoptimer("countdown");
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_burrowerparasite_" . $account_id, $char_name);
	my $first_key = "first_kill_burrowerparasite";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain A Burrower Parasite for the first time on this server!");
	}
}

# EOF zone: thedeep ID: 164089 NPC: A_burrower_parasite


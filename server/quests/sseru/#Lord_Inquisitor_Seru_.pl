sub EVENT_SPAWN {
  quest::settimer(1,1);
}

sub EVENT_TIMER {
 my $x = $npc->GetX();
 my $y = $npc->GetY();
 if($timer == 1 && ($x < -353 || $x > -109 || $y < -549 || $y > -310)) {
    quest::shout("No! I must not leave the time chamber! If I do, I'll age and die!");
    $npc->GMMove(-231.464005,-432.937469,202.375946,0.25);
 }
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_seru_" . $account_id, $char_name);
	my $first_key = "first_kill_seru";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Lord Inquisitor Seru for the first time on this server!");
	}
}

sub EVENT_DEATH_COMPLETE {
  quest::stoptimer(1);
}

sub EVENT_COMBAT {
    if ($combat_state == 1) {
    quest::settimer(1,6);
    } elsif ($combat_state == 0) {
    quest::stoptimer(1);
    }
}

sub EVENT_TIMER {
    if($timer == 1) {
        if($z < -975) {
            $npc->GMMove(-175,354,-759.13,503);
        }
    }
}

sub EVENT_DEATH_COMPLETE {
    quest::signal(207014,0); # NPC: Tylis_Newleaf
    quest::spawn2(207066,0,0,$x,$y,$z,$h); # NPC: #Tylis_Newleaf
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_keeperofsorrows_" . $account_id, $char_name);

	my $first_key = "first_kill_keeperofsorrows";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain The Keeper of Sorrows for the first time on this server!");
	}
}

sub EVENT_SPAWN {
  #no aggro timer, respawn untargetable.
  #added this because of the reports of MB going active and despawning on his own.
  quest::settimer(9,1200);
  #leash timer
  quest::settimer(4,1);
}

sub EVENT_DEATH_COMPLETE    {
  #signal to Giwin to give flags.
  quest::signalwith(206038,1,1); # NPC: Giwin_Mirakon
}

sub EVENT_TIMER {
  if($timer == 9) {
    #if targetable version has been up 20 minutes depop him.
    #resest spawn timer on untargetable to respawn it in 5 seconds
    quest::updatespawntimer(42135,5000);
    quest::depop();
  }
  if($timer == 8) {
    #failed. shorten respawn timer to 24 hours. 
    quest::updatespawntimer(42135,86400000);
    quest::depop();
  }
  if($timer == 4 && ($x < 1010 || $x > 1240)) {
    #leash
    $npc->GMMove(1125,0,12.5,0);
    #signal to giwin about being out of room
    quest::signalwith(206038,2,1); # NPC: Giwin_Mirakon
  }
}

sub EVENT_AGGRO {
  #fail timer
  quest::settimer(8,1200);
  quest::stoptimer(9);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_manaeticbehemoth_" . $account_id, $char_name);

	my $first_key = "first_kill_manaeticbehemoth";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain the Manaetic Behemoth for the first time on this server!");
	}
}
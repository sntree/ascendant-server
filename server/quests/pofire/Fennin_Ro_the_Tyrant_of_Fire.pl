sub EVENT_SPAWN {
  quest::settimer("despawn",3600);
}

sub EVENT_COMBAT {
  if ($combat_state == 1) {
    quest::stoptimer("despawn");
    quest::settimer("despawn",3600);
  }
}

sub EVENT_TIMER {
  # Global encounter scaling starts its own enc_rescan timer on engage.
  # Only Fennin's explicit despawn timer should remove him.
  return unless ($timer eq "despawn");

  quest::stoptimer("despawn");
  quest::depop();
}

sub EVENT_DEATH_COMPLETE {
  quest::stoptimer("despawn");
  quest::ze(1,"Loud cries of hopelessness echo throughout the burning lands. The creatures of Doomfire call out to their master, Fennin Ro the Tyrant of Fire, for his dead body now lies at the feet of the mighty adventurers.");
  quest::spawn2(217058,0,0,$x,$y,$z,$h); #Essence_of_Fire
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_fenninro_" . $account_id, $char_name);

	my $first_key = "first_kill_fenninro";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Fennin Ro, the Tyrant of Fire, for the first time on this server!");
	}
}
# End of File  Zone: PoFire  ID: 217054  -- Fennin_Ro_the_Tyrant_of_Fire

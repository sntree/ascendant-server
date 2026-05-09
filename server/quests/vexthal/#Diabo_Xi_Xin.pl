# Warder control for 2nd raid target(s) on 1st floor of vexthal

sub EVENT_SPAWN {
	quest::spawn2(158088,0,0,1874.4,2.1,3.1,380); # NPC: Akhevan_Warder
	quest::spawn2(158088,0,0,1767.3,2.3,67.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158088,0,0,1837.0,1.9,63.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158088,0,0,1736.6,-64.3,63.1,126); # NPC: Akhevan_Warder
	quest::spawn2(158088,0,0,1736.6,64.3,63.1,126); # NPC: Akhevan_Warder
}

sub EVENT_DEATH_COMPLETE {
  quest::depopall(158088);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_diaboxixin_" . $account_id, $char_name);
	my $first_key = "first_kill_diaboxixin";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Diabo Xi Xin for the first time on this server!");
	}
}

#End of File, Zone:vexthal  NPC:158015 -- #Diabo_Xi_Xin

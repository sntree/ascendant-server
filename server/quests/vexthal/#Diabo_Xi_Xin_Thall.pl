# Warder control for 3rd raid target(s) on 1st floor of vexthal

sub EVENT_SPAWN {
	quest::spawn2(158089,0,0,1596.9,23.6,63.1,254); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1596.9,-23.6,63.1,0); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1557.9,23.6,63.1,254); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1557.9,-23.6,63.1,0); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1489.6,-17.4,115.6,508); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1489.3,17.4,115.6,256); # NPC: Akhevan_Warder
	quest::spawn2(158089,0,0,1508.4,2.0,115.6,384); # NPC: Akhevan_Warder
}

sub EVENT_DEATH_COMPLETE {
  quest::depopall(158089);
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_diaboxixinthall_" . $account_id, $char_name);
	my $first_key = "first_kill_diaboxixinthall";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Diabo Xi Xin Thall for the first time on this server!");
	}
}

#End of File, Zone:vexthal  NPC:158012 -- #Diabo_Xi_Xin_Thall

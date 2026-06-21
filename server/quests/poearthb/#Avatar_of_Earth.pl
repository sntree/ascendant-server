sub EVENT_SPAWN { 
   quest::settimer("avatar",3400);
   quest::ze(0,"The last of the council collapses, devoid of life. Twelve distinct voices chant, 'Time comes and time passes, for the stone is forever. We call upon our collective power to defend our stronghold!' When the chanting ceases, a deep throated primal scream echoes across Ragrax as the power of twelve is joined as one. The Avatar of Earth has been summoned.");
} 

sub EVENT_TIMER { 
   if($timer eq "avatar") { 
      quest::depop(); 
   } 
} 

sub EVENT_DEATH_COMPLETE { 
   my $x = $npc->GetX(); 
   my $y = $npc->GetY(); 
   my $z = $npc->GetZ(); 
   my $h = $npc->GetHeading(); 
   quest::spawn2(222015,0,0,$x,$y,$z,$h); # NPC: #Essence_of_Earth
   quest::signal(222012); 
   # Instance-scoped lockout key so concurrent poearthb instances don't share the Rathe Council lockout.
   my $rathe_key = $instanceid ? "${instanceid}_poeb_rathe" : "poeb_rathe";
   quest::setglobal($rathe_key,1,3,"D5");
} 

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();

	quest::set_data("pop_avatarofearth_" . $account_id, $char_name);

	my $first_key = "first_kill_avatarofearth";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain the Avatar of Earth for the first time on this server!");
	}
}

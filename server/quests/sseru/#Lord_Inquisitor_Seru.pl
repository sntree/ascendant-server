sub EVENT_AGGRO {

quest::stoptimer(1);
quest::settimer(1,3000);


}

sub EVENT_DEATH_COMPLETE {

quest::stoptimer(1);

}

sub EVENT_TIMER {

if($timer == 1 && $mob->IsEngaged()) {
quest::stoptimer(1);
quest::settimer(2,600);

}

else
{
quest::spawn2(159691,0,0,$x,$y,$z,$h); # NPC: #Lord_Inquisitor_Seru_
quest::depop();
quest::stoptimer(1);
}

if($timer == 2 && $mob->IsEngaged()) {



quest::stoptimer(1);
quest::settimer(2,600);
}

else
{
quest::spawn2(159691,0,0,$x,$y,$z,$h); # NPC: #Lord_Inquisitor_Seru_
quest::depop();
quest::stoptimer(1);
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

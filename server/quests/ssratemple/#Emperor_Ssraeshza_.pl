#BEGIN File: ssratemple\#Emperor_Ssraeshza_.pl (Real)

my $engaged;
my $inst;
my $EmpRepopTime = int(rand(2880)) + 4320;
my $BloodCoolDownTime = int(rand(60)) + 180;

sub EVENT_SPAWN {
  $engaged = 0;
  $inst = $instanceid || 0;
  quest::settimer("EmpDepop", 1800);
}

sub EVENT_TIMER {
  if ($timer eq "EmpDepop") {
    quest::stoptimer("EmpDepop");
    #Raid failure - set blood cooldown directly + signal EmpCycle
    if ($inst > 0) {
      quest::set_data("ssra_bloodcd_$inst", "1", "M$BloodCoolDownTime");
    } else {
      quest::set_data("ssra_bloodcd_0", "1", "M$BloodCoolDownTime");
    }
    quest::signalwith(162260,3,0); #EmpCycle
    quest::depop();
  }
}

sub EVENT_COMBAT {
  if (($combat_state == 1) && ($engaged == 0)) {
    quest::settimer("EmpDepop", 2400);
    $engaged = 1;
  }
}
  
sub EVENT_DEATH_COMPLETE {
  quest::emote("'s corpse says 'How...did...ugh...'");
  quest::spawn2(162210,0,0,877, -326, 408,385); # NPC: A_shissar_wraith
  quest::spawn2(162210,0,0,953, -293, 404,385); # NPC: A_shissar_wraith
  quest::spawn2(162210,0,0,953, -356, 404,385); # NPC: A_shissar_wraith
  quest::spawn2(162210,0,0,773, -360, 403,128); # NPC: A_shissar_wraith
  quest::spawn2(162210,0,0,770, -289, 403,128); # NPC: A_shissar_wraith
  #Set emp state directly (belt-and-suspenders, don't rely solely on signal)
  if ($inst > 0) {
    quest::set_data("ssra_emp_$inst", "3"); #Permanent - no respawn in instances
  } else {
    quest::set_data("ssra_emp_0", "3", "M$EmpRepopTime");
  }
  quest::signalwith(162260,2,0); #EmpCycle - also signal to stop timer
}

sub EVENT_SLAY {
  quest::say("Your god has found you lacking.");
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_emperorssra_" . $account_id, $char_name);
	my $first_key = "first_kill_emperorssra";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Emperor Ssraeshza for the first time on this server!");
	}
}

# EOF zone: ssratemple ID: 162227 NPC: #Emperor_Ssraeshza_ (Real)

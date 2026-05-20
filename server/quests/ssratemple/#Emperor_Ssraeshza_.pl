#BEGIN File: ssratemple\#Emperor_Ssraeshza_.pl (Real)

my $engaged;
my $inst;
my $EmpRepopTime = int(rand(2880)) + 4320;
my $BloodCoolDownTime = int(rand(60)) + 180;
my $DiminutiveStatureSpellID = 2981;
my $DiminutiveStatureProcChance = 10;
my $DiminutiveStatureCooldownMS = 24000;

sub _ssra_state_id {
  return "0" unless $inst > 0;

  my $dz = quest::get_expedition();
  if ($dz) {
    my $uuid = $dz->GetUUID();
    return "dz_$uuid" if $uuid ne "";
  }

  return "inst_$inst";
}

sub _emp_key   { return "ssra_emp_" . _ssra_state_id(); }
sub _blood_key { return "ssra_bloodcd_" . _ssra_state_id(); }

sub EVENT_SPAWN {
  $engaged = 0;
  $inst = $instanceid || 0;
  $npc->RemoveMeleeProc($DiminutiveStatureSpellID);
  $npc->AddMeleeProc($DiminutiveStatureSpellID, $DiminutiveStatureProcChance, $DiminutiveStatureCooldownMS);
  quest::settimer("EmpDepop", 1800);
}

sub EVENT_TIMER {
  if ($timer eq "EmpDepop") {
    quest::stoptimer("EmpDepop");

    if ($npc->IsEngaged()) {
      quest::settimer("EmpDepop", 2400);
      return;
    }

    #Raid failure - set blood cooldown directly + signal EmpCycle
    if ($inst > 0) {
      quest::set_data(_blood_key(), "1", "M$BloodCoolDownTime");
    } else {
      quest::set_data(_blood_key(), "1", "M$BloodCoolDownTime");
    }
    quest::signalwith(162260,3,0); #EmpCycle
    quest::depop();
  }
}

sub EVENT_COMBAT {
  if ($combat_state == 1) {
    quest::stoptimer("EmpDepop");
    quest::settimer("EmpDepop", 2400);
    $npc->RemoveMeleeProc($DiminutiveStatureSpellID);
    $npc->AddMeleeProc($DiminutiveStatureSpellID, $DiminutiveStatureProcChance, $DiminutiveStatureCooldownMS);
    $engaged = 1;
  }
  else {
    $engaged = 0;
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
    quest::set_data(_emp_key(), "3", "D1"); #24 hours - expires with DZ
  } else {
    quest::set_data(_emp_key(), "3", "M$EmpRepopTime");
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

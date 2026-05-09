#BEGIN File: ssratemple\#EmpCycle.pl

my $BloodCoolDownTime = int(rand(60)) + 180; #Waiting time to reattempt Emp after failure (Current setting: 3-4 hours)
my $EmpRepopTime = int(rand(2880)) + 4320; #Respawn time for Emp after success (Current setting: 3-5 days)
my $EmpPrepTime = 150; #Seconds before Emp becomes targetable after killing Blood/Golem (Current setting: 2min 30sec)
my $EmpPrep;
my $inst;

sub _emp_key   { return "ssra_emp_$inst"; }
sub _blood_key { return "ssra_bloodcd_$inst"; }

sub EVENT_SPAWN {
  $EmpPrep = 0;
  $inst = $instanceid || 0;
  quest::settimer("EmpCycle",10); #Cyclical Timer
}

sub EVENT_TIMER {
  if ($timer eq "EmpCycle") {
    my $emp_state  = quest::get_data(_emp_key());
    my $blood_cd   = quest::get_data(_blood_key());
    if ($emp_state eq "" && $blood_cd eq "") { #Emperor is ready to spawn
      quest::set_data(_emp_key(), "1"); #Normal Cycle Start
      $emp_state = "1";
    }
    if (($emp_state eq "1") && !$entity_list->GetNPCByNPCTypeID(162065)) {
      quest::unique_spawn(162189,0,0,877.0,-325.0,400.5,384); ##Blood_of_Ssraeshza
      quest::unique_spawn(162065,0,0,990.0,-325.0,415.0,384); ##Emperor_Ssraeshza (No Target)
    }
    if ($blood_cd eq "" && ($emp_state eq "2") && !$entity_list->GetNPCByNPCTypeID(162065) && !$entity_list->GetNPCByNPCTypeID(162227) && ($EmpPrep == 0)) {
      quest::unique_spawn(162064,0,0,877.0,-325.0,400.5,384); #Ssraeshzian_Blood_Golem
      quest::unique_spawn(162065,0,0,990.0,-325.0,415.0,384); ##Emperor_Ssraeshza (No Target)
    }
  }
  if ($timer eq "EmpPrep") {
    quest::stoptimer("EmpPrep");
    quest::depop(162065); ##Emperor_Ssraeshza (No Target)
    quest::unique_spawn(162227,0,0,990.0,-325.0,415.0,384); ##Emperor_Ssraeshza_ (Real)
    quest::set_data(_emp_key(), "2");
    quest::set_data(_blood_key(), "1", "M$BloodCoolDownTime"); #Cooldown timer
    $EmpPrep = 0;
  }
}

sub EVENT_SIGNAL {
  if ($signal == 1) { #Blood or Blood Golem is dead
    quest::settimer("EmpPrep", $EmpPrepTime);
    $EmpPrep = 1;
  }
  if ($signal == 2) { #Emperor is dead
    if ($inst > 0) {
      quest::set_data(_emp_key(), "3"); #Permanent - no respawn in instances
      quest::stoptimer("EmpCycle");
    } else {
      quest::set_data(_emp_key(), "3", "M$EmpRepopTime"); #Emp respawn timer
    }
  }
  if ($signal == 3) { #Raid Failure
    quest::set_data(_blood_key(), "1", "M$BloodCoolDownTime"); #Cooldown timer
  }
}

#END File: ssratemple\#EmpCycle.pl (162260)

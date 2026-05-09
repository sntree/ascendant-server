my $inst;

sub EVENT_SPAWN {
  $inst = $instanceid || 0;
  quest::settimer("atenha",1);
}

sub EVENT_TIMER {
  if ($timer eq "atenha") {
    if (quest::get_data("vt_aten_$inst") ne "") {
      quest::stoptimer("atenha");
      quest::depop_withtimer();
    }
  }
}

sub EVENT_KILLED_MERIT {
	my $account_id = $client->AccountID();
	my $char_name = $client->GetCleanName();
	quest::set_data("luclin_atenhra_" . $account_id, $char_name);
	my $first_key = "first_kill_atenhra";
	unless (quest::get_data($first_key) || $client->GetGM()) {
		quest::set_data($first_key, $char_name . "|" . $uguild);
		quest::we(15, "SERVER FIRST! " . $char_name . " <" . $uguild . "> and their group have slain Aten Ha Ra for the first time on this server!");
	}
}

sub EVENT_DEATH_COMPLETE {
  if ($inst > 0) {
    quest::set_data("vt_aten_$inst", "1"); #Permanent - no respawn in instances
  } else {
    my $variance = int(rand(720));
    my $spawntime = 6480 + $variance;
    quest::set_data("vt_aten_$inst", "1", "M$spawntime");
  }
}

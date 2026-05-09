my $check;
my $variance = int(rand(600));
my $spawntime = 4320 + $variance;
my $inst;

sub _cursed_key  { return "ssra_cursed_$inst"; }
sub _glyphed_key { return "ssra_glyphed_$inst"; }
sub _exiled_key  { return "ssra_exiled_$inst"; }

sub EVENT_SPAWN {
  $inst = $instanceid || 0;
  quest::settimer("cursed",60);
}

sub EVENT_TIMER {
  $check = 0;
  if($timer eq "cursed") {
    $check_boss = $entity_list->GetMobByNpcTypeID(162270);#cursed_one
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162271);#cursed_two
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162272);#cursed_three
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162273);#cursed_four
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162274);#cursed_five
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162275);#cursed_six
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162276);#cursed_seven
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162277);#cursed_eight
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162278);#cursed_nine
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162279);#cursed_ten
    if ($check_boss) {
      $check = 1;
    }
    if ($check == 1) {
    }
    if ($check == 0 && quest::get_data(_cursed_key()) ne "") {
    }
    elsif ($check == 0) {
      if (quest::get_data(_glyphed_key()) ne "") {
        quest::spawn2(162253,0,0,-51,-9,-218.1,126);#runed
      }
      elsif (quest::get_data(_glyphed_key()) eq "") {
        quest::spawn2(162261,0,0,-51,-9,-218.1,126);#glyphed
      }
      quest::stoptimer("cursed");
      quest::stoptimer("one");
      quest::settimer("one",21600);
    }
  }
  if ($timer eq "one" && quest::get_data(_cursed_key()) eq "") {
    quest::stoptimer("one");
    quest::depop(162206);
    quest::depop(162232);
    quest::depop(162214);
    quest::depop(162261);
    quest::depop(162253);
    quest::depop_withtimer();
  }
}

sub EVENT_SIGNAL {
  if ($signal == 1 && quest::get_data(_exiled_key()) ne "") {
    quest::spawn2(162214,0,0,-51,-9,-218.1,126);#Banished
  }
  elsif ($signal == 1 && quest::get_data(_exiled_key()) eq "") {
    quest::spawn2(162232,0,0,-51,-9,-218.1,126);#Exiled
  }
  if ($signal == 2 && quest::get_data(_cursed_key()) eq "") {
    quest::spawn2(162206,0,0,-51,-9,-218.1,126);#Cursed
  }
  if ($signal == 3) {
    if ($inst > 0) {
      quest::set_data(_cursed_key(), "1"); #Permanent - no respawn in instances
      quest::stoptimer("cursed");
      quest::stoptimer("one");
      quest::depop_withtimer();
    } else {
      quest::set_data(_cursed_key(), "1", "M$spawntime");
      quest::stoptimer("one");
      quest::depop_withtimer();
    }
  }
}

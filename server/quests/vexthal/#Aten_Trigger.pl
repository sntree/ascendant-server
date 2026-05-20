#Spawns non-Destroy Aten if no boss mobs are up and global is not set.
#Spawns Destroy Aten if boss mobs are up and global is not set.

my $inst;

sub _aten_key {
  return "vt_aten_0" unless $inst > 0;

  my $dz = quest::get_expedition();
  if ($dz) {
    my $uuid = $dz->GetUUID();
    return "vt_aten_dz_$uuid" if $uuid ne "";
  }

  return "vt_aten_inst_$inst";
}

sub EVENT_SPAWN {
  $inst = $instanceid || 0;
  quest::settimer("aten",60);
}

sub EVENT_TIMER {
  if($timer eq "aten") {
    if (quest::get_data(_aten_key()) eq "") {
      if (!$entity_list->IsMobSpawnedByNpcTypeID(158014) && !$entity_list->IsMobSpawnedByNpcTypeID(158010) && !$entity_list->IsMobSpawnedByNpcTypeID(158015) && !$entity_list->IsMobSpawnedByNpcTypeID(158012) && !$entity_list->IsMobSpawnedByNpcTypeID(158013) && !$entity_list->IsMobSpawnedByNpcTypeID(158007) && !$entity_list->IsMobSpawnedByNpcTypeID(158008) && !$entity_list->IsMobSpawnedByNpcTypeID(158011) && !$entity_list->IsMobSpawnedByNpcTypeID(158009)) {
       quest::depopall(158006);
       quest::spawn2(158096,0,0,1412,0,248.63,384); # NPC: #Aten_Ha_Ra_
       quest::depop_withtimer();
      } elsif (!$entity_list->IsMobSpawnedByNpcTypeID(158006)) {
       quest::spawn2(158006,0,0,1412,0,248.63,384); # NPC: #Aten_Ha_Ra
      }
    }
  }
}

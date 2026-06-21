$level_for_tier_three = 62;

sub EVENT_CLICKDOOR {
  # Level-only access shortcut only allowed once Gates of Discord is active; otherwise flags required.
  my $god_active = quest::is_gates_of_discord_enabled();
  my $aerin_dar_up = $entity_list->IsMobSpawnedByNpcTypeID(208074);

  # Raid DZs need to use the instance's Aerin`Dar state, not the static door/key
  # behavior that can leave the lair path inert while the DZ boss is up.
  if($instanceid > 0 && $doorid == 2) {
    if($aerin_dar_up) {
      my $door = $entity_list->FindDoor(2);
      if($door) {
        $door->SetLockPick(0);
        $door->SetKeyItem(0);
        quest::settimer("aerin_dar_glass_relock", 300);
      }
    }
    else {
      $client->Message(13, "The crystalline seal is dormant.");
    }
  }

  # doorid 6 (POVDRTELE500, the Aerin`Dar orb) is a same-zone teleport door.
  # With dest_zone='povalor' the engine teleports the clicker via MovePC using the
  # current instance id, so it works in the open zone and preserves the raid DZ.
  # No script handling needed; let the engine HandleClick run.

  #hohonora from behind AD
  if($doorid == 3) {
    if(($god_active && $client->GetLevel() >= $level_for_tier_three) || (defined $qglobals{pop_poj_mavuin} && defined $qglobals{pop_poj_tribunal} && defined $qglobals{pop_poj_valor_storms} && defined $qglobals{pop_pov_aerin_dar}) || (defined $qglobals{pop_alt_access_hohonora})) {
      if(quest::has_zone_flag(211) != 1) {
        quest::set_zone_flag(211);
      }
    }
  }
}

sub EVENT_TIMER {
  if($timer eq "aerin_dar_glass_relock") {
    quest::stoptimer("aerin_dar_glass_relock");

    my $door = $entity_list->FindDoor(2);
    if($door) {
      $door->SetLockPick(-1);
      $door->SetKeyItem(25596);
    }
  }
}

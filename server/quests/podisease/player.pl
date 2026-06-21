sub EVENT_ZONE {
  if($target_zone_id == 200) {
    $level_for_tier_two = 55;
    # Level-only access shortcut only allowed once Gates of Discord is active; otherwise flags required.
    my $god_active = quest::is_gates_of_discord_enabled();
    if(($god_active && $client->GetLevel() >= $level_for_tier_two) || (defined $qglobals{pop_pod_alder_fuirstel} && defined $qglobals{pop_pod_grimmus_planar_projection}) || (defined $qglobals{pop_alt_access_codecay})) {
      if(quest::has_zone_flag(200) != 1) {
        quest::set_zone_flag(200);
      }
    }
  }
}
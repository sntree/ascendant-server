sub EVENT_DEATH_COMPLETE {
    my $respawn_cap = 45;
    my $bucket_prefix = "poair_dust_arachnid_" . ($instanceid || 0) . "_";
    my $respawn_count_key = $bucket_prefix . "respawns";

    return unless quest::get_data($bucket_prefix . "event_active");

    my $respawn_count = int(quest::get_data($respawn_count_key) || 0);
    return if ($respawn_count >= $respawn_cap);

    quest::set_data($respawn_count_key, $respawn_count + 1, 7200);
    quest::spawn2(215460,0,0,$x,$y,$z,$h); # NPC: an_erratic_arachnid
}

##############################################################################
# Common Mob Bonus Loot Plugin (Expansion-Aware)
##############################################################################
# Purpose: Low chance for ANY mob to roll bonus loot from a rare_spawn
#          NPC loottable in the same expansion and level block.
#
# Called from global_npc.pl:
#   plugin::common_mob_bonus_loot($npc, $npc_level, $zoneid);
##############################################################################

sub common_mob_bonus_loot {
    my $npc = shift;
    my $level = shift;
    my $zoneid = shift;

    return unless $npc;
    return unless $level;
    return unless $zoneid;

    # Configuration: 0.33% chance for bonus loot, then 10% chance for a 2nd roll
    my $bonus_chance = 0.0033;
    my $second_roll_chance = 0.10;
    my $required_item_attempts = 25;
    my $common_item_threshold = 5; # reroll if every bonus item appears on >5 rare_spawn NPCs

    # Roll for bonus loot chance
    return unless rand() < $bonus_chance;

    if (!plugin::uses_rare_loottable_mischief($zoneid)) {
        my @item_pool = plugin::get_merged_pool($level, $zoneid);
        return unless @item_pool;

        my $selected_item = $item_pool[int(rand(scalar(@item_pool)))];
        $npc->AddItem($selected_item, 1);
        quest::debug(
            "Common mob static bonus loot: " .
            $npc->GetCleanName() .
            " added item " .
            $selected_item
        );
        return;
    }

    my $source = plugin::add_rare_spawn_loottable_roll($npc, $level, $zoneid, 1, $required_item_attempts, $common_item_threshold);
    if ($source) {
        plugin::pop_mischief_zone_shout(
            $zoneid,
            $npc->GetCleanName() .
            " trash surprise roll 1 used " .
            plugin::format_rare_spawn_source($source) .
            plugin::format_bonus_roll_attempts($source) .
            plugin::format_bonus_roll_fallback($source) .
            "; added " .
            plugin::format_bonus_roll_items($source->{added_items}) .
            "."
        );
        quest::debug(
            "Common mob bonus loottable roll: " .
            $npc->GetCleanName() .
            " rolled source NPC " .
            $source->{id} .
            " (" .
            $source->{name} .
            ") loottable " .
                $source->{loottable_id}
        );
    }
    else {
        plugin::pop_mischief_zone_shout(
            $zoneid,
            $npc->GetCleanName() .
            " trash surprise triggered but no eligible rare_spawn source was found for level " .
            $level .
            "."
        );
    }

    if ($source && rand() < $second_roll_chance) {
        my $second_source = plugin::add_rare_spawn_loottable_roll($npc, $level, $zoneid, 1, $required_item_attempts, $common_item_threshold);
        if ($second_source) {
            plugin::pop_mischief_zone_shout(
                $zoneid,
                $npc->GetCleanName() .
                " trash surprise roll 2 used " .
                plugin::format_rare_spawn_source($second_source) .
                plugin::format_bonus_roll_attempts($second_source) .
                plugin::format_bonus_roll_fallback($second_source) .
                "; added " .
                plugin::format_bonus_roll_items($second_source->{added_items}) .
                "."
            );
            quest::debug(
                "Common mob bonus loottable roll: " .
                $npc->GetCleanName() .
                " rolled 2nd source NPC " .
                $second_source->{id} .
                " (" .
                $second_source->{name} .
                ") loottable " .
                $second_source->{loottable_id}
            );
        }
    }
}

return 1;

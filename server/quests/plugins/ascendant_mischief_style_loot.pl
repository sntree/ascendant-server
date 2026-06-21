##############################################################################
# Rare/Named Mob Bonus Loot Plugin (Expansion-Aware)
##############################################################################
# Purpose: Guaranteed bonus loottable roll for rare/named spawns from a
#          random rare_spawn NPC in the same expansion and level block.
#
# Called from global_npc.pl:
#   plugin::rare_levelblock_loot($npc, $npc_level, $zoneid);
##############################################################################

sub rare_levelblock_loot {
    my $npc = shift;
    my $level = shift;
    my $zoneid = shift;

    return unless $npc;
    return unless $level;
    return unless $zoneid;

    # Configuration: Drop chances
    my $second_roll_chance = 0.10; # 10% chance for a 2nd rare loottable roll
    my $required_item_attempts = 25;
    my $common_item_threshold = 5; # reroll if every bonus item appears on >5 rare_spawn NPCs

    if (!plugin::uses_rare_loottable_mischief($zoneid)) {
        my @item_pool = plugin::get_merged_pool($level, $zoneid);
        return unless @item_pool;

        my $selected_item = $item_pool[int(rand(scalar(@item_pool)))];
        $npc->AddItem($selected_item, 1);
        quest::debug(
            "Mischief rare static pool roll: " .
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
            " bonus roll 1 used " .
            plugin::format_rare_spawn_source($source) .
            plugin::format_bonus_roll_attempts($source) .
            plugin::format_bonus_roll_fallback($source) .
            "; added " .
            plugin::format_bonus_roll_items($source->{added_items}) .
            "."
        );
        quest::debug(
            "Mischief rare loottable roll: " .
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
            " bonus roll failed: no eligible rare_spawn source for level " .
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
                " bonus roll 2 used " .
                plugin::format_rare_spawn_source($second_source) .
                plugin::format_bonus_roll_attempts($second_source) .
                plugin::format_bonus_roll_fallback($second_source) .
                "; added " .
                plugin::format_bonus_roll_items($second_source->{added_items}) .
                "."
            );
            quest::debug(
                "Mischief rare loottable roll: " .
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

my @kunark_shaman_spells = (
    7722, 66221, 7725, 66220, 19537, 19538, 7728, 7734, 7724,
    19530, 7721, 7731, 7727, 7723, 19531, 7741, 7739, 7740,
    7726, 19200, 19498, 7729, 19499, 7730, 7720
);

sub kunark_spell_bonus_loot {
    my ($npc, $level, $zoneid) = @_;

    return unless $level > 50;

    my $kunark_zones = plugin::kunark_zone_ids();
    return unless $kunark_zones->{$zoneid};

    # 1 in 15 chance
    return unless int(rand(15)) == 0;

    my $selected = $kunark_shaman_spells[int(rand(scalar(@kunark_shaman_spells)))];
    $npc->AddItem($selected, 1);
    quest::debug("Kunark spell bonus loot: Added item $selected (NPC level $level, zone $zoneid)");
}

return 1;

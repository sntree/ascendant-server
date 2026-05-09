sub try_tome_handins {
    my ($itemcount_ref, $player_class, $trainer_class_name) = @_;

    my %class_ids = (
        'Warrior'       => 1,
        'Cleric'        => 2,
        'Paladin'       => 3,
        'Ranger'        => 4,
        'Shadowknight'  => 5,
        'Shadow Knight' => 5,
        'Druid'         => 6,
        'Monk'          => 7,
        'Bard'          => 8,
        'Rogue'         => 9,
        'Shaman'        => 10,
        'Necromancer'   => 11,
        'Wizard'        => 12,
        'Magician'      => 13,
        'Enchanter'     => 14,
        'Beastlord'     => 15,
        'Berserker'     => 16,
    );

    my $trainer_class = $class_ids{$trainer_class_name} || 0;
    return 0 unless $trainer_class;

    return plugin::HandleTomeTurnin($npc, $client, $itemcount_ref, $trainer_class);
}

1;


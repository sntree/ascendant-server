# Arx Key DZ fix: Spell 2931 (Arx Foris) teleports to sseru instance 0,
# which ejects players from DZ instances. Intercept the click and redirect
# to the correct instance with the spell's destination coordinates.
# Arx Key variants: 3650, 303650, 503650, 703650 (all cast spell 2931)

sub EVENT_ITEM_CLICK_CLIENT {
    if ($item_id == 3650 || $item_id == 303650 || $item_id == 503650 || $item_id == 703650) {
        my $inst = $client->GetInstanceID();
        if ($inst > 0) {
            # Spell 2931 destination: x=-231, y=-290, z=60, heading=267
            $client->MovePC(159, $inst, -231, -290, 60, 267);
            quest::settimer("arx_interrupt", 1);
        }
    }
}

sub EVENT_TIMER {
    if ($timer eq "arx_interrupt") {
        quest::stoptimer("arx_interrupt");
        $client->InterruptSpell(2931);
    }
}

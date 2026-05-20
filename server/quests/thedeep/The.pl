# Burrower Beast event controller
#

sub EVENT_SPAWN {
  $counter = 0;
  $x = $npc->GetX();
  $y = $npc->GetY();
  quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50);
}

sub EVENT_ENTER {
  quest::settimer("next_wave",120);
  quest::emote("ground around you begins to tremble and shake.");
  quest::clear_proximity();
}

sub EVENT_TIMER {
  if ($timer eq "next_wave") {
    quest::stoptimer("next_wave");
    spawn_next_wave();
  }
  elsif ($timer eq "check_wave") {
    check_wave_clear();
  }
}

sub spawn_next_wave {
  $counter += 1;

  if ($counter <= 3) {
    quest::spawn2(164118,0,0,1780,227,-63.1,0); #rock burrower
    quest::spawn2(164118,0,0,1671,165,-18.9,0); #rock burrower
    quest::spawn2(164118,0,0,1649,233,-30.3,0); #rock burrower
    quest::spawn2(164118,0,0,1666,392,-14.9,0); #rock burrower
    quest::spawn2(164104,0,0,1747,392,-25.8,0); #spined rock burrower
    quest::spawn2(164104,0,0,1847,403,-34.5,0); #spined rock burrower
    quest::spawn2(164104,0,0,1870,389,-19,0); #spined rock burrower
    quest::spawn2(164104,0,0,1882,321,-30,0); #spined rock burrower
    quest::spawn2(164100,0,0,1852,206,-65.4,0); #stone carver
    quest::spawn2(164100,0,0,1903,160,-14.2,0); #stone carver
    quest::spawn2(164100,0,0,1837,146,-31.1,0); #stone carver
    quest::spawn2(164100,0,0,1770,294,-57.5,0); #stone carver
    quest::settimer("check_wave",5);
  }
  elsif (($counter >= 4) && ($counter <= 6)) {
    quest::spawn2(164108,0,0,1780,227,-63.1,0); #core burrower
    quest::spawn2(164108,0,0,1671,165,-18.9,0); #core burrower
    quest::spawn2(164108,0,0,1649,233,-30.3,0); #core burrower
    quest::spawn2(164108,0,0,1666,392,-14.9,0); #core burrower
    quest::spawn2(164108,0,0,1747,392,-25.8,0); #core burrower
    quest::spawn2(164108,0,0,1847,403,-34.5,0); #core burrower
    quest::settimer("check_wave",5);
  }
  elsif ($counter == 7) {
    quest::spawn2(164085,0,0,1747,392,-25.8,0); #parasite larva
    quest::spawn2(164085,0,0,1837,146,-31.1,0); #parasite larva
    quest::settimer("check_wave",5);
  }
  elsif ($counter == 8) {
    quest::spawn2(164089,0,0,1780,227,-63.1,0); #burrower parasite
    $counter = 0;
    quest::depop();
  }
}

sub check_wave_clear {
  my @wave_npcs = get_wave_npcs();
  return if quest::countspawnednpcs(@wave_npcs) > 0;

  quest::stoptimer("check_wave");
  quest::settimer("next_wave",120);
}

sub get_wave_npcs {
  if ($counter <= 3) {
    return (164118, 164104, 164100); # rock burrower, spined rock burrower, stone carver
  }
  elsif (($counter >= 4) && ($counter <= 6)) {
    return (164108); # core burrower
  }
  elsif ($counter == 7) {
    return (164085); # parasite larva
  }

  return ();
}

# zone: thedeep ID: 164120 NPC: The


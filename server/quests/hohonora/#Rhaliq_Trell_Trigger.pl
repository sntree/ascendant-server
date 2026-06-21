# #Rhaliq_Trell_Trigger (NPC 211087) -- controller for the "save the innocents" trial.
#
# Solo-friendly redesign: the three chambers are run ONE AT A TIME and a chamber
# only goes hot when a player tells Rhaliq Trell (NPC 211050) they are "ready".
# Rhaliq forwards that as signal 3.
#   signal 1 = a villager in the active chamber died
#   signal 2 = an enemy in the active chamber died
#   signal 3 = a player said "ready" to Rhaliq (begin / advance a chamber)

use constant ENEMIES_PER_ROOM    => 4;
use constant VILLAGERS_PER_ROOM  => 4;
use constant INACTIVITY_SECONDS  => 1200;   # abandon the trial after 20m of no kills
use constant GRACE_SECONDS       => 20;     # grace period after "ready" before the attackers spawn

my $room           = 0;   # 0 = not started, 1..3 = active chamber
my $awaiting       = 1;   # waiting for a "ready" to begin / advance the next chamber
my $enemies_dead   = 0;
my $villagers_dead = 0;

sub EVENT_SPAWN {
	$room = 0;
	$awaiting = 1;
	$enemies_dead = 0;
	$villagers_dead = 0;
	quest::stoptimer(1);
	quest::stoptimer(2);
}

sub PoP_SpawnVillager {
	my ($x, $y) = @_;
	# random villager race; each villager script signals this trigger on death
	quest::spawn2(quest::ChooseRandom(211089,211090,211091,211092,211093,211094,211095),0,0,$x,$y,-115,130);
}

sub PoP_SpawnRoom {
	my ($n) = @_;
	$enemies_dead = 0;
	$villagers_dead = 0;

	# Spawn the innocents immediately so players can find the chamber, but hold the
	# attackers back for a grace period so the group has time to run into position.
	if ($n == 1) {
		PoP_SpawnVillager(651,1324);
		PoP_SpawnVillager(564,1412);
		PoP_SpawnVillager(651,1415);
		PoP_SpawnVillager(564,1324);
	}
	elsif ($n == 2) {
		PoP_SpawnVillager(1338,1331);
		PoP_SpawnVillager(1253,1332);
		PoP_SpawnVillager(1251,1417);
		PoP_SpawnVillager(1341,1417);
	}
	elsif ($n == 3) {
		PoP_SpawnVillager(1341,2015);
		PoP_SpawnVillager(1342,1923);
		PoP_SpawnVillager(1251,1922);
		PoP_SpawnVillager(1249,2016);
	}

	quest::shout("Chamber $n: get into position -- the attackers arrive in " . GRACE_SECONDS . " seconds!");
	quest::stoptimer(1);
	quest::settimer(1, GRACE_SECONDS);   # timer 1 spawns the attackers after the grace period
}

sub PoP_SpawnEnemies {
	my ($n) = @_;

	if ($n == 1) {
		quest::spawn2(211096,0,0,612,1493,-115,260);
		quest::spawn2(211097,0,0,609,1250,-115,0);
		quest::spawn2(211098,0,0,679,1372,-115,382);
		quest::spawn2(211107,0,0,694,1372,-115,382); # unstacked (+15x) so it can't be missed
	}
	elsif ($n == 2) {
		quest::spawn2(211099,0,0,1395,1376,-115,382);
		quest::spawn2(211100,0,0,1293,1273,-115,0);
		quest::spawn2(211101,0,0,1293,1471,-115,260);
		quest::spawn2(211108,0,0,1308,1471,-115,260); # unstacked (+15x)
	}
	elsif ($n == 3) {
		quest::spawn2(211102,0,0,1405,1969,-115,386);
		quest::spawn2(211103,0,0,1296,2071,-115,260);
		quest::spawn2(211104,0,0,1175,1968,-115,126);
		quest::spawn2(211109,0,0,1190,1968,-115,126); # unstacked (+15x)
	}

	quest::shout("Chamber $n: protect the innocents and slay every attacker!");
	quest::stoptimer(2);
	quest::settimer(2, INACTIVITY_SECONDS);
}

sub PoP_Cleanup {
	# signal every possible trial mob to depop (villagers + enemies)
	for my $id (211089..211104, 211107..211109) {
		quest::signal($id);
	}
}

sub PoP_Reset {
	$room = 0;
	$awaiting = 1;
	$enemies_dead = 0;
	$villagers_dead = 0;
	quest::stoptimer(1);
	quest::stoptimer(2);
}

sub PoP_Win {
	quest::spawn2(211105,0,0,456,1374,-113,131); # Rhaliq Trell (hail version - grants the flag)
	quest::updatespawntimer(44016,259200000);    # Rhaliq Trell 3 days on win
	quest::signal(211050);                        # step the trial-giver aside; the flag version is up
	PoP_Cleanup();
	PoP_Reset();
}

sub PoP_Fail {
	quest::shout("The innocents have fallen. The trial is lost... steel yourself and tell Rhaliq Trell you are [ready] to try again.");
	# Retry-friendly fail: no respawn lockout, and Rhaliq Trell (211050) is left up
	# (PoP_Reset no longer steps him aside) so the trial can be restarted immediately.
	PoP_Cleanup();
	PoP_Reset();
}

sub EVENT_SIGNAL {
	if ($signal == 3) {
		# A player told Rhaliq they are ready.
		if ($room == 0) {
			$room = 1;
			$awaiting = 0;
			PoP_SpawnRoom(1);
		}
		elsif ($awaiting && $room >= 1 && $room <= 2) {
			$room++;
			$awaiting = 0;
			PoP_SpawnRoom($room);
		}
		elsif (!$awaiting && $room >= 1 && $room <= 3) {
			quest::shout("Finish securing the current chamber before you press on!");
		}
		return;
	}

	# Ignore stray kill signals when no chamber is hot.
	return if ($room < 1 || $room > 3 || $awaiting);

	if ($signal == 1) {
		$villagers_dead++;
		if ($villagers_dead >= VILLAGERS_PER_ROOM) {
			PoP_Fail();
		}
		else {
			quest::stoptimer(2);
			quest::settimer(2, INACTIVITY_SECONDS);
		}
	}
	elsif ($signal == 2) {
		$enemies_dead++;
		quest::stoptimer(2);
		quest::settimer(2, INACTIVITY_SECONDS);
		if ($enemies_dead >= ENEMIES_PER_ROOM) {
			if ($room >= 3) {
				PoP_Win();
			}
			else {
				$awaiting = 1;
				quest::stoptimer(2);
				quest::settimer(2, INACTIVITY_SECONDS);
				quest::shout("Chamber $room is secure! Return to Rhaliq Trell and tell him you are ready to continue.");
			}
		}
	}
}

sub EVENT_TIMER {
	if ($timer == 1) {
		# Grace period elapsed -- release the attackers for the active chamber.
		quest::stoptimer(1);
		PoP_SpawnEnemies($room) if (!$awaiting && $room >= 1 && $room <= 3);
	}
	elsif ($timer == 2) {
		quest::stoptimer(2);
		PoP_Fail() if ($room >= 1 && $room <= 3);
	}
}

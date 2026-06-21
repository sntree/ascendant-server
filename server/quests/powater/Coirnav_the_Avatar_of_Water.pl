#216048 - Fake (But still aggressive) Corirnav_the_Avatar_of_Water
sub EVENT_SPAWN {
  # Lockout key is instance-scoped (see #coirnav_controller.pl) so concurrent powater instances don't collide.
  my $done_key = $instanceid ? "${instanceid}_coirnav_done" : "coirnav_done";
  # Delete the lockout when the placeholder respawns; this NPC is not qglobal-enabled,
  # so checking $qglobals here can leave stale keys behind and make the Guardian depop.
  quest::delglobal($done_key);
}

sub EVENT_SIGNAL {
  if($signal == 1){ #First wave emote
    quest::shout("Those that violate my domain will pay. I call upon the power imbued to me by Povar! Come forth my minions of vapor and destroy these intruders.");
  } elsif($signal == 2){ #Second wave emote
    quest::shout("Those that violate my domain will pay. I call upon the power imbued to me by E`ci! Come forth my minions of ice and destroy these intruders.");
  } elsif($signal == 3){ #Third wave emote
    quest::shout("Those that violate my domain will pay. I call upon the power imbued to me by Tarew Marr! Come forth minions of water and destroy these intruders.");
  } elsif($signal == 7){ #Event kickout emote
    quest::shout("Violaters of this plane be banished from this domain!");
  }
}

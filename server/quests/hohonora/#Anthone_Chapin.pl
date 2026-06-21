# items: 52963, 52953
sub EVENT_SAY {
  if(plugin::check_hasitem($client, 54286) && ($text=~/hail/i)) { #Assembling the Staff
    quest::say("Mithaniel Marr himself has entrusted me with the power to purge taint from the most desecrated of objects.");
  }
}

sub EVENT_ITEM {
  if(plugin::check_hasitem($client, 54286) && plugin::check_handin(\%itemcount, 52963 => 1)) { #Assembling the Staff, Sullied Gold Filigree
    quest::say("This filigree now shines from within with the holy light of Marr.");
    quest::summonitem(52953); #Purified Gold Filigree
    # Instance-scoped key so concurrent hohonora instances don't share the Anthone respawn lock.
    my $anthone_key = $instanceid ? "${instanceid}_anthone" : "anthone";
    quest::setglobal($anthone_key,0,2,"M30");
    quest::depop();
  }
  plugin::return_items(\%itemcount);
}
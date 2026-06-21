sub EVENT_SAY {
  if($text=~/Hail/i && $qglobals{pop_cod_preflag} == 1) {
    quest::say("You believe you can [" . quest::saylink("challenge Bertoxxulous") . "], mortal?");
  }
  if($text=~/Challenge Bertoxxulous/i && $qglobals{pop_cod_preflag} == 1) {
    quest::say("Give the Crypt Lord my regards");
    quest::MovePCInstance(200,$instanceid,0,-16,-289,128); # Zone: lakeofillomen
  }
}

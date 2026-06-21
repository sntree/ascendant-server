# Chronicler Elodin - Server Info & Guide NPC (Guild Lobby)
# Author: Straps
#
# Interactive help NPC that displays popup guides for all major server systems:
# overview, benedictions, marks of ascendance, AA tome system, transportation,
# and hub services. Pure information — no gameplay mechanics.

sub EVENT_SAY {
    if ($text =~ /hail/i) {
        plugin::Whisper("Greetings, $name. I am Chronicler Elodin, keeper of knowledge and guidance for those who walk these halls.");
        plugin::Whisper("I can share information about our realm's unique features:");
        plugin::Whisper(quest::saylink("server overview", 1)." | ".quest::saylink("ascendant buffs", 1)." | ".quest::saylink("marks of ascendance", 1)." | ".quest::saylink("aa tome system", 1));
        plugin::Whisper(quest::saylink("transportation", 1)." | ".quest::saylink("hub services", 1));
        if (_is_admin($client)) {
            plugin::Whisper("[Admin] " . quest::saylink("admin shard tools", 1, "Shard Tools"));
        }
    }
    elsif (_is_admin($client) && $text =~ /^admin shard tools$/i) {
        _show_shard_tools($client);
    }
    elsif (_is_admin($client) && $text =~ /^shardmover\s+(\d+)$/i) {
        _preview_shard_move($client, int($1));
    }
    elsif (_is_admin($client) && $text =~ /^confirm shardmover\s+(\d+)$/i) {
        _run_shard_move($client, int($1));
    }
    elsif ($text =~ /server overview/i) {
        my $popup_text = "<c \"#FFFFFF\"><b>Welcome to our Enhanced Classic Server!</b></c><br><br>";
        $popup_text .= "<c \"#FFD700\"><b>Server Philosophy:</b></c><br>";
        $popup_text .= "This server is designed around a <c \"#00FFFF\">solo or duo experience</c>, allowing adventurers to explore Norrath at their own pace without requiring large groups.<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Key Features:</b></c><br>";
        $popup_text .= "<c \"#00FF00\">•</c> Multi-tiered progression system with powerful items<br>";
        $popup_text .= "<c \"#00FF00\">•</c> Server-wide Ascendant Benedictions (buffs)<br>";
        $popup_text .= "<c \"#00FF00\">•</c> Mark of Ascendance reward system<br>";
        $popup_text .= "<c \"#00FF00\">•</c> Enhanced AA abilities for convenience<br>";
        $popup_text .= "<c \"#00FF00\">•</c> Centralized hub with portal services<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Item Tiers:</b></c><br>";
        $popup_text .= "The server features <c \"#00FFFF\">4 distinct item tiers</c> that provide progressive power increases as you adventure.<br>";
        $popup_text .= "<c \"#808080\">These powerful items are found throughout the world, rewarding exploration and combat.</c><br><br>";
        
        $popup_text .= "<c \"#808080\">Ask me about specific features for more details.</c>";
        
        $client->Popup2(
            "Server Overview",
            $popup_text,
            0, 0,
            0, 0
        );
    }
    elsif ($text =~ /ascendant buffs/i) {
        my $popup_text = "<c \"#FFCC00\"><b>Ascendant World Benedictions</b></c><br><br>";
        $popup_text .= "These are <c \"#00FFFF\">server-wide buffs</c> that benefit <c \"#FFD700\">ALL players</c> simultaneously, regardless of location.<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Available Benedictions:</b></c><br>";
        $popup_text .= "<c \"#00FF00\">• Ascendant Haste</c> - Increased attack speed<br>";
        $popup_text .= "<c \"#00FF00\">• Ascendant Healing</c> - Enhanced regeneration<br>";
        $popup_text .= "<c \"#00FF00\">• Ascendant Run Speed</c> - Faster movement<br>";
        $popup_text .= "<c \"#00FF00\">• Ascendant Thought</c> - Improved mana regeneration<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>How It Works:</b></c><br>";
        $popup_text .= "Visit <c \"#00FFFF\">Exarch Valeth</c> in the Guild Lobby to check buff status and extend durations.<br><br>";
        $popup_text .= "Extensions cost <c \"#FFCC00\">1 Mark of Ascendance</c> and add <c \"#00FFFF\">6 hours</c> (max 48h).<br><br>";
        $popup_text .= "Buffs automatically reapply when you zone or log in!<br><br>";
        
        $popup_text .= "<c \"#808080\">These benedictions are a community effort - when one player extends them, everyone benefits!</c>";
        
        $client->Popup2(
            "Ascendant World Benedictions",
            $popup_text,
            0, 0,
            0, 0
        );
    }
    elsif ($text =~ /marks of ascendance/i) {
        my $popup_text = "<c \"#FFCC00\"><b>Marks of Ascendance</b></c><br><br>";
        $popup_text .= "Marks are the server's <c \"#FFD700\">premium currency</c>, earned through gameplay and used for special services.<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>How to Earn Marks:</b></c><br>";
        $popup_text .= "<c \"#00FF00\">• Online Time</c> - Random chance while playing (once per day)<br>";
        $popup_text .= "<c \"#00FF00\">• Combat</c> - Rare drop from defeating enemies (once per day)<br>";
        $popup_text .= "<c \"#808080\">Weekly limit: 7 marks total from both sources</c><br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>What Marks Are Used For:</b></c><br>";
        $popup_text .= "<c \"#00FFFF\">• Extending Ascendant Benedictions</c> (1 mark = 6 hours)<br>";
        $popup_text .= "<c \"#00FFFF\">• Future premium services</c> (more to come!)<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Checking Your Balance:</b></c><br>";
        $popup_text .= "Hail <c \"#00FFFF\">Exarch Valeth</c> to see your current Mark count.<br><br>";
        
        $popup_text .= "<c \"#808080\">Marks are account-bound and cannot be traded.</c>";
        
        $client->Popup2(
            "Marks of Ascendance",
            $popup_text,
            0, 0,
            0, 0
        );
    }
    elsif ($text =~ /aa tome system/i) {
        my $popup_text = "<c \"#FFCC00\"><b>Alternative Advancement Tome System</b></c><br><br>";
        $popup_text .= "Discover powerful abilities from <c \"#FFD700\">other classes</c> through ancient tomes!<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>How It Works:</b></c><br>";
        $popup_text .= "<c \"#00FF00\">1. Find Illegible Tomes</c><br>";
        $popup_text .= "<c \"#808080\">  Drop from NPCs throughout the world</c><br>";
        $popup_text .= "<c \"#808080\">  Three tiers: Greater, Exalted, Ascendant</c><br><br>";
        
        $popup_text .= "<c \"#00FF00\">2. Translate the Tome</c><br>";
        $popup_text .= "<c \"#808080\">  Bring illegible tome + platinum to <c \"#00FFFF\">Haliax Greycloak</c></c><br>";
        $popup_text .= "<c \"#808080\">  Cost: 250pp (Greater), 500pp (Exalted), 1000pp (Ascendant)</c><br>";
        $popup_text .= "<c \"#808080\">  Receive random AA tome for that class</c><br><br>";
        
        $popup_text .= "<c \"#00FF00\">3. Learn the Ability</c><br>";
        $popup_text .= "<c \"#808080\">  Turn in translated tome to one of the class trainers for that AA <c \"#00FFFF\">class trainer</c></c><br>";
        $popup_text .= "<c \"#808080\">  Instantly gain the full AA (all ranks)</c><br>";
        $popup_text .= "<c \"#808080\">  No AA points required!</c><br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Key NPCs:</b></c><br>";
        $popup_text .= "<c \"#00FFFF\">• Haliax Greycloak</c> - Tome translator (here in Guild Lobby)<br>";
        $popup_text .= "<c \"#00FFFF\">• Class Trainers</c> - Grant AAs from translated tomes<br><br>";
        
        $popup_text .= "<c \"#808080\">This system lets you gain powerful cross-class abilities that were previously unavailable to your class!</c>";
        
        $client->Popup2(
            "AA Tome System",
            $popup_text,
            0, 0,
            0, 0
        );
    }
    elsif ($text =~ /transportation/i) {
        my $popup_text = "<c \"#FFCC00\"><b>Getting Around Norrath</b></c><br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>AA Abilities (Always Available):</b></c><br>";
        $popup_text .= "<c \"#00FF00\">• Origin</c> - Returns you to your home city (bind point)<br>";
        $popup_text .= "<c \"#808080\">  Perfect for buying spells and supplies</c><br>";
        $popup_text .= "<c \"#00FF00\">• Marked Passage</c> - Teleports to Guild Lobby and back<br>";
        $popup_text .= "<c \"#808080\">  First cast: marks your location and goes to hub</c><br>";
        $popup_text .= "<c \"#808080\">  Second cast: returns you to marked location</c><br>";
        $popup_text .= "<c \"#808080\">  Location clears if you zone elsewhere</c><br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Portal Services in Guild Lobby:</b></c><br>";
        $popup_text .= "<c \"#00FFFF\">• Spirekeeper Aethen</c> - Wizard spires to major cities<br>";
        $popup_text .= "<c \"#00FFFF\">• Circlekeeper Aurin</c> - Druid rings to natural zones<br>";
        $popup_text .= "<c \"#00FFFF\">• Nyra Silvermark</c> - Direct transport to Bazaar<br><br>";
        
        $popup_text .= "<c \"#808080\">Tip: Use Marked Passage to quickly return to the hub from anywhere!</c>";
        
        $client->Popup2(
            "Transportation Guide",
            $popup_text,
            0, 0,
            0, 0
        );
    }
    elsif ($text =~ /hub services/i) {
        my $popup_text = "<c \"#FFCC00\"><b>Guild Lobby Hub Services</b></c><br><br>";
        $popup_text .= "The Guild Lobby serves as the central hub for all adventurers.<br><br>";
        
        $popup_text .= "<c \"#FFD700\"><b>Key NPCs:</b></c><br>";
        $popup_text .= "<c \"#00FFFF\">• Exarch Valeth</c><br>";
        $popup_text .= "<c \"#808080\">  Manages Ascendant Benedictions</c><br>";
        $popup_text .= "<c \"#808080\">  Check buff status and extend durations</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Spirekeeper Aethen</c><br>";
        $popup_text .= "<c \"#808080\">  Wizard portal network</c><br>";
        $popup_text .= "<c \"#808080\">  Access to all major wizard spires</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Circlekeeper Aurin</c><br>";
        $popup_text .= "<c \"#808080\">  Druid circle network</c><br>";
        $popup_text .= "<c \"#808080\">  Access to all druid rings</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Nyra Silvermark</c><br>";
        $popup_text .= "<c \"#808080\">  Steward of the Merchant Gate</c><br>";
        $popup_text .= "<c \"#808080\">  Quick transport to/from Bazaar</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Kilven the Quartermaster</c><br>";
        $popup_text .= "<c \"#808080\">  General supplies and provisions</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Haliax Greycloak</c><br>";
        $popup_text .= "<c \"#808080\">  Tome translator - converts illegible tomes</c><br>";
        $popup_text .= "<c \"#808080\">  Access cross-class AA abilities</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Class Trainers</c><br>";
        $popup_text .= "<c \"#808080\">  Grant AA abilities from translated tomes</c><br><br>";
        
        $popup_text .= "<c \"#00FFFF\">• Chronicler Elodin</c> (that's me!)<br>";
        $popup_text .= "<c \"#808080\">  Server information and guidance</c><br><br>";
        
        $popup_text .= "<c \"#808080\">Hail any NPC to learn more about their services!</c>";
        
        $client->Popup2(
            "Guild Lobby Hub Services",
            $popup_text,
            0, 0,
            0, 0
        );
    }
}

sub _is_admin {
    my ($client) = @_;
    return $client && $client->Admin() >= 100;
}

sub _show_shard_tools {
    my ($client) = @_;
    my $current_instance = $client->GetInstanceID() || 0;
    my $zone_id = $client->GetZoneID();
    my $zone_name = quest::GetZoneShortName($zone_id);
    my @client_list = $entity_list->GetClientList();
    my $count = scalar @client_list;

    plugin::Whisper("Current zone: $zone_name ($zone_id), instance $current_instance, clients in this process: $count.");
    plugin::Whisper("Say 'shardmover <target_instance_id>' to preview moving everyone in this zone process to another instance of the same zone. Use 0 for the base zone.");
}

sub _preview_shard_move {
    my ($client, $target_instance) = @_;
    my ($valid, $message) = _validate_shard_target($client, $target_instance);
    if (!$valid) {
        plugin::Whisper($message);
        return;
    }

    my $current_instance = $client->GetInstanceID() || 0;
    my @client_list = $entity_list->GetClientList();
    my $count = scalar @client_list;
    my $confirm = quest::saylink("confirm shardmover $target_instance", 1, "Confirm move to instance $target_instance");

    plugin::Whisper("Preview: move $count client(s) from instance $current_instance to instance $target_instance.");
    plugin::Whisper("This preserves each player's current coordinates and heading. $confirm");
}

sub _run_shard_move {
    my ($client, $target_instance) = @_;
    my ($valid, $message) = _validate_shard_target($client, $target_instance);
    if (!$valid) {
        plugin::Whisper($message);
        return;
    }

    my $zone_id = $client->GetZoneID();
    my $current_instance = $client->GetInstanceID() || 0;
    my @client_list = $entity_list->GetClientList();
    my @clients_to_move;
    my $issuer;
    my $issuer_char_id = $client->CharacterID();

    foreach my $move_client (@client_list) {
        next unless $move_client;

        if ($move_client->CharacterID() == $issuer_char_id) {
            $issuer = $move_client;
            next;
        }

        push @clients_to_move, $move_client;
    }

    push @clients_to_move, $issuer if $issuer;

    my $count = scalar @clients_to_move;
    if ($count == 0) {
        plugin::Whisper("No clients were found in this zone process.");
        return;
    }

    plugin::Whisper("Moving $count client(s) from instance $current_instance to instance $target_instance. You will move last.");
    quest::debug("[ShardMover] " . $client->GetCleanName() . " moving $count client(s) in zone $zone_id from instance $current_instance to instance $target_instance");

    my $moved = 0;
    foreach my $move_client (@clients_to_move) {
        next unless $move_client;

        my $char_id = $move_client->CharacterID();
        if ($target_instance > 0 && !quest::CheckInstanceByCharID($target_instance, $char_id)) {
            quest::AssignToInstanceByCharID($target_instance, $char_id);
        }

        $move_client->Message(15, "This Guild Lobby shard is being recycled. Moving you to instance $target_instance.");
        $move_client->MovePCInstance(
            $zone_id,
            $target_instance,
            $move_client->GetX(),
            $move_client->GetY(),
            $move_client->GetZ(),
            $move_client->GetHeading()
        );

        $moved++;
    }

    quest::debug("[ShardMover] Requested moves for $moved client(s) to instance $target_instance");
}

sub _validate_shard_target {
    my ($client, $target_instance) = @_;
    my $zone_id = $client->GetZoneID();
    my $current_instance = $client->GetInstanceID() || 0;

    if ($target_instance < 0 || $target_instance > 65535) {
        return (0, "Enter a valid target instance ID between 0 and 65535.");
    }

    if ($target_instance == $current_instance) {
        return (0, "You are already in instance $target_instance.");
    }

    if ($target_instance == 0) {
        return (1, "");
    }

    my $target_zone_id = quest::GetInstanceZoneIDByID($target_instance);
    if (!$target_zone_id) {
        return (0, "Instance $target_instance does not exist.");
    }

    if ($target_zone_id != $zone_id) {
        my $target_zone_name = quest::GetZoneShortName($target_zone_id);
        my $current_zone_name = quest::GetZoneShortName($zone_id);
        return (0, "Instance $target_instance belongs to $target_zone_name, not $current_zone_name.");
    }

    if (!_instance_is_alive($target_instance, $zone_id)) {
        return (0, "Instance $target_instance is expired or unavailable.");
    }

    return (1, "");
}

sub _instance_is_alive {
    my ($target_instance, $zone_id) = @_;

    my $dbh = plugin::LoadMysql();
    return 1 unless $dbh;

    my ($count) = $dbh->selectrow_array(
        "SELECT COUNT(*) FROM instance_list WHERE id = ? AND zone = ? AND (never_expires = 1 OR (start_time + duration) > UNIX_TIMESTAMP())",
        undef,
        $target_instance,
        $zone_id
    );

    return $count && $count > 0;
}

1;

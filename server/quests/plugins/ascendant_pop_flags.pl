package plugin;

use strict;
use warnings;

my $EDIT_STATUS = 30;
my $PAGE_SIZE   = 12;

my @POP_FLAGS = (
    { category => "Disease", key => "pop_pod_alder_fuirstel", value => "1", label => "Adler Fuirstel: what ward" },
    { category => "Disease", key => "pop_pod_grimmus_planar_projection", value => "1", label => "Grummus projection" },
    { category => "Disease", key => "pop_pod_elder_fuirstel", value => "1", label => "Elder Fuirstel disease wrap-up" },

    { category => "Justice", key => "pop_poj_mavuin", value => "1", label => "Mavuin information" },
    { category => "Justice", key => "pop_poj_tribunal", value => "1", label => "Tribunal trial turn-in" },
    { category => "Justice", key => "pop_poj_valor_storms", value => "1", label => "Mavuin final hail for Valor/Storms" },
    { category => "Justice Trials", key => "pop_poj_execution", value => "1", label => "Trial marker: Execution" },
    { category => "Justice Trials", key => "pop_poj_flame", value => "1", label => "Trial marker: Flame" },
    { category => "Justice Trials", key => "pop_poj_hanging", value => "1", label => "Trial marker: Hanging" },
    { category => "Justice Trials", key => "pop_poj_lashing", value => "1", label => "Trial marker: Lashing" },
    { category => "Justice Trials", key => "pop_poj_stoning", value => "1", label => "Trial marker: Stoning" },
    { category => "Justice Trials", key => "pop_poj_torture", value => "1", label => "Trial marker: Torture" },

    { category => "Innovation", key => "pop_poi_dragon", value => "1", label => "Nitram/Xanamech factory access flag" },
    { category => "Innovation", key => "pop_poi_behometh_preflag", value => "1", label => "Giwin: test the machine" },
    { category => "Innovation", key => "pop_poi_behometh_flag", value => "1", label => "Manaetic Behemoth completion" },

    { category => "Nightmare", key => "pop_pon_hedge_jezith", value => "1", label => "Adroha Jezith hedge preflag" },
    { category => "Nightmare", key => "pop_pon_construct", value => "1", label => "Hedge maze / Thelin completion" },
    { category => "Nightmare", key => "pop_ponb_terris", value => "1", label => "Terris Thule projection" },
    { category => "Nightmare", key => "pop_ponb_poxbourne", value => "1", label => "Elder Poxbourne wrap-up" },

    { category => "Crypt of Decay", key => "pop_cod_preflag", value => "1", label => "Tarkil Adan / Carprin access" },
    { category => "Crypt of Decay", key => "pop_cod_bertox", value => "1", label => "Bertoxxulous projection" },
    { category => "Crypt of Decay", key => "pop_cod_final", value => "1", label => "Elder Fuirstel CoD wrap-up" },

    { category => "Torment", key => "pop_pot_shadyglade", value => "1", label => "Fahlia Shadyglade: I will go" },
    { category => "Torment", key => "pop_pot_newleaf", value => "1", label => "Keeper of Sorrows / Tylis Newleaf" },
    { category => "Torment", key => "pop_pot_saryrn", value => "1", label => "Saryrn projection" },
    { category => "Torment", key => "pop_pot_saryrn_final", value => "1", label => "Fahlia/Tylis final wrap-up" },

    { category => "Storms", key => "pop_pos_askr_the_lost", value => "3", label => "Askr the Lost giant quest complete" },
    { category => "Storms", key => "pop_pos_askr_the_lost_final", value => "1", label => "Askr final Bastion of Thunder access" },

    { category => "Valor", key => "pop_pov_aerin_dar", value => "1", label => "Aerin'Dar projection" },

    { category => "Bastion of Thunder", key => "pop_bot_agnarr", value => "1", label => "Agnarr projection" },
    { category => "Bastion of Thunder", key => "pop_bot_karana", value => "1", label => "Karana path of the fallen" },

    { category => "Halls of Honor", key => "pop_hoh_faye", value => "1", label => "Trydan Faye trial" },
    { category => "Halls of Honor", key => "pop_hoh_trell", value => "1", label => "Rhaliq Trell trial" },
    { category => "Halls of Honor", key => "pop_hoh_garn", value => "1", label => "Alekson Garn trial" },
    { category => "Halls of Honor", key => "pop_hohb_marr", value => "1", label => "Mithaniel Marr projection" },

    { category => "Tactics", key => "pop_tactics_vallon", value => "1", label => "Vallon Zek projection" },
    { category => "Tactics", key => "pop_tactics_tallon", value => "1", label => "Tallon Zek projection" },
    { category => "Tactics", key => "pop_tactics_ralloz", value => "1", label => "Rallos Zek projection" },

    { category => "Solusek Ro", key => "pop_sol_ro_xuzl", value => "1", label => "Xuzl mini" },
    { category => "Solusek Ro", key => "pop_sol_ro_arlyxir", value => "1", label => "Arlyxir mini" },
    { category => "Solusek Ro", key => "pop_sol_ro_jiva", value => "1", label => "Jiva mini" },
    { category => "Solusek Ro", key => "pop_sol_ro_rizlona", value => "1", label => "Rizlona mini" },
    { category => "Solusek Ro", key => "pop_sol_ro_dresolik", value => "1", label => "Protector of Dresolik mini" },
    { category => "Solusek Ro", key => "pop_sol_ro_solusk", value => "1", label => "Solusek Ro projection" },

    { category => "Elemental Access", key => "pop_elemental_grand_librarian", value => "1", label => "Grand Librarian elemental preflag" },
    { category => "Elementals", key => "pop_fire_fennin_projection", value => "1", label => "Fennin Ro projection" },
    { category => "Elementals", key => "pop_wind_xegony_projection", value => "1", label => "Xegony projection" },
    { category => "Elementals", key => "pop_water_coirnav_projection", value => "1", label => "Coirnav projection" },
    { category => "Elementals", key => "pop_eartha_arbitor_projection", value => "1", label => "Mystical Arbitor projection" },
    { category => "Elementals", key => "pop_earthb_rathe", value => "1", label => "Rathe Council projection" },

    { category => "Plane of Time", key => "pop_time_maelin", value => "1", label => "Loreseeker Maelin / Plane of Time access" },

    { category => "Access Shortcuts", key => "pop_alt_access_codecay", value => "1", label => "Backflag shortcut: Crypt of Decay" },
    { category => "Access Shortcuts", key => "pop_alt_access_potorment", value => "1", label => "Backflag shortcut: Plane of Torment" },
    { category => "Access Shortcuts", key => "pop_alt_access_hohonora", value => "1", label => "Backflag shortcut: Halls of Honor" },
    { category => "Access Shortcuts", key => "pop_alt_access_potactics", value => "1", label => "Backflag shortcut: Plane of Tactics" },
    { category => "Access Shortcuts", key => "pop_alt_access_solrotower", value => "1", label => "Backflag shortcut: Tower of Solusek Ro" },
    { category => "Access Shortcuts", key => "pop_pot_tt_hedge_bypass", value => "3", label => "Veriok Dreik Hedge/Terris bypass helper" },
);

my @POP_GUIDE_PLANES = (
    {
        tier => 1,
        plane => "Plane of Disease",
        summary => "Start the Grummus line and finish the Elder Fuirstel follow-up.",
        notes => [
            "This begins one of the three major prerequisite lines for later Torment and Elemental access.",
        ],
        steps => [
            { key => "pop_pod_alder_fuirstel", label => "Speak with Adler Fuirstel", task => "In Plane of Tranquility near the Plane of Disease stone, speak with Adler Fuirstel and ask about the ward.", result => "Starts the Disease progression thread." },
            { key => "pop_pod_grimmus_planar_projection", label => "Defeat Grummus", task => "Kill Grummus in Plane of Disease, then hail the planar projection.", result => "Records the Grummus victory." },
            { key => "pop_pod_elder_fuirstel", label => "Return to Elder Fuirstel", task => "Return to the sick bay follow-up NPC and complete the Grummus wrap-up.", result => "Completes the Disease side of this progression line." },
        ],
    },
    {
        tier => 1,
        plane => "Plane of Justice",
        summary => "Complete the Mavuin and Tribunal sequence to unlock Valor and Storms.",
        notes => [
            "Only one Justice trial is needed for normal progression, but this server also tracks each trial marker for testing.",
        ],
        steps => [
            { key => "pop_poj_mavuin", label => "Find Mavuin", task => "Speak with Mavuin in Plane of Justice and ask for information.", result => "Starts the Justice trial path." },
            { key => "pop_poj_tribunal", label => "Complete a Justice trial", task => "Complete a Justice trial, receive the trial mark, and report back through the Tribunal sequence.", result => "Records the trial evidence." },
            { key => "pop_poj_valor_storms", label => "Return to Mavuin", task => "Hail Mavuin after the Tribunal step.", result => "Unlocks the Valor and Storms branch of progression." },
        ],
    },
    {
        tier => 1,
        plane => "Plane of Innovation",
        summary => "Complete Giwin's Manaetic Behemoth line.",
        notes => [
            "The Nitram/Xanamech factory key is useful but treated as optional for the main progression path.",
        ],
        optional => [
            { key => "pop_poi_dragon", label => "Factory door access", task => "Complete the Nitram/Xanamech factory access task if you need the factory shortcut." },
        ],
        steps => [
            { key => "pop_poi_behometh_preflag", label => "Accept Giwin's machine test", task => "Speak with Giwin Mirakon in Plane of Innovation and agree to test the machine.", result => "Prepares the Manaetic Behemoth flag." },
            { key => "pop_poi_behometh_flag", label => "Defeat the Manaetic Behemoth", task => "Kill the Manaetic Behemoth and complete Giwin's follow-up.", result => "Completes this server's Tactics/Sol Ro prerequisite line." },
        ],
    },
    {
        tier => 1,
        plane => "Plane of Nightmare",
        summary => "Finish the Hedge Maze and Terris Thule line.",
        notes => [
            "This line is part of the later Torment and Elemental prerequisite set.",
        ],
        steps => [
            { key => "pop_pon_hedge_jezith", label => "Speak with Adroha Jezith", task => "Start the hedge preflag with Adroha Jezith in Plane of Nightmare.", result => "Prepares the Hedge Maze path." },
            { key => "pop_pon_construct", label => "Complete the Hedge Maze", task => "Complete the Hedge Maze rescue/event sequence involving Thelin.", result => "Grants access toward Lair of Terris Thule." },
            { key => "pop_ponb_terris", label => "Defeat Terris Thule", task => "Defeat Terris Thule in her lair and hail the planar projection.", result => "Records the Terris victory." },
            { key => "pop_ponb_poxbourne", label => "Return to Elder Poxbourne", task => "Complete the Terris wrap-up with Elder Poxbourne.", result => "Completes the Nightmare line." },
        ],
    },
    {
        tier => 2,
        plane => "Crypt of Decay",
        summary => "Enter Decay, defeat Bertoxxulous, and complete the Elder Fuirstel wrap-up.",
        notes => [
            "This line depends on earlier Disease progress.",
        ],
        steps => [
            { key => "pop_cod_preflag", label => "Gain Carprin/Crypt access", task => "Complete the Tarkil Adan and Carprin access sequence for Crypt of Decay.", result => "Opens the Crypt of Decay raid path." },
            { key => "pop_cod_bertox", label => "Defeat Bertoxxulous", task => "Defeat Bertoxxulous and hail the planar projection.", result => "Records the Bertoxxulous victory." },
            { key => "pop_cod_final", label => "Return to Elder Fuirstel", task => "Complete the Crypt of Decay wrap-up with Elder Fuirstel.", result => "Completes the Decay line." },
        ],
    },
    {
        tier => 2,
        plane => "Plane of Torment",
        summary => "Finish Fahlia, Keeper of Sorrows, and Saryrn.",
        notes => [
            "Torment normally opens after Disease, Nightmare, and Crypt of Decay progress.",
        ],
        steps => [
            { key => "pop_pot_shadyglade", label => "Speak with Fahlia Shadyglade", task => "Tell Fahlia Shadyglade that you will go.", result => "Starts the Torment progression line." },
            { key => "pop_pot_newleaf", label => "Rescue Tylis Newleaf", task => "Complete the Keeper of Sorrows and Tylis Newleaf sequence.", result => "Prepares the Saryrn step." },
            { key => "pop_pot_saryrn", label => "Defeat Saryrn", task => "Defeat Saryrn and hail the planar projection.", result => "Records the Saryrn victory." },
            { key => "pop_pot_saryrn_final", label => "Complete the Torment wrap-up", task => "Return to the Torment follow-up NPCs and finish the Saryrn wrap-up.", result => "Completes the Torment line." },
        ],
    },
    {
        tier => 2,
        plane => "Plane of Storms",
        summary => "Complete Askr the Lost's giant quest to reach Bastion of Thunder.",
        notes => [
            "This branch starts from the Justice/Mavuin Valor-Storms unlock.",
        ],
        steps => [
            { key => "pop_pos_askr_the_lost", value => "3", label => "Complete Askr the Lost's quest", task => "Complete the giant faction/medallion path for Askr the Lost in Plane of Storms.", result => "Marks the Storms quest complete." },
            { key => "pop_pos_askr_the_lost_final", label => "Receive Bastion of Thunder access", task => "Return to Askr and finish the Bastion of Thunder access step.", result => "Unlocks Bastion of Thunder." },
        ],
    },
    {
        tier => 2,
        plane => "Plane of Valor",
        summary => "Defeat Aerin'Dar to open the Halls of Honor path.",
        notes => [
            "This branch starts from the Justice/Mavuin Valor-Storms unlock.",
        ],
        steps => [
            { key => "pop_pov_aerin_dar", label => "Defeat Aerin'Dar", task => "Defeat Aerin'Dar in Plane of Valor and hail the planar projection.", result => "Unlocks the Halls of Honor branch." },
        ],
    },
    {
        tier => 3,
        plane => "Bastion of Thunder",
        summary => "Defeat Agnarr and speak with Karana.",
        notes => [
            "This path follows the Plane of Storms/Askr progression.",
        ],
        steps => [
            { key => "pop_bot_agnarr", label => "Defeat Agnarr", task => "Defeat Agnarr the Storm Lord and hail the planar projection.", result => "Records the Agnarr victory." },
            { key => "pop_bot_karana", label => "Speak with Karana", task => "Speak with Karana and follow the path of the fallen.", result => "Completes the Bastion of Thunder line." },
        ],
    },
    {
        tier => 3,
        plane => "Halls of Honor",
        summary => "Complete the three Halls of Honor trials.",
        notes => [
            "This path follows Plane of Valor and Aerin'Dar.",
        ],
        steps => [
            { key => "pop_hoh_faye", label => "Complete Trydan Faye's trial", task => "Complete the Trydan Faye trial in Halls of Honor.", result => "Records one Halls of Honor trial." },
            { key => "pop_hoh_trell", label => "Complete Rhaliq Trell's trial", task => "Complete the Rhaliq Trell trial in Halls of Honor.", result => "Records one Halls of Honor trial." },
            { key => "pop_hoh_garn", label => "Complete Alekson Garn's trial", task => "Complete the Alekson Garn trial in Halls of Honor.", result => "Records one Halls of Honor trial." },
        ],
    },
    {
        tier => 3,
        plane => "Temple of Marr",
        summary => "Defeat Mithaniel Marr.",
        notes => [
            "This path follows the Halls of Honor trials.",
        ],
        steps => [
            { key => "pop_hohb_marr", label => "Defeat Mithaniel Marr", task => "Defeat Mithaniel Marr and hail the planar projection.", result => "Completes the Marr line." },
        ],
    },
    {
        tier => 3,
        plane => "Plane of Tactics",
        summary => "Defeat the Zek commanders and Rallos Zek.",
        notes => [
            "On this server, Plane of Tactics access is tied to the Manaetic Behemoth line.",
        ],
        steps => [
            { key => "pop_tactics_vallon", label => "Defeat Vallon Zek", task => "Defeat Vallon Zek and hail the planar projection.", result => "Records one Tactics victory." },
            { key => "pop_tactics_tallon", label => "Defeat Tallon Zek", task => "Defeat Tallon Zek and hail the planar projection.", result => "Records one Tactics victory." },
            { key => "pop_tactics_ralloz", label => "Defeat Rallos Zek", task => "Defeat Rallos Zek and hail the planar projection.", result => "Completes the Tactics line." },
        ],
    },
    {
        tier => 4,
        plane => "Tower of Solusek Ro",
        summary => "Defeat the five minis, then Solusek Ro.",
        notes => [
            "This is the bridge from the pre-elemental raids into Elemental progression.",
        ],
        steps => [
            { key => "pop_sol_ro_xuzl", label => "Defeat Xuzl", task => "Defeat Xuzl in Solusek Ro Tower.", result => "Records one Sol Ro mini." },
            { key => "pop_sol_ro_arlyxir", label => "Defeat Arlyxir", task => "Defeat Arlyxir in Solusek Ro Tower.", result => "Records one Sol Ro mini." },
            { key => "pop_sol_ro_jiva", label => "Defeat Jiva", task => "Defeat Jiva in Solusek Ro Tower.", result => "Records one Sol Ro mini." },
            { key => "pop_sol_ro_rizlona", label => "Defeat Rizlona", task => "Defeat Rizlona in Solusek Ro Tower.", result => "Records one Sol Ro mini." },
            { key => "pop_sol_ro_dresolik", label => "Defeat the Protector of Dresolik", task => "Defeat the Protector of Dresolik in Solusek Ro Tower.", result => "Records the final Sol Ro mini." },
            { key => "pop_sol_ro_solusk", label => "Defeat Solusek Ro", task => "Defeat Solusek Ro and hail the planar projection.", result => "Completes the Solusek Ro Tower line." },
        ],
    },
    {
        tier => 4,
        plane => "Elemental Access",
        summary => "Speak with the Grand Librarian after completing the pre-elemental path.",
        notes => [
            "Use this as the checkpoint before working the Elemental gods.",
        ],
        steps => [
            { key => "pop_elemental_grand_librarian", label => "Speak with the Grand Librarian", task => "After the pre-elemental flags are complete, speak with the Grand Librarian in Plane of Knowledge.", result => "Unlocks Elemental progression." },
        ],
    },
    {
        tier => 4,
        plane => "Elemental Planes",
        summary => "Defeat the Elemental gods and their related events.",
        notes => [
            "These can be worked in different orders once Elemental access is available.",
        ],
        steps => [
            { key => "pop_fire_fennin_projection", label => "Defeat Fennin Ro", task => "Defeat Fennin Ro in Plane of Fire and hail the projection.", result => "Records the Fire victory." },
            { key => "pop_wind_xegony_projection", label => "Defeat Xegony", task => "Defeat Xegony in Plane of Air and hail the projection.", result => "Records the Air victory." },
            { key => "pop_water_coirnav_projection", label => "Defeat Coirnav", task => "Defeat Coirnav in Plane of Water and hail the projection.", result => "Records the Water victory." },
            { key => "pop_eartha_arbitor_projection", label => "Complete Plane of Earth A", task => "Complete the Mystical Arbitor / Earth A progression and hail the projection.", result => "Unlocks the Earth B branch." },
            { key => "pop_earthb_rathe", label => "Defeat the Rathe Council", task => "Defeat the Rathe Council in Plane of Earth B and hail the projection.", result => "Completes the Earth victory." },
        ],
    },
    {
        tier => 4,
        plane => "Plane of Time",
        summary => "Complete the final Maelin sequence for Plane of Time access.",
        notes => [
            "The final sequence uses the Quintessence of Elements and Maelin's dialogue path.",
        ],
        steps => [
            { key => "pop_time_maelin", label => "Complete Loreseeker Maelin's final step", task => "After the Elemental victories, complete the Quintessence, Chronographer Muon, and Loreseeker Maelin sequence.", result => "Unlocks Plane of Time." },
        ],
    },
);

sub PoPFlags_HandleSay {
    my ($client, $text, $status) = @_;
    return 0 unless $client && defined $text && $text =~ /^#popflags\b/i;

    my $can_edit = PoPFlags_CanEdit($client, $status);

    if ($text =~ /^#popflags\s+set\s+(\d+)(?:\s+cat\s+(\d+))?$/i) {
        unless ($can_edit) {
            PoPFlags_ShowPlayerPopup($client, "help", undef, 0);
            return 1;
        }
        my $idx = int($1) - 1;
        my $cat_id = defined $2 ? int($2) : undef;
        return PoPFlags_SetFlag($client, $idx, $cat_id, $status);
    }

    if ($text =~ /^#popflags\s+clear\s+(\d+)(?:\s+cat\s+(\d+))?$/i) {
        unless ($can_edit) {
            PoPFlags_ShowPlayerPopup($client, "help", undef, 0);
            return 1;
        }
        my $idx = int($1) - 1;
        my $cat_id = defined $2 ? int($2) : undef;
        return PoPFlags_ClearFlag($client, $idx, $cat_id, $status);
    }

    if ($can_edit && $text =~ /^#popflags\s+gm$/i) {
        PoPFlags_ShowDashboard($client, $status);
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+debug\s+(\d+)$/i) {
        PoPFlags_ShowStep($client, int($1) - 1, $status);
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+debugcat\s+(\d+)$/i) {
        PoPFlags_ShowCategory($client, int($1), $status);
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+list(?:\s+(\d+))?$/i) {
        if (defined $1) {
            PoPFlags_ShowList($client, int($1), $status);
        } else {
            PoPFlags_ShowDashboard($client, $status);
        }
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+page(?:\s+(\d+))?$/i) {
        my $page = defined $1 ? int($1) : 1;
        PoPFlags_ShowList($client, int($page), $status);
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+debugmissing$/i) {
        my $values = PoPFlags_CurrentValues($client);
        my $idx = PoPFlags_FirstIncompleteIndex($values);
        if (defined $idx) {
            PoPFlags_ShowStep($client, $idx, $status);
        } else {
            $client->Message(10, "[PoP Staff Debug] Every tracked debug qglobal is currently set.");
            PoPFlags_ShowDashboard($client, $status);
        }
        return 1;
    }

    if ($can_edit && $text =~ /^#popflags\s+syncaccess$/i) {
        my $values = PoPFlags_CurrentValues($client);
        PoPFlags_SyncZoneFlags($client, $values);
        PoPFlags_ShowPlayerPopup($client, "access", undef, 1, $status);
        return 1;
    }

    return PoPFlags_HandlePlayerSay($client, $text, $can_edit, $status);
}

sub PoPFlags_HandlePlayerSay {
    my ($client, $text, $can_edit, $status) = @_;
    $can_edit ||= 0;

    if ($text =~ /^#popflags\s+(?:set|clear)\b/i) {
        PoPFlags_ShowPlayerPopup($client, "help", undef, $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+tier\s+([1-4])$/i) {
        PoPFlags_ShowPlayerPopup($client, "tier", int($1), $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+(?:plane|cat(?:egory)?)\s+(\d+)$/i) {
        PoPFlags_ShowPlayerPopup($client, "plane", int($1), $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+access$/i) {
        PoPFlags_ShowPlayerPopup($client, "access", undef, $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+(?:next|missing)$/i) {
        PoPFlags_ShowPlayerPopup($client, "next", undef, $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+step\s+(\d+)$/i) {
        PoPFlags_ShowPlayerPopup($client, "step", int($1), $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+(?:status|overview|list|page)(?:\s+\d+)?$/i) {
        PoPFlags_ShowPlayerPopup($client, "overview", undef, $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags\s+(?:help|\?)$/i) {
        PoPFlags_ShowPlayerPopup($client, "help", undef, $can_edit, $status);
        return 1;
    }

    if ($text =~ /^#popflags(?:\s+show)?(?:\s+(\d+))?$/i) {
        if (defined $1) {
            PoPFlags_ShowPlayerPopup($client, "step", int($1), $can_edit, $status);
        } else {
            PoPFlags_ShowPlayerPopup($client, "overview", undef, $can_edit, $status);
        }
        return 1;
    }

    PoPFlags_ShowPlayerPopup($client, "help", undef, $can_edit, $status);
    return 1;
}

sub PoPFlags_AdminStatus {
    my ($client, $status) = @_;
    my $admin = defined $status ? int($status) : 0;
    my $client_admin = 0;
    eval { $client_admin = int($client->Admin() || 0); };
    return $client_admin > $admin ? $client_admin : $admin;
}

sub PoPFlags_CanEdit {
    my ($client, $status) = @_;
    return PoPFlags_AdminStatus($client, $status) > $EDIT_STATUS;
}

sub PoPFlags_RequireEdit {
    my ($client, $status) = @_;
    return 1 if PoPFlags_CanEdit($client, $status);

    $client->Message(13, "[PoP Staff Debug] GM status greater than $EDIT_STATUS is required for staff flag tools.")
        if $client;
    return 0;
}

sub PoPFlags_SetFlag {
    my ($client, $idx, $cat_id, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    my $flag = PoPFlags_FlagAt($idx);
    unless ($flag) {
        $client->Message(13, "Invalid PoP flag number.");
        PoPFlags_ShowDashboard($client, $status);
        return 1;
    }

    quest::setglobal($flag->{key}, $flag->{value}, 5, "F");
    my $values = PoPFlags_CurrentValues($client);
    $values->{$flag->{key}} = $flag->{value};
    PoPFlags_SyncZoneFlags($client, $values);

    $client->Message(10, "[PoP Flags] Set $flag->{key} = $flag->{value} for " . $client->GetCleanName() . ".");
    PoPFlags_ShowPlayerPopup($client, "next", undef, 1, $status);
    return 1;
}

sub PoPFlags_ClearFlag {
    my ($client, $idx, $cat_id, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    my $flag = PoPFlags_FlagAt($idx);
    unless ($flag) {
        $client->Message(13, "Invalid PoP flag number.");
        PoPFlags_ShowDashboard($client, $status);
        return 1;
    }

    quest::delglobal($flag->{key});
    PoPFlags_DeleteCharacterGlobal($client, $flag->{key});

    my $values = PoPFlags_CurrentValues($client);
    delete $values->{$flag->{key}};
    PoPFlags_SyncZoneFlags($client, $values);

    $client->Message(15, "[PoP Flags] Cleared $flag->{key} for " . $client->GetCleanName() . ".");
    PoPFlags_ShowPlayerPopup($client, "overview", undef, 1, $status);
    return 1;
}

sub PoPFlags_ShowDashboard {
    my ($client, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    my $values = PoPFlags_CurrentValues($client);
    my $summary = PoPFlags_Progress($values);
    my $guide = PoPFlags_GuideProgress($values);
    my @categories = PoPFlags_Categories();
    my $first_incomplete = PoPFlags_FirstIncompleteIndex($values);

    my @body;
    push @body, PoPFlags_Header("PoP Staff Dashboard");
    push @body, "<c \"#CCCCCC\">Character:</c> <c \"#FFFFFF\">" . PoPFlags_Html($client->GetCleanName()) . "</c>";
    push @body, PoPFlags_ProgressBar($guide->{complete}, $guide->{total})
        . " <c \"#CCFF99\">$guide->{complete}/$guide->{total}</c> guide steps";
    push @body, "<c \"#CCCCCC\">Debug qglobals set:</c> <c \"#CCFF99\">$summary->{complete}/$summary->{total}</c>"
        . "  <c \"#CCCCCC\">Missing:</c> $summary->{missing}"
        . "  <c \"#CCCCCC\">Needs repair:</c> <c \"#FFCC66\">$summary->{partial}</c>";

    push @body, PoPFlags_Section("Categories");
    for my $cat_id (1 .. scalar(@categories)) {
        my $category = $categories[$cat_id - 1];
        my $cat = PoPFlags_CategoryProgress($values, $category);
        my $state = $cat->{complete} == $cat->{total}
            ? "complete"
            : ($cat->{partial} ? "attention" : ($cat->{complete} ? "progress" : "missing"));
        push @body,
            PoPFlags_PopupStatus($state)
            . " <c \"#FFFFFF\">$cat_id. " . PoPFlags_Html($category) . "</c>"
            . " <c \"#CCCCCC\">$cat->{complete}/$cat->{total}</c>";
    }

    push @body, PoPFlags_Section("Staff Tools");
    push @body, "<c \"#CCCCCC\">Use the chat links below: open a category by number, jump to the first missing flag, browse the full qglobal list, or refresh zone access. Flag / Unflag links appear when you open a category or a flag.</c>";

    quest::popup("PoP Staff Dashboard", join("<br>", @body), 0, 0, 0);

    my @nav = (
        quest::saylink("#popflags", 1, "[Guide View]"),
        quest::saylink("#popflags page", 1, "[QGlobal List]"),
        quest::saylink("#popflags access", 1, "[Access]"),
    );
    push @nav, quest::saylink("#popflags debugmissing", 1, "[First Missing]") if defined $first_incomplete;
    $client->Message(15, "[PoP Staff] " . join(" ", @nav));

    my @cats;
    for my $cat_id (1 .. scalar(@categories)) {
        push @cats, quest::saylink("#popflags debugcat $cat_id", 1, "[$cat_id]");
    }
    $client->Message(15, "[PoP Categories] " . join(" ", @cats));
}

sub PoPFlags_ShowStep {
    my ($client, $idx, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    $idx = 0 if $idx < 0;
    $idx = scalar(@POP_FLAGS) - 1 if $idx >= scalar(@POP_FLAGS);

    my $values = PoPFlags_CurrentValues($client);
    my $flag = $POP_FLAGS[$idx];
    my $num = $idx + 1;
    my $total = scalar(@POP_FLAGS);
    my ($state, $detail) = PoPFlags_State($values, $flag);
    my $cat_id = PoPFlags_CategoryId($flag->{category});

    $client->Message(15, "----- PoP Flag $num / $total -----");
    $client->Message(15, "$flag->{category}: $flag->{label}");
    $client->Message(15, "$flag->{key} = $flag->{value}");
    $client->Message(PoPFlags_StateColor($state), "Status: " . PoPFlags_StateWord($state) . " ($detail)");

    my @actions;
    if ($state eq "complete") {
        push @actions, quest::saylink("#popflags clear $num", 1, "[Unflag]");
    } elsif ($state eq "partial") {
        push @actions, quest::saylink("#popflags set $num", 1, "[Set Expected]");
        push @actions, quest::saylink("#popflags clear $num", 1, "[Clear]");
    } else {
        push @actions, quest::saylink("#popflags set $num", 1, "[Flag]");
    }

    my $prev = $idx > 0 ? $idx : $total;
    my $next = $idx + 2 <= $total ? $idx + 2 : 1;
    push @actions, quest::saylink("#popflags debug $prev", 1, "[Prev]");
    push @actions, quest::saylink("#popflags debug $next", 1, "[Next]");
    push @actions, quest::saylink("#popflags debugmissing", 1, "[First Debug Missing]");
    push @actions, quest::saylink("#popflags debugcat $cat_id", 1, "[Category]");
    push @actions, quest::saylink("#popflags gm", 1, "[Staff Debug]");
    push @actions, quest::saylink("#popflags access", 1, "[Access]");

    $client->Message(15, join(" ", @actions));
}

sub PoPFlags_ShowCategory {
    my ($client, $cat_id, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    my @categories = PoPFlags_Categories();
    unless ($cat_id >= 1 && $cat_id <= scalar(@categories)) {
        $client->Message(13, "Invalid PoP flag category.");
        PoPFlags_ShowDashboard($client, $status);
        return;
    }

    my $category = $categories[$cat_id - 1];
    my $values = PoPFlags_CurrentValues($client);
    my @indexes = PoPFlags_CategoryIndexes($category);
    my $summary = PoPFlags_CategoryProgress($values, $category);

    $client->Message(15, "===== PoP Staff Debug: $category ($summary->{complete}/$summary->{total}) =====");
    for my $idx (@indexes) {
        my $flag = $POP_FLAGS[$idx];
        my ($state, $detail) = PoPFlags_State($values, $flag);
        my $num = $idx + 1;
        my $open = quest::saylink("#popflags debug $num", 1, "[$num]");
        my $toggle = ($state eq "complete")
            ? quest::saylink("#popflags clear $num cat $cat_id", 1, "[Unflag]")
            : quest::saylink("#popflags set $num cat $cat_id", 1, "[Flag]");
        my $status = PoPFlags_StateWord($state);
        $client->Message(
            PoPFlags_StateColor($state),
            "$open $status - $flag->{label} $toggle"
        );
    }

    my @nav = (
        quest::saylink("#popflags gm", 1, "[Staff Debug]"),
        quest::saylink("#popflags debugmissing", 1, "[First Debug Missing]"),
        quest::saylink("#popflags access", 1, "[Access]"),
    );
    $client->Message(15, join(" ", @nav));
}

sub PoPFlags_ShowList {
    my ($client, $page, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    my $total = scalar(@POP_FLAGS);
    my $pages = int(($total + $PAGE_SIZE - 1) / $PAGE_SIZE);
    $page = 1 if $page < 1;
    $page = $pages if $page > $pages;

    my $values = PoPFlags_CurrentValues($client);
    my $start = ($page - 1) * $PAGE_SIZE;
    my $end = $start + $PAGE_SIZE - 1;
    $end = $total - 1 if $end >= $total;

    $client->Message(15, "===== PoP Staff Debug QGlobal List $page / $pages =====");
    $client->Message(15, "This 57-qglobal list is for staff testing. The player guide uses 44 required progression steps.");
    for my $idx ($start .. $end) {
        my $flag = $POP_FLAGS[$idx];
        my ($state, $detail) = PoPFlags_State($values, $flag);
        my $num = $idx + 1;
        my $toggle = ($state eq "complete")
            ? quest::saylink("#popflags clear $num", 1, "[Unflag]")
            : quest::saylink("#popflags set $num", 1, "[Flag]");
        my $open = quest::saylink("#popflags debug $num", 1, "[$num]");
        $client->Message(
            PoPFlags_StateColor($state),
            "$open " . PoPFlags_StateWord($state) . " - $flag->{category}: $flag->{label} $toggle"
        );
    }

    my @nav;
    push @nav, quest::saylink("#popflags page " . ($page - 1), 1, "[Prev Page]") if $page > 1;
    push @nav, quest::saylink("#popflags page " . ($page + 1), 1, "[Next Page]") if $page < $pages;
    push @nav, quest::saylink("#popflags gm", 1, "[Staff Debug]");
    push @nav, quest::saylink("#popflags access", 1, "[Access]");
    $client->Message(15, join(" ", @nav));
}

sub PoPFlags_ShowAccess {
    my ($client, $values, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    $values ||= PoPFlags_CurrentValues($client);
    $client->Message(15, "=== PoP Zone Access ===");

    foreach my $rule (PoPFlags_AccessRules()) {
        my $qualifies = $rule->{check}->($values) ? 1 : 0;
        my $active = 1;
        foreach my $zone_id (@{$rule->{zones}}) {
            $active = 0 unless quest::has_zone_flag($zone_id);
        }

        my $state = $qualifies ? ($active ? "accessible" : "ready") : "locked";
        my $word = $qualifies ? ($active ? "Accessible" : "Ready") : "Not Ready";
        $client->Message($qualifies ? 10 : 15, "$word - $rule->{label}: " . PoPFlags_AccessHint($rule->{label}, $state));
    }

    $client->Message(15, quest::saylink("#popflags", 1, "[Guide Status]") . " " . quest::saylink("#popflags debugmissing", 1, "[First Debug Missing]"));
}

sub PoPFlags_ShowHelp {
    my ($client, $status) = @_;
    return 1 unless PoPFlags_RequireEdit($client, $status);

    $client->Message(15, "===== PoP Flags GM Tool Help =====");
    $client->Message(15, "Player guide = 44 required progression steps. Staff debug = 57 tracked qglobals.");
    $client->Message(15, "Status > $EDIT_STATUS can set and clear flags. Status <= $EDIT_STATUS gets the read-only popup guide.");
    $client->Message(15, "#popflags - dashboard by category");
    $client->Message(15, "#popflags plane <number> - browse one guide plane");
    $client->Message(15, "#popflags step <number> - inspect one guide step");
    $client->Message(15, "#popflags next - jump to the next guide step");
    $client->Message(15, "#popflags debugcat <number> - staff debug qglobal category");
    $client->Message(15, "#popflags debug <number> - staff debug qglobal detail");
    $client->Message(15, "#popflags access - resync and show derived zone access flags");
    $client->Message(15, "#popflags page <number> - old numbered page view");
}

sub PoPFlags_ShowPlayerPopup {
    my ($client, $view, $arg, $can_edit, $status) = @_;
    $view ||= "overview";
    my $actual_can_edit = PoPFlags_CanEdit($client, $status);
    $can_edit = defined $can_edit ? ($can_edit && $actual_can_edit) : $actual_can_edit;

    my $values = PoPFlags_CurrentValues($client);
    my ($title, $body);

    if ($view eq "tier") {
        ($title, $body) = PoPFlags_PlayerTierPopup($client, $values, $arg, $can_edit);
    } elsif ($view eq "plane" || $view eq "category") {
        ($title, $body) = PoPFlags_PlayerPlanePopup($client, $values, $arg, $can_edit);
    } elsif ($view eq "step" || $view eq "flag") {
        ($title, $body) = PoPFlags_PlayerStepPopup($client, $values, $arg, $can_edit);
    } elsif ($view eq "next") {
        ($title, $body) = PoPFlags_PlayerNextPopup($client, $values, $can_edit);
    } elsif ($view eq "access") {
        ($title, $body) = PoPFlags_PlayerAccessPopup($client, $values, $can_edit);
    } elsif ($view eq "help") {
        ($title, $body) = PoPFlags_PlayerHelpPopup($client, $values, $can_edit);
    } else {
        ($title, $body) = PoPFlags_PlayerOverviewPopup($client, $values, $can_edit);
    }

    quest::popup($title, $body, 0, 0, 0);
    PoPFlags_ShowPlayerChatMenu($client, $view, $arg, $can_edit, $values);
}

sub PoPFlags_PlayerOverviewPopup {
    my ($client, $values, $can_edit) = @_;
    my $summary = PoPFlags_GuideProgress($values);
    my ($qualified_access, $active_access, $total_access) = PoPFlags_AccessProgress($values);

    my @body;
    push @body, PoPFlags_Header("Planes of Power Progression");
    push @body, "<c \"#CCCCCC\">Character:</c> <c \"#FFFFFF\">" . PoPFlags_Html($client->GetCleanName()) . "</c>";
    my $remaining = $summary->{total} - $summary->{complete};
    push @body, PoPFlags_ProgressBar($summary->{complete}, $summary->{total})
        . " <c \"#CCFF99\">$summary->{complete}/$summary->{total}</c> guide steps complete";
    push @body, "<c \"#CCCCCC\">Remaining:</c> $remaining"
        . "  <c \"#CCCCCC\">Needs attention:</c> $summary->{partial}";
    push @body, "<c \"#CCCCCC\">Zone access:</c> <c \"#CCFF99\">$active_access/$total_access</c> accessible"
        . "  <c \"#CCCCCC\">Access-ready:</c> $qualified_access";

    my ($next_plane, $next_step, $next_num) = PoPFlags_FirstIncompleteGuideStep($values);
    if ($next_step) {
        push @body, PoPFlags_Section("What To Do Next");
        push @body,
            "<c \"#66CCFF\">" . PoPFlags_Html($next_plane->{plane}) . "</c>"
            . "<br><c \"#FFFFFF\">" . PoPFlags_Html($next_step->{label}) . "</c>"
            . "<br><c \"#CCCCCC\">" . PoPFlags_Html($next_step->{task}) . "</c>"
            . "<br>" . PoPFlags_PopupCommand("Open step details", "#popflags step $next_num");
    } else {
        push @body, "<br><c \"#66FF66\"><b>All tracked progression keys are complete.</b></c>";
    }

    push @body, PoPFlags_Section("Status By Tier And Plane");
    for my $tier (1 .. 4) {
        my $tier_summary = PoPFlags_GuideTierProgress($values, $tier);
        push @body, "<br><c \"#CCFF99\"><b>Tier $tier: " . PoPFlags_Html(PoPFlags_TierName($tier)) . "</b></c>"
            . " <c \"#CCCCCC\">$tier_summary->{complete}/$tier_summary->{total}</c>"
            . "<br>" . PoPFlags_PopupCommand("View Tier $tier", "#popflags tier $tier");

        foreach my $plane_ref (PoPFlags_GuidePlanesForTier($tier)) {
            my ($plane_id, $plane) = @{$plane_ref};
            my $plane_summary = PoPFlags_GuidePlaneProgress($values, $plane);
            my $state = PoPFlags_GuideProgressState($plane_summary);
            push @body,
                "&nbsp;&nbsp;"
                .
                PoPFlags_PopupStatus($state)
                . " "
                . "<c \"#FFFFFF\">" . PoPFlags_Html($plane->{plane}) . "</c>"
                . " - $plane_summary->{complete}/$plane_summary->{total}";
        }
    }

    push @body, PoPFlags_PlayerMenu("overview", $can_edit);
    return ("PoP Progression", join("<br>", @body));
}

sub PoPFlags_PlayerTierPopup {
    my ($client, $values, $tier, $can_edit) = @_;
    return PoPFlags_PlayerOverviewPopup($client, $values, $can_edit)
        unless defined $tier && $tier >= 1 && $tier <= 4;

    my $summary = PoPFlags_GuideTierProgress($values, $tier);

    my @body;
    push @body, PoPFlags_Header("Tier $tier: " . PoPFlags_TierName($tier));
    push @body, PoPFlags_ProgressBar($summary->{complete}, $summary->{total})
        . " <c \"#CCFF99\">$summary->{complete}/$summary->{total}</c> complete";

    foreach my $plane_ref (PoPFlags_GuidePlanesForTier($tier)) {
        my ($plane_id, $plane) = @{$plane_ref};
        my $plane_summary = PoPFlags_GuidePlaneProgress($values, $plane);
        my $state = PoPFlags_GuideProgressState($plane_summary);
        push @body,
            PoPFlags_PopupStatus($state)
            . " "
            . "<c \"#FFFFFF\"><b>" . PoPFlags_Html($plane->{plane}) . "</b></c>"
            . " - $plane_summary->{complete}/$plane_summary->{total}"
            . "<br><c \"#CCCCCC\">" . PoPFlags_Html($plane->{summary}) . "</c>"
            . "<br>" . PoPFlags_PopupCommand("View this plane", "#popflags plane $plane_id");
    }

    push @body, PoPFlags_PlayerMenu("tier", $can_edit);
    return ("PoP Tier $tier", join("<br>", @body));
}

sub PoPFlags_PlayerPlanePopup {
    my ($client, $values, $plane_id, $can_edit) = @_;
    my $plane = PoPFlags_GuidePlaneAt($plane_id);
    return PoPFlags_PlayerOverviewPopup($client, $values, $can_edit) unless $plane;

    my $summary = PoPFlags_GuidePlaneProgress($values, $plane);
    my $state = PoPFlags_GuideProgressState($summary);

    my @body;
    push @body, PoPFlags_Header($plane->{plane});
    push @body, "<c \"#CCCCCC\">Tier $plane->{tier}:</c> " . PoPFlags_Html(PoPFlags_TierName($plane->{tier}));
    push @body, "Progress: " . PoPFlags_PopupStatus($state) . " "
        . PoPFlags_ProgressBar($summary->{complete}, $summary->{total})
        . " $summary->{complete}/$summary->{total}";
    push @body, PoPFlags_Html($plane->{summary});

    if ($plane->{notes}) {
        foreach my $note (@{$plane->{notes}}) {
            push @body, "<c \"#CCCCCC\">" . PoPFlags_Html($note) . "</c>";
        }
    }

    push @body, PoPFlags_Section("Required Steps");
    for my $step_idx (0 .. $#{$plane->{steps}}) {
        my $step = $plane->{steps}[$step_idx];
        my ($step_state, $detail) = PoPFlags_GuideStepState($values, $step);
        my $step_num = PoPFlags_GuideStepNumber($plane_id, $step_idx + 1);
        push @body,
            PoPFlags_PopupStatus($step_state)
            . " "
            . "<c \"#FFFFFF\">" . PoPFlags_Html($step->{label}) . "</c>"
            . ($step_state eq "partial" ? " <c \"#FFCC66\">(" . PoPFlags_Html($detail) . ")</c>" : "")
            . "<br>&nbsp;&nbsp;<c \"#CCCCCC\">" . PoPFlags_Html($step->{task}) . "</c>"
            . "<br>&nbsp;&nbsp;" . PoPFlags_PopupCommand("Open step", "#popflags step $step_num")
            . PoPFlags_StaffStepActions($step_state, $step, $can_edit);
    }

    if ($plane->{optional}) {
        push @body, PoPFlags_Section("Optional / Helpful");
        foreach my $step (@{$plane->{optional}}) {
            my ($step_state, $detail) = PoPFlags_GuideStepState($values, $step);
            push @body,
                PoPFlags_PopupStatus($step_state)
                . " "
                . "<c \"#FFFFFF\">" . PoPFlags_Html($step->{label}) . "</c>"
                . "<br>&nbsp;&nbsp;<c \"#CCCCCC\">" . PoPFlags_Html($step->{task}) . "</c>"
                . PoPFlags_StaffStepActions($step_state, $step, $can_edit);
        }
    }

    push @body, PoPFlags_PlayerMenu("plane", $can_edit);
    return ("PoP: $plane->{plane}", join("<br>", @body));
}

sub PoPFlags_PlayerStepPopup {
    my ($client, $values, $step_num, $can_edit) = @_;
    my ($plane, $step, $plane_id, $step_idx, $total_steps) = PoPFlags_GuideStepAt($step_num);
    return PoPFlags_PlayerOverviewPopup($client, $values, $can_edit) unless $step;

    my ($state, $detail) = PoPFlags_GuideStepState($values, $step);
    my $prev = $step_num > 1 ? $step_num - 1 : $total_steps;
    my $next = $step_num < $total_steps ? $step_num + 1 : 1;

    my @body;
    push @body, PoPFlags_Header("What To Do");
    push @body, "<c \"#FFFFFF\"><b>" . PoPFlags_Html($step->{label}) . "</b></c>";
    push @body, "<c \"#CCCCCC\">Tier $plane->{tier}:</c> " . PoPFlags_Html($plane->{plane});
    push @body, "Status: " . PoPFlags_PopupStatus($state) . " " . PoPFlags_Html($detail);
    push @body, PoPFlags_Section("Task") . PoPFlags_Html($step->{task});
    push @body, PoPFlags_Section("Why It Matters") . PoPFlags_Html($step->{result});
    push @body, PoPFlags_StaffStepDetails($step, $state, $can_edit);
    push @body,
        PoPFlags_Section("Step Navigation")
        . PoPFlags_PopupCommand("Previous step", "#popflags step $prev")
        . "<br>"
        . PoPFlags_PopupCommand("Next step", "#popflags step $next")
        . "<br>"
        . PoPFlags_PopupCommand("Plane overview", "#popflags plane $plane_id");
    push @body, PoPFlags_PlayerMenu("step", $can_edit);

    return ("PoP Progression Step", join("<br>", @body));
}

sub PoPFlags_PlayerNextPopup {
    my ($client, $values, $can_edit) = @_;
    my ($plane, $step, $step_num) = PoPFlags_FirstIncompleteGuideStep($values);

    unless ($step) {
        my @body;
        push @body, PoPFlags_Header("What's Next");
        push @body, "<c \"#66FF66\"><b>All tracked PoP guide steps are complete.</b></c>";
        push @body, "Use the Access view if a zone stone still rejects you.";
        push @body, PoPFlags_PlayerMenu("next", $can_edit);
        return ("PoP: What's Next", join("<br>", @body));
    }

    my ($state, $detail) = PoPFlags_GuideStepState($values, $step);
    my @body;
    push @body, PoPFlags_Header("Your Next Suggested Step");
    push @body, "<c \"#CCCCCC\">Plane:</c> <c \"#66CCFF\">" . PoPFlags_Html($plane->{plane}) . "</c>";
    push @body, "<c \"#CCCCCC\">Step:</c> <c \"#FFFFFF\">" . PoPFlags_Html($step->{label}) . "</c>";
    push @body, "Status: " . PoPFlags_PopupStatus($state) . " " . PoPFlags_Html($detail);
    push @body, PoPFlags_Section("Do This Now") . PoPFlags_Html($step->{task});
    push @body, PoPFlags_Section("Result") . PoPFlags_Html($step->{result});
    push @body, PoPFlags_PopupCommand("Open step details", "#popflags step $step_num")
        . "<br>"
        . PoPFlags_PopupCommand("Back to status", "#popflags");
    push @body, PoPFlags_PlayerMenu("next", $can_edit);

    return ("PoP: What's Next", join("<br>", @body));
}

sub PoPFlags_PlayerAccessPopup {
    my ($client, $values, $can_edit) = @_;

    my @body;
    push @body, PoPFlags_Header("PoP Zone Access");
    push @body, "This translates your progression into plain zone access language.";
    push @body, "Accessible means you should be able to enter. Ready means your progression looks complete, but your character's zone access has not refreshed yet.";
    push @body, PoPFlags_PopupCommand("GM: refresh access", "#popflags syncaccess") if $can_edit;

    foreach my $rule (PoPFlags_AccessRules()) {
        my $qualifies = $rule->{check}->($values) ? 1 : 0;
        my $active = 1;
        foreach my $zone_id (@{$rule->{zones}}) {
            $active = 0 unless quest::has_zone_flag($zone_id);
        }

        my $state = $qualifies ? ($active ? "accessible" : "ready") : "locked";
        my $word = $qualifies ? ($active ? "Accessible" : "Ready") : "Not Ready";
        push @body,
            PoPFlags_PopupStatus($state, $word)
            . " "
            . PoPFlags_Html($rule->{label})
            . "<br><c \"#CCCCCC\">" . PoPFlags_Html(PoPFlags_AccessHint($rule->{label}, $state)) . "</c>";
    }

    push @body, PoPFlags_PlayerMenu("access", $can_edit);
    return ("PoP Zone Access", join("<br>", @body));
}

sub PoPFlags_PlayerHelpPopup {
    my ($client, $values, $can_edit) = @_;

    my @body;
    push @body, PoPFlags_Header("How To Use PoP Progression");
    push @body, "The first page shows your status by tier and by plane.";
    push @body, "Use What's Next when you just want the next concrete action in the EQProgression-style route.";
    push @body, "Use Tier views to see the full path for a phase of progression, or Plane views to see each required step.";
    push @body, "Use Access to translate flags into player-facing zone access status.";
    push @body, "<br><b>Status Words</b>";
    push @body, PoPFlags_PopupStatus("complete") . " all required steps in that section are done.";
    push @body, PoPFlags_PopupStatus("progress") . " at least one step is done, but more remain.";
    push @body, PoPFlags_PopupStatus("missing") . " none of the required steps are complete yet.";
    push @body, PoPFlags_PopupStatus("attention") . " a key exists but has an unexpected value; staff may need to repair it.";
    if ($can_edit) {
        push @body, "<br><b>Staff Mode</b>";
        push @body, "Your status is above $EDIT_STATUS, so guide detail pages include Flag, Unflag, or Repair links.";
        push @body, "Use " . PoPFlags_PopupCommand("Staff debug", "#popflags gm") . " for the 57-qglobal debug list. It includes the 44 guide steps plus optional keys, Justice trial markers, backflags, and helper flags.";
    } else {
        push @body, "<br><c \"#CCCCCC\">This is a read-only guide. It does not grant progression flags.</c>";
    }

    push @body, PoPFlags_PlayerMenu("help", $can_edit);
    return ("PoP Progression Help", join("<br>", @body));
}

sub PoPFlags_PlayerMenu {
    my ($current, $can_edit) = @_;
    my @links = (
        PoPFlags_PopupCommand("Status", "#popflags"),
        PoPFlags_PopupCommand("What's Next", "#popflags next"),
        PoPFlags_PopupCommand("Tier 1", "#popflags tier 1"),
        PoPFlags_PopupCommand("Tier 2", "#popflags tier 2"),
        PoPFlags_PopupCommand("Tier 3", "#popflags tier 3"),
        PoPFlags_PopupCommand("Tier 4", "#popflags tier 4"),
        PoPFlags_PopupCommand("Access", "#popflags access"),
        PoPFlags_PopupCommand("Help", "#popflags help"),
    );
    push @links, PoPFlags_PopupCommand("Staff Debug", "#popflags gm") if $can_edit;
    return PoPFlags_Section("Menu - Type A Command")
        . join("<br>", @links)
        . "<br><c \"#7F8A93\">Tip: these same options are clickable as blue links in your chat window.</c>";
}

sub PoPFlags_ShowPlayerChatMenu {
    my ($client, $view, $arg, $can_edit, $values) = @_;
    return unless $client;

    my @main = (
        quest::saylink("#popflags", 1, "[Status]"),
        quest::saylink("#popflags next", 1, "[What's Next]"),
        quest::saylink("#popflags tier 1", 1, "[Tier 1]"),
        quest::saylink("#popflags tier 2", 1, "[Tier 2]"),
        quest::saylink("#popflags tier 3", 1, "[Tier 3]"),
        quest::saylink("#popflags tier 4", 1, "[Tier 4]"),
        quest::saylink("#popflags access", 1, "[Access]"),
        quest::saylink("#popflags help", 1, "[Help]"),
    );
    push @main, quest::saylink("#popflags gm", 1, "[Staff Debug]") if $can_edit;
    $client->Message(15, "[PoP Guide] " . join(" ", @main));

    if (($view || "") eq "step" && defined $arg) {
        my ($plane, $step, $plane_id, $step_idx, $total_steps) = PoPFlags_GuideStepAt($arg);
        if ($step) {
            my $prev = $arg > 1 ? $arg - 1 : $total_steps;
            my $next = $arg < $total_steps ? $arg + 1 : 1;
            my @links = (
                quest::saylink("#popflags step $prev", 1, "[Previous Step]"),
                quest::saylink("#popflags step $next", 1, "[Next Step]"),
                quest::saylink("#popflags plane $plane_id", 1, "[Plane Overview]"),
            );
            push @links, PoPFlags_StaffChatActions($step, $values, $can_edit);
            $client->Message(15, "[PoP Step] " . join(" ", grep { $_ ne "" } @links));
        }
    } elsif ((($view || "") eq "plane" || ($view || "") eq "category") && defined $arg) {
        my $plane = PoPFlags_GuidePlaneAt($arg);
        if ($plane) {
            my @links;
            for my $step_idx (0 .. $#{$plane->{steps}}) {
                my $step_num = PoPFlags_GuideStepNumber($arg, $step_idx + 1);
                push @links, quest::saylink("#popflags step $step_num", 1, "[" . ($step_idx + 1) . "]");
            }
            $client->Message(15, "[PoP Plane Steps] " . join(" ", @links)) if @links;
        }
    } elsif (($view || "") eq "tier" && defined $arg) {
        my @links;
        foreach my $plane_ref (PoPFlags_GuidePlanesForTier(int($arg))) {
            my ($plane_id, $plane) = @{$plane_ref};
            push @links, quest::saylink("#popflags plane $plane_id", 1, "[" . $plane->{plane} . "]");
        }
        $client->Message(15, "[PoP Planes] " . join(" ", @links)) if @links;
    } elsif (($view || "") eq "access" && $can_edit) {
        $client->Message(15, "[PoP Staff] " . quest::saylink("#popflags syncaccess", 1, "[Refresh Access]"));
    }
}

sub PoPFlags_StaffChatActions {
    my ($step, $values, $can_edit) = @_;
    return "" unless $can_edit && $step && $step->{key};

    my $flag_num = PoPFlags_FlagNumber($step->{key});
    return "" unless $flag_num;

    my ($state) = PoPFlags_GuideStepState($values, $step);
    return quest::saylink("#popflags clear $flag_num", 1, "[Unflag]") if $state eq "complete";
    return quest::saylink("#popflags set $flag_num", 1, "[Repair]")
        . " " . quest::saylink("#popflags clear $flag_num", 1, "[Clear]")
        if $state eq "partial";
    return quest::saylink("#popflags set $flag_num", 1, "[Flag]");
}

sub PoPFlags_Header {
    my ($text) = @_;
    return "<c \"#F2C14E\"><b>" . PoPFlags_Html($text) . "</b></c>"
        . "<br><c \"#3A3A3A\">. . . . . . . . . . . . . . . . . . . . . .</c>";
}

sub PoPFlags_Section {
    my ($text) = @_;
    return "<br><br><c \"#8A6D1F\">--</c> <c \"#F2C14E\"><b>" . PoPFlags_Html($text) . "</b></c><br>";
}

sub PoPFlags_PopupCommand {
    my ($label, $command) = @_;
    # Popup text is not clickable, so always show the exact command to type.
    # Label in soft blue, command in warm gold so it stands out as the thing to type.
    return "<c \"#8FC4FF\">" . PoPFlags_Html($label) . "</c>"
        . " <c \"#5A5A5A\">-</c> "
        . "<c \"#F0C674\">" . PoPFlags_Html($command) . "</c>";
}

sub PoPFlags_ProgressBar {
    my ($complete, $total) = @_;
    $complete ||= 0;
    $total ||= 0;

    my $width = 16;
    my $pct = $total > 0 ? int(($complete / $total) * 100 + 0.5) : 0;
    my $filled = $total > 0 ? int(($complete / $total) * $width + 0.5) : 0;
    $filled = 0 if $filled < 0;
    $filled = $width if $filled > $width;

    my $done = "=" x $filled;
    my $open = "-" x ($width - $filled);
    return "<c \"#6E7681\">[</c><c \"#6FCF73\">$done</c><c \"#454C45\">$open</c><c \"#6E7681\">]</c> <c \"#F2C14E\">${pct}%</c>";
}

sub PoPFlags_PopupStatus {
    my ($state, $label) = @_;
    $label ||= PoPFlags_PlayerStatusWord($state);

    my $color = "#F5F5F5";
    $color = "#6FCF73" if $state eq "complete" || $state eq "accessible";
    $color = "#5AA9F0" if $state eq "progress" || $state eq "ready";
    $color = "#F0B24B" if $state eq "partial" || $state eq "attention";
    $color = "#8A9199" if $state eq "locked" || $state eq "missing";

    return "<c \"$color\">[$label]</c>";
}

sub PoPFlags_PlayerStatusWord {
    my ($state) = @_;
    return "Complete" if $state eq "complete";
    return "Accessible" if $state eq "accessible";
    return "Ready" if $state eq "ready";
    return "In Progress" if $state eq "progress";
    return "Needs Attention" if $state eq "attention" || $state eq "partial";
    return "Not Ready" if $state eq "locked";
    return "Not Started";
}

sub PoPFlags_GuideProgress {
    my ($values) = @_;
    my %summary = (total => 0, complete => 0, progress => 0, partial => 0, missing => 0);

    foreach my $plane (@POP_GUIDE_PLANES) {
        my $plane_summary = PoPFlags_GuidePlaneProgress($values, $plane);
        $summary{total} += $plane_summary->{total};
        $summary{complete} += $plane_summary->{complete};
        $summary{partial} += $plane_summary->{partial};
        $summary{missing} += $plane_summary->{missing};
    }

    $summary{progress} = $summary{total} - $summary{complete} - $summary{missing} - $summary{partial};
    $summary{progress} = 0 if $summary{progress} < 0;
    return \%summary;
}

sub PoPFlags_GuideTierProgress {
    my ($values, $tier) = @_;
    my %summary = (total => 0, complete => 0, progress => 0, partial => 0, missing => 0);

    foreach my $plane_ref (PoPFlags_GuidePlanesForTier($tier)) {
        my ($plane_id, $plane) = @{$plane_ref};
        my $plane_summary = PoPFlags_GuidePlaneProgress($values, $plane);
        $summary{total} += $plane_summary->{total};
        $summary{complete} += $plane_summary->{complete};
        $summary{partial} += $plane_summary->{partial};
        $summary{missing} += $plane_summary->{missing};
    }

    $summary{progress} = $summary{total} - $summary{complete} - $summary{missing} - $summary{partial};
    $summary{progress} = 0 if $summary{progress} < 0;
    return \%summary;
}

sub PoPFlags_GuidePlaneProgress {
    my ($values, $plane) = @_;
    my %summary = (total => 0, complete => 0, partial => 0, missing => 0);

    foreach my $step (@{$plane->{steps}}) {
        my ($state) = PoPFlags_GuideStepState($values, $step);
        $summary{total}++;
        $summary{$state}++ if exists $summary{$state};
    }

    return \%summary;
}

sub PoPFlags_GuideProgressState {
    my ($summary) = @_;
    return "complete" if $summary->{total} > 0 && $summary->{complete} == $summary->{total};
    return "attention" if $summary->{partial};
    return "progress" if $summary->{complete};
    return "missing";
}

sub PoPFlags_GuideStepState {
    my ($values, $step) = @_;
    return ("missing", "not tracked") unless $step->{key};
    my $flag = {
        key   => $step->{key},
        value => defined $step->{value} ? $step->{value} : "1",
    };
    return PoPFlags_State($values, $flag);
}

sub PoPFlags_FirstIncompleteGuideStep {
    my ($values) = @_;
    my $step_num = 0;

    foreach my $plane (@POP_GUIDE_PLANES) {
        foreach my $step (@{$plane->{steps}}) {
            $step_num++;
            my ($state) = PoPFlags_GuideStepState($values, $step);
            return ($plane, $step, $step_num) if $state ne "complete";
        }
    }

    return (undef, undef, undef);
}

sub PoPFlags_GuideStepAt {
    my ($wanted) = @_;
    $wanted = int($wanted || 0);
    my $total = PoPFlags_GuideStepTotal();
    return (undef, undef, undef, undef, $total) if $wanted < 1 || $wanted > $total;

    my $step_num = 0;
    for my $plane_idx (0 .. $#POP_GUIDE_PLANES) {
        my $plane = $POP_GUIDE_PLANES[$plane_idx];
        for my $step_idx (0 .. $#{$plane->{steps}}) {
            $step_num++;
            if ($step_num == $wanted) {
                return ($plane, $plane->{steps}[$step_idx], $plane_idx + 1, $step_idx + 1, $total);
            }
        }
    }

    return (undef, undef, undef, undef, $total);
}

sub PoPFlags_GuideStepNumber {
    my ($plane_id, $step_id) = @_;
    my $wanted_plane = int($plane_id || 0);
    my $wanted_step = int($step_id || 0);
    my $step_num = 0;

    for my $plane_idx (0 .. $#POP_GUIDE_PLANES) {
        my $plane = $POP_GUIDE_PLANES[$plane_idx];
        for my $step_idx (0 .. $#{$plane->{steps}}) {
            $step_num++;
            return $step_num if ($plane_idx + 1) == $wanted_plane && ($step_idx + 1) == $wanted_step;
        }
    }

    return 1;
}

sub PoPFlags_GuideStepTotal {
    my $total = 0;
    foreach my $plane (@POP_GUIDE_PLANES) {
        $total += scalar(@{$plane->{steps}});
    }
    return $total;
}

sub PoPFlags_GuidePlaneAt {
    my ($plane_id) = @_;
    $plane_id = int($plane_id || 0);
    return undef if $plane_id < 1 || $plane_id > scalar(@POP_GUIDE_PLANES);
    return $POP_GUIDE_PLANES[$plane_id - 1];
}

sub PoPFlags_GuidePlanesForTier {
    my ($tier) = @_;
    my @planes;

    for my $idx (0 .. $#POP_GUIDE_PLANES) {
        my $plane = $POP_GUIDE_PLANES[$idx];
        push @planes, [$idx + 1, $plane] if $plane->{tier} == $tier;
    }

    return @planes;
}

sub PoPFlags_TierName {
    my ($tier) = @_;
    return "Foundation Planes" if $tier == 1;
    return "Branch Access" if $tier == 2;
    return "Raid Progression" if $tier == 3;
    return "Sol Ro, Elementals, and Time";
}

sub PoPFlags_StaffStepActions {
    my ($state, $step, $can_edit) = @_;
    return "" unless $can_edit && $step->{key};

    my $flag_num = PoPFlags_FlagNumber($step->{key});
    return "" unless $flag_num;

    if ($state eq "complete") {
        return "<br>&nbsp;&nbsp;" . PoPFlags_PopupCommand("Staff: unflag", "#popflags clear $flag_num");
    }
    if ($state eq "partial") {
        return "<br>&nbsp;&nbsp;"
            . PoPFlags_PopupCommand("Staff: repair", "#popflags set $flag_num")
            . "<br>&nbsp;&nbsp;"
            . PoPFlags_PopupCommand("Staff: clear", "#popflags clear $flag_num");
    }
    return "<br>&nbsp;&nbsp;" . PoPFlags_PopupCommand("Staff: flag", "#popflags set $flag_num");
}

sub PoPFlags_StaffStepDetails {
    my ($step, $state, $can_edit) = @_;
    return "" unless $can_edit;

    my $flag_num = PoPFlags_FlagNumber($step->{key});
    return "" unless $flag_num;

    my $expected = defined $step->{value} ? $step->{value} : "1";
    return "<br><b>Staff</b><br>"
        . "QGlobal: " . PoPFlags_Html($step->{key})
        . " expected=" . PoPFlags_Html($expected)
        . "<br>"
        . PoPFlags_StaffStepActions($state, $step, $can_edit);
}

sub PoPFlags_FlagNumber {
    my ($key) = @_;
    return undef unless $key;

    for my $idx (0 .. $#POP_FLAGS) {
        return $idx + 1 if $POP_FLAGS[$idx]{key} eq $key;
    }

    return undef;
}

sub PoPFlags_AccessHint {
    my ($label, $state) = @_;

    return "Your progression is complete for this access. If the zone still refuses entry, try zoning or ask staff to refresh your access."
        if $state eq "ready";
    return "You should be able to enter this destination now."
        if $state eq "accessible";

    return "Complete the Nightmare hedge line to reach Terris Thule."
        if $label eq "Lair of Terris Thule";
    return "Complete the Plane of Disease line or receive the Crypt of Decay backflag."
        if $label eq "Crypt of Decay";
    return "Finish Mavuin, a Justice trial, and the Mavuin follow-up."
        if $label eq "Plane of Valor / Plane of Storms";
    return "Finish Disease, Nightmare, and Crypt of Decay, or receive the Torment backflag."
        if $label eq "Plane of Torment";
    return "Finish Justice progression and Askr the Lost's Plane of Storms quest."
        if $label eq "Bastion of Thunder";
    return "Finish Justice progression and Aerin'Dar, or receive the Halls of Honor backflag."
        if $label eq "Halls of Honor";
    return "Finish Justice, Aerin'Dar, and the three Halls of Honor trials."
        if $label eq "Temple of Marr";
    return "On this server, finish the Manaetic Behemoth line or receive the Tactics backflag."
        if $label eq "Plane of Tactics";
    return "Finish Behemoth, Tallon, Vallon, Saryrn, and Mithaniel Marr, or receive the Sol Ro Tower backflag."
        if $label eq "Tower of Solusek Ro";
    return "Finish Behemoth, Tactics, Solusek Ro, Saryrn, and Mithaniel Marr."
        if $label eq "Plane of Fire";
    return "Finish the pre-elemental path and Grand Librarian checkpoint."
        if $label eq "Elemental planes";
    return "Finish the Plane of Earth A / Arbitor projection step."
        if $label eq "Plane of Earth B";
    return "Finish the Elemental victories and Maelin's final Plane of Time sequence."
        if $label eq "Plane of Time";

    return "Continue the guided progression path.";
}

sub PoPFlags_AccessProgress {
    my ($values) = @_;
    my ($qualified, $active, $total) = (0, 0, 0);

    foreach my $rule (PoPFlags_AccessRules()) {
        $total++;
        my $qualifies = $rule->{check}->($values) ? 1 : 0;
        $qualified++ if $qualifies;
        next unless $qualifies;

        my $has_all_zone_flags = 1;
        foreach my $zone_id (@{$rule->{zones}}) {
            $has_all_zone_flags = 0 unless quest::has_zone_flag($zone_id);
        }
        $active++ if $has_all_zone_flags;
    }

    return ($qualified, $active, $total);
}

sub PoPFlags_Html {
    my ($text) = @_;
    $text = "" unless defined $text;
    $text =~ s/&/&amp;/g;
    $text =~ s/</&lt;/g;
    $text =~ s/>/&gt;/g;
    $text =~ s/"/&quot;/g;
    return $text;
}

sub PoPFlags_Progress {
    my ($values) = @_;
    my %summary = (total => scalar(@POP_FLAGS), complete => 0, partial => 0, missing => 0);

    foreach my $flag (@POP_FLAGS) {
        my ($state) = PoPFlags_State($values, $flag);
        $summary{$state}++ if exists $summary{$state};
    }

    return \%summary;
}

sub PoPFlags_CategoryProgress {
    my ($values, $category) = @_;
    my %summary = (total => 0, complete => 0, partial => 0, missing => 0);

    foreach my $idx (PoPFlags_CategoryIndexes($category)) {
        my ($state) = PoPFlags_State($values, $POP_FLAGS[$idx]);
        $summary{total}++;
        $summary{$state}++ if exists $summary{$state};
    }

    return \%summary;
}

sub PoPFlags_FirstIncompleteIndex {
    my ($values) = @_;

    for my $idx (0 .. $#POP_FLAGS) {
        my ($state) = PoPFlags_State($values, $POP_FLAGS[$idx]);
        return $idx if $state ne "complete";
    }

    return undef;
}

sub PoPFlags_Categories {
    my @categories;
    my %seen;

    foreach my $flag (@POP_FLAGS) {
        next if $seen{$flag->{category}}++;
        push @categories, $flag->{category};
    }

    return @categories;
}

sub PoPFlags_CategoryId {
    my ($category) = @_;
    my @categories = PoPFlags_Categories();

    for my $idx (0 .. $#categories) {
        return $idx + 1 if $categories[$idx] eq $category;
    }

    return 1;
}

sub PoPFlags_CategoryIndexes {
    my ($category) = @_;
    my @indexes;

    for my $idx (0 .. $#POP_FLAGS) {
        push @indexes, $idx if $POP_FLAGS[$idx]{category} eq $category;
    }

    return @indexes;
}

sub PoPFlags_StateWord {
    my ($state) = @_;
    return "OK" if $state eq "complete";
    return "Repair" if $state eq "partial";
    return "Missing";
}

sub PoPFlags_CurrentValues {
    my ($client) = @_;
    my %values;
    return \%values unless $client;

    my @names = map { $_->{key} } @POP_FLAGS;
    my $dbh = plugin::LoadMysql();
    if ($dbh) {
        my $placeholders = join(",", map { "?" } @names);
        my $sth = $dbh->prepare(
            "SELECT name, value FROM quest_globals WHERE charid = ? AND npcid = 0 AND name IN ($placeholders)"
        );
        $sth->execute($client->CharacterID(), @names);
        while (my $row = $sth->fetchrow_hashref()) {
            $values{$row->{name}} = $row->{value};
        }
        $sth->finish();
        $dbh->disconnect();
        return \%values;
    }

    my $qglobals = plugin::var('qglobals');
    if ($qglobals) {
        foreach my $name (@names) {
            $values{$name} = $qglobals->{$name} if defined $qglobals->{$name};
        }
    }

    return \%values;
}

sub PoPFlags_DeleteCharacterGlobal {
    my ($client, $key) = @_;
    my $dbh = plugin::LoadMysql();
    return unless $dbh;

    my $sth = $dbh->prepare("DELETE FROM quest_globals WHERE charid = ? AND name = ?");
    $sth->execute($client->CharacterID(), $key);
    $sth->finish();
    $dbh->disconnect();
}

sub PoPFlags_SyncZoneFlags {
    my ($client, $values) = @_;
    return unless $client;
    $values ||= PoPFlags_CurrentValues($client);

    foreach my $rule (PoPFlags_AccessRules()) {
        my $enabled = $rule->{check}->($values) ? 1 : 0;
        foreach my $zone_id (@{$rule->{zones}}) {
            if ($enabled) {
                quest::set_zone_flag($zone_id) unless quest::has_zone_flag($zone_id);
            } else {
                quest::clear_zone_flag($zone_id) if quest::has_zone_flag($zone_id);
            }
        }
    }
}

sub PoPFlags_AccessRules {
    return (
        { label => "Lair of Terris Thule", zones => [221], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_pon_construct") && PoPFlags_Has($v, "pop_pon_hedge_jezith");
        }},
        { label => "Crypt of Decay", zones => [200], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_alt_access_codecay")
                || (PoPFlags_Has($v, "pop_pod_alder_fuirstel")
                    && PoPFlags_Has($v, "pop_pod_grimmus_planar_projection")
                    && PoPFlags_Has($v, "pop_pod_elder_fuirstel"));
        }},
        { label => "Plane of Valor / Plane of Storms", zones => [208, 210], check => sub {
            my ($v) = @_;
            return PoPFlags_PoJComplete($v);
        }},
        { label => "Plane of Torment", zones => [207], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_alt_access_potorment")
                || (PoPFlags_DiseaseComplete($v)
                    && PoPFlags_NightmareComplete($v)
                    && PoPFlags_CoDComplete($v));
        }},
        { label => "Bastion of Thunder", zones => [209], check => sub {
            my ($v) = @_;
            return PoPFlags_PoJComplete($v)
                && PoPFlags_Has($v, "pop_pos_askr_the_lost", "3")
                && PoPFlags_Has($v, "pop_pos_askr_the_lost_final");
        }},
        { label => "Halls of Honor", zones => [211], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_alt_access_hohonora")
                || (PoPFlags_PoJComplete($v) && PoPFlags_Has($v, "pop_pov_aerin_dar"));
        }},
        { label => "Temple of Marr", zones => [220], check => sub {
            my ($v) = @_;
            return PoPFlags_PoJComplete($v)
                && PoPFlags_Has($v, "pop_pov_aerin_dar")
                && PoPFlags_HoHTrialsComplete($v);
        }},
        { label => "Plane of Tactics", zones => [214], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_alt_access_potactics")
                || (PoPFlags_Has($v, "pop_poi_behometh_preflag")
                    && PoPFlags_Has($v, "pop_poi_behometh_flag"));
        }},
        { label => "Tower of Solusek Ro", zones => [212], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_alt_access_solrotower")
                || (PoPFlags_Has($v, "pop_poi_behometh_preflag")
                    && PoPFlags_Has($v, "pop_poi_behometh_flag")
                    && PoPFlags_Has($v, "pop_tactics_tallon")
                    && PoPFlags_Has($v, "pop_tactics_vallon")
                    && PoPFlags_Has($v, "pop_pot_saryrn")
                    && PoPFlags_Has($v, "pop_pot_saryrn_final")
                    && PoPFlags_Has($v, "pop_hohb_marr"));
        }},
        { label => "Plane of Fire", zones => [217], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_poi_behometh_preflag")
                && PoPFlags_Has($v, "pop_poi_behometh_flag")
                && PoPFlags_TacticsComplete($v)
                && PoPFlags_SolRoComplete($v)
                && PoPFlags_Has($v, "pop_pot_saryrn")
                && PoPFlags_Has($v, "pop_pot_saryrn_final")
                && PoPFlags_Has($v, "pop_hohb_marr");
        }},
        { label => "Elemental planes", zones => [215, 216, 218], check => sub {
            my ($v) = @_;
            return PoPFlags_ElementalPreflagComplete($v);
        }},
        { label => "Plane of Earth B", zones => [222], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_eartha_arbitor_projection");
        }},
        { label => "Plane of Time", zones => [219, 223], check => sub {
            my ($v) = @_;
            return PoPFlags_Has($v, "pop_time_maelin");
        }},
    );
}

sub PoPFlags_DiseaseComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_pod_alder_fuirstel")
        && PoPFlags_Has($v, "pop_pod_grimmus_planar_projection")
        && PoPFlags_Has($v, "pop_pod_elder_fuirstel");
}

sub PoPFlags_PoJComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_poj_mavuin")
        && PoPFlags_Has($v, "pop_poj_tribunal")
        && PoPFlags_Has($v, "pop_poj_valor_storms");
}

sub PoPFlags_NightmareComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_pon_hedge_jezith")
        && PoPFlags_Has($v, "pop_pon_construct")
        && PoPFlags_Has($v, "pop_ponb_terris")
        && PoPFlags_Has($v, "pop_ponb_poxbourne");
}

sub PoPFlags_CoDComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_cod_preflag")
        && PoPFlags_Has($v, "pop_cod_bertox")
        && PoPFlags_Has($v, "pop_cod_final");
}

sub PoPFlags_HoHTrialsComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_hoh_faye")
        && PoPFlags_Has($v, "pop_hoh_trell")
        && PoPFlags_Has($v, "pop_hoh_garn");
}

sub PoPFlags_TacticsComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_tactics_tallon")
        && PoPFlags_Has($v, "pop_tactics_vallon")
        && PoPFlags_Has($v, "pop_tactics_ralloz");
}

sub PoPFlags_SolRoComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_sol_ro_arlyxir")
        && PoPFlags_Has($v, "pop_sol_ro_dresolik")
        && PoPFlags_Has($v, "pop_sol_ro_jiva")
        && PoPFlags_Has($v, "pop_sol_ro_rizlona")
        && PoPFlags_Has($v, "pop_sol_ro_xuzl")
        && PoPFlags_Has($v, "pop_sol_ro_solusk");
}

sub PoPFlags_ElementalPreflagComplete {
    my ($v) = @_;
    return PoPFlags_Has($v, "pop_hohb_marr")
        && PoPFlags_Has($v, "pop_bot_agnarr")
        && PoPFlags_NightmareComplete($v)
        && PoPFlags_DiseaseComplete($v)
        && PoPFlags_PoJComplete($v)
        && PoPFlags_Has($v, "pop_pov_aerin_dar")
        && PoPFlags_Has($v, "pop_pos_askr_the_lost", "3")
        && PoPFlags_Has($v, "pop_pos_askr_the_lost_final")
        && PoPFlags_CoDComplete($v)
        && PoPFlags_Has($v, "pop_pot_shadyglade")
        && PoPFlags_Has($v, "pop_pot_saryrn")
        && PoPFlags_Has($v, "pop_pot_saryrn_final")
        && PoPFlags_HoHTrialsComplete($v)
        && PoPFlags_Has($v, "pop_elemental_grand_librarian");
}

sub PoPFlags_Has {
    my ($values, $key, $expected) = @_;
    $expected = "1" unless defined $expected;
    return 0 unless defined $values->{$key};
    return "$values->{$key}" eq "$expected";
}

sub PoPFlags_FlagAt {
    my ($idx) = @_;
    return undef if $idx < 0 || $idx >= scalar(@POP_FLAGS);
    return $POP_FLAGS[$idx];
}

sub PoPFlags_State {
    my ($values, $flag) = @_;
    unless (defined $values->{$flag->{key}}) {
        return ("missing", "not set");
    }
    if ("$values->{$flag->{key}}" eq "$flag->{value}") {
        return ("complete", "value=$values->{$flag->{key}}");
    }
    return ("partial", "value=$values->{$flag->{key}} expected=$flag->{value}");
}

sub PoPFlags_StateColor {
    my ($state) = @_;
    return 10 if $state eq "complete";
    return 14 if $state eq "partial";
    return 15;
}

1;

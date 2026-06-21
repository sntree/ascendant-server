package plugin;

use strict;
use warnings;

# Ascendant automatic skill unlocks
#
# This only gives a character the "learned the basics" value for class skills
# they can already train at their current level. It never lowers or overwrites
# any existing skill value.

my $AUTO_SKILL_VERSION = 1;
my $MAX_SKILL_ID       = 77;

my %EXCLUDED_SKILLS = map { $_ => 1 } (
    # Spell specializations
    43, 44, 45, 46, 47,

    # Tradeskills
    55, 56, 57, 58, 59, 60, 61, 63, 64, 65, 68, 69,
);

sub AutoSkills_BucketKey {
    my ($client) = @_;
    return "asc_auto_skills_" . $client->CharacterID();
}

sub AutoSkills_ShouldRun {
    my ($client) = @_;
    return 0 unless $client;

    my $value = quest::get_data(AutoSkills_BucketKey($client));
    return 1 unless $value;

    my ($version, $level) = split(/:/, $value, 2);
    return 1 unless defined $version && defined $level;
    return 1 unless $version eq "v$AUTO_SKILL_VERSION";
    return 1 unless $level =~ /^\d+$/;

    return ($level < $client->GetLevel()) ? 1 : 0;
}

sub AutoSkills_Process {
    my ($client) = @_;
    return unless $client;

    my $level = $client->GetLevel();
    return unless AutoSkills_ShouldRun($client);

    my $unlocked = 0;

    for my $skill_id (0 .. $MAX_SKILL_ID) {
        next if $EXCLUDED_SKILLS{$skill_id};
        next unless $client->CanHaveSkill($skill_id);

        my $max_skill = $client->MaxSkill($skill_id);
        next unless $max_skill && $max_skill > 0;

        my $current = $client->GetRawSkill($skill_id);
        next unless defined $current;

        # Safety invariant: only missing skills are initialized.
        # Existing skills at 1+ are never changed or reduced.
        next unless $current == 0;

        my $train_level = $client->GetSkillTrainLevel($skill_id);
        $train_level = 1 unless $train_level && $train_level > 0;
        $train_level = $max_skill if $train_level > $max_skill;

        next unless $train_level > 0;

        $client->SetSkill($skill_id, $train_level);
        $unlocked++;
    }

    quest::set_data(AutoSkills_BucketKey($client), "v$AUTO_SKILL_VERSION:$level");

    if ($unlocked > 0) {
        my $suffix = ($unlocked == 1) ? "" : "s";
        $client->Message(15, "You have learned the basics of $unlocked new class skill$suffix.");
    }
}

1;

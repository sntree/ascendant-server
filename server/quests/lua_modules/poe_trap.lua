-- Plane of Earth (poeartha) "trap" placeholder helper.
--
-- Each trap NPC sits idle until a player engages it (event_combat / e.joined),
-- then morphs into a named (rare) or a placeholder mob and removes itself.
--
-- Originally every trap called eq.depop_with_timer(), which restarts the spawn
-- timer (1200s / 3600s) so the trap respawns. Inside a raid DZ the respawned trap
-- instantly re-aggros off nearby players/pets and keeps generating mobs, so the
-- zone can never be cleared (reported by players running PoEB-access raid DZs).
--
-- This helper makes a trap ONE-SHOT inside an instance (DZ / raid DZ) while keeping
-- the normal respawn/farm behavior in the open, persistent zone.

local M = {}

function M.depop()
	if eq.get_zone_instance_id() > 0 then
		eq.depop();            -- instance / DZ: gone for the run, do not respawn
	else
		eq.depop_with_timer(); -- open zone: respawn on the normal spawn timer
	end
end

return M

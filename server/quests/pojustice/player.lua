local player_list = nil;
local player_list_count = nil;
local raid_group = nil;
local clicker = nil;
local mark_of_justice_id = 31599;
local tribunal_portal_leave_popup_id = 315991;
local tribunal_portal_seventh_popup_id = 315992;
local tribunal_exit = { 156, 470, -48, 360 };
local seventh_hammer_destination = { 65, 1308, 7, 121 };

local same_zone_door_destinations = {
	[7] = { 470, 862, 9, 252 },
	[14] = { 445, -539, -26, 254 },
	[94] = { 275, -539, -26, 254 },
	[95] = { 360, -436, -26, 254 },
	[96] = { 275, -501, -25.62, 0 },
	[97] = { 445, -539, -26, 254 },
	[98] = { 444, -400, -26, 0 },
	[99] = { 530, -438, -26, 254 },
	[100] = { 615, -535, -26, 254 },
	[101] = { 616, -506, -25.62, 0 },
	[102] = { 680, -471, -23, 376 },
	[106] = { 445, -539, -26, 254 },
	[107] = { 445, -539, -26, 254 },
	[110] = { 275, -539, -26, 254 },
	[111] = { 276, -398, -25.62, 0 },
	[112] = { 361, -400, -25.62, 0 },
	[113] = { 445, -539, -26, 254 },
	[114] = { 531, -405, -25.62, 0 },
	[115] = { 445, -500, -26, 502 },
	[116] = { 615, -535, -26, 254 },
	[117] = { 614, -400, -25.62, 0 },
	[118] = { 715, -471, -26, 110 },
};

local function ShowTribunalPortalPopup(e)
	e.self:DialogueWindow("{title: Tribunal Portal} {button_one: Leave Tribunal} {button_two: 7th Hammer} popupid:" .. tribunal_portal_leave_popup_id .. " secondresponseid:" .. tribunal_portal_seventh_popup_id .. " wintype:1 noquotes hiddenresponse The Mark of Justice resonates with the portal. Choose your destination.");
end

local function LeaveTribunal(e)
	e.self:Message(MT.Yellow, "The portal returns you from the Tribunal area.");
	e.self:MovePCInstance(201, eq.get_zone_instance_id(), tribunal_exit[1], tribunal_exit[2], tribunal_exit[3], tribunal_exit[4]); -- Zone: pojustice
end

local function SendToSeventhHammer(e)
	e.self:Message(MT.Yellow, "The Mark of Justice resonates with the portal.");

	-- make sure these are reset
	player_list = nil;
	player_list_count = nil;
	raid_group = nil;
	clicker = e.self;

	-- if we're in a raid, we need to move our raid group members
	local raid = e.self:GetRaid();
	if (raid.valid) then
		player_list = raid;
		player_list_count = raid:RaidCount();
		raid_group = raid:GetGroup(e.self);
	else
		-- so we're not in raid, lets check for real groups
		local group = e.self:GetGroup();
		if (group.valid) then
			player_list = group;
			player_list_count = group:GroupCount();
		end
	end

	if (player_list ~= nil) then
		MoveGroup(e.self:GetX(), e.self:GetY(), e.self:GetZ(), 75, seventh_hammer_destination[1], seventh_hammer_destination[2], seventh_hammer_destination[3], seventh_hammer_destination[4]);
	else
		e.self:MovePCInstance(201, eq.get_zone_instance_id(), seventh_hammer_destination[1], seventh_hammer_destination[2], seventh_hammer_destination[3], seventh_hammer_destination[4]); -- Zone: pojustice
	end

	--using this until proximity_say is fixed
	--monk has to have all trials done to loot Symbol on live so force monk to do the clickup or no triggered spawn
	local qglobals = eq.get_qglobals(e.self);
	local el = eq.get_entity_list();
	-- Instance-scoped cooldown key so concurrent pojustice instances don't share the monk epic spawn lock.
	local inst = eq.get_zone_instance_id();
	local hammer_key = (inst > 0) and (inst .. "_monk_7thhammer") or "monk_7thhammer";

	if qglobals["monk_epic"] ~= nil and qglobals["monk_epic"] >= "5" and qglobals[hammer_key] == nil and not el:IsMobSpawnedByNpcTypeID(201074) then
		eq.unique_spawn(201074,0,0,71,1218,9,0); -- NPC: The_Seventh_Hammer
		eq.signal(201074, 999); -- NPC: The_Seventh_Hammer
		eq.set_global(hammer_key,"1",3,"H2");
	end
end

function event_click_door(e)
	local door_id = e.door:GetDoorID();
	local same_zone_destination = same_zone_door_destinations[door_id];

	if (same_zone_destination ~= nil) then
		e.self:MovePCInstance(201, eq.get_zone_instance_id(), same_zone_destination[1], same_zone_destination[2], same_zone_destination[3], same_zone_destination[4]); -- Zone: pojustice
	elseif (door_id >= 8 and door_id <= 13) then
		e.self:MovePCInstance(201, eq.get_zone_instance_id(), 456, 825, 9, 360); -- Zone: pojustice
	elseif (door_id >= 1 and door_id <= 6) then
		if (e.self:HasItem(mark_of_justice_id)) then
			ShowTribunalPortalPopup(e);
		else
			e.self:Message(MT.Yellow, "You need The Mark of Justice in your inventory to use this portal.");
			LeaveTribunal(e);
		end
	end
end

function event_popup_response(e)
	if (e.popup_id == tribunal_portal_seventh_popup_id) then
		if (e.self:HasItem(mark_of_justice_id)) then
			SendToSeventhHammer(e);
		else
			e.self:Message(MT.Yellow, "You need The Mark of Justice in your inventory to use this portal.");
			LeaveTribunal(e);
		end
	elseif (e.popup_id == tribunal_portal_leave_popup_id) then
		LeaveTribunal(e);
	end
end

function MoveGroup(src_x, src_y, src_z, distance, tgt_x, tgt_y, tgt_z, tgt_h)
	if (player_list ~= nil) then
		for i = 0, player_list_count - 1, 1 do
			local mob_v = player_list:GetMember(i);
			if (mob_v ~= nil and mob_v.valid and mob_v:IsClient()) then
				local client_v = mob_v:CastToClient();
				if (client_v.valid) then
					-- so we need to check if their group numbers match in raid need to check the clicker if they are in no group in a raid
					if (raid_group == nil or client_v:GetID() == clicker:GetID() or (raid_group ~= -1 and player_list:GetGroupNumber(i) == raid_group)) then
						-- check the distance and port them up if close enough
						if (client_v:CalculateDistance(src_x, src_y, src_z) <= distance) then
							-- port the player up
							client_v:MovePCInstance(201, eq.get_zone_instance_id(), tgt_x, tgt_y, tgt_z, tgt_h); -- Zone: pojustice
						end
					end
				end
			end
		end
	end
end

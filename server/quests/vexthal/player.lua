local REQUIRE_KEY = true  -- Set to false on test servers
local VT_KEY_IDS = {
  22198,   -- The Scepter of Shadows
  322198,  -- The Scepter of Shadows (Enhanced)
  522198,  -- The Scepter of Shadows (Exalted)
  722198,  -- The Scepter of Shadows (Ascendant)
}

local function has_vt_key(client)
  for _, id in ipairs(VT_KEY_IDS) do
    if client:HasItem(id) or client:KeyRingCheck(id) then
      return true
    end
  end
  return false
end

function event_enter_zone(e)
  if REQUIRE_KEY and e.self:Admin() < 80 then
    if not has_vt_key(e.self) then
      e.self:Message(13, "You do not possess the Scepter of Shadows. You are expelled.")
      e.self:MovePC(176, 1900.00, -474.00, 23.00, 0.00)
      return
    end
  end

  if ( e.self:GetBindZoneID() == 158 ) then    
    e.self:Message(MT.Default, "Illegal Bind!")
    e.self:MovePC(69, 840.00, 70.00, 0.00, 0.00)
  end
end

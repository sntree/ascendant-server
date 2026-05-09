function event_say(e)
	if e.message:findi("activate") and e.other:Admin() >= 40 then
		e.self:Say("Portal override acknowledged. Activating in 30 seconds.");
		eq.signal(152019, 999);
		return;
	end
	if e.message:findi("hail") then
		e.self:Say("Greetings, " .. e.other:GetName() .. ". I am here to assist and watch over those who wish to return to the continent of Velious.  Due to the limited space I share this area with the portal to Odus.  It may be a little confusing but if you listen for the voice it will tell you when to step on the pad for Velious or Odus.  Safe travels to you.");
	end
end

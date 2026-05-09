function event_say(e)
	if e.message:findi("activate") and e.other:Admin() >= 40 then
		e.self:Say("Portal override acknowledged. Activating in 30 seconds.");
		eq.signal(152019, 999);
		return;
	end
	if e.message:findi("hail") then
		e.self:Say("Greetings, " .. e.other:GetName() .. ". I am Jucian Featherhigh, the guardian of this teleport. It will take you back to my home in the Faydark. This pad, along with the others, activate in intervals of around fifteen minutes. When directed to do so, step onto the pad next to me and wait to be teleported.");
	end
end

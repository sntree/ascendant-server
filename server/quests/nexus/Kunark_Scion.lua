function event_say(e)
	if e.message:findi("activate") and e.other:Admin() >= 40 then
		e.self:Say("Portal override acknowledged. Activating in 30 seconds.");
		eq.signal(152019, 999);
		return;
	end
	if e.message:findi("hail") then
		e.self:Say("Hello, $name. Welcome to the Kunark translocation area. Please step onto the pad and when the teleport is activated you will be taken to your destination.");
	end
end

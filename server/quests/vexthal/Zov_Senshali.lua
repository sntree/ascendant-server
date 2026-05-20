--Vex Thal Shade Reanimation Script on Death

function event_timer(e)
    if e.timer == 'depop' then
        eq.stop_timer(e.timer);
        eq.depop();
    end
end

function event_death_complete(e)
   if math.random(1, 100) > 30 then
      return;
   end

   local ran = math.random(1, 100);
   local mob;
   local x, y, z , h = e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading();
   if ran <= 50 then
      --qua
      mob = 158020;
   elseif ran <= 75 then
      --zov
      mob = 158063;
   elseif ran <= 90 then
      --zun
      mob = 158045;
   elseif ran <= 97 then
      --pli
      mob = 158059;
   else
      -- eom
      mob = 158004;
   end

   local spawned = eq.spawn2(mob, 0, 0, x, y, z, h);
   eq.set_timer('depop', 30 * 60 * 1000, spawned);
end
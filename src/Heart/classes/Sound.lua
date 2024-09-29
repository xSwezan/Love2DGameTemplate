Sound = {}
Sound.__index = Sound
Sound.__tostring = function()
	return "Sound"
end

function Sound.new(path)
	local self = setmetatable({
		Source = love.audio.newSource(path, "stream");

		Volume = 1.0;
		Looped = false;
		Pitch = 1.0;
		Position = 0.0;
	}, Sound)

	return self
end

-->---------<--
--> Methods <--
-->---------<--

function Sound:Play()
	self.Source:stop()
	self.Source:play()
end

function Sound:Stop()
	self.Source:stop()
end

function Sound:Pause()
	self.Source:pause()
end

function Sound:Resume()
	self.Source:resume()
end

-->-------------<--
--> Metamethods <--
-->-------------<--

function Sound:__newindex(index, value)
	if (index == "Volume") then
		self.Source:setVolume(value)
	elseif (index == "Looped") then
		self.Source:setLooping(value)
	elseif (index == "Pitch") then
		self.Source:setPitch(value)
	elseif (index == "Position") then
		self.Source:setPosition(value)
		return
	end

	rawset(index, value)
end

-- function Sound:__index(index)
-- 	if (index == "Position") then
-- 		return self.Source:getPosition()
-- 	end

-- 	return rawget(self, index)
-- end

Shader = {}
Shader.__index = Shader
Shader.__tostring = function()
	return "Shader"
end

function Shader.new(code)
	local self = setmetatable({
		Shader = love.graphics.newShader(code);
	}, Shader)

	return self
end

function Shader:Use(callback)
	love.graphics.setShader(self.Shader)
	callback()
	love.graphics.setShader()
end

function Shader:Send(name, value)
	self.Shader:send(name, value)
end

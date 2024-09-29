Canvas = {}
Canvas.__index = Canvas
Canvas.__tostring = function()
	return "Canvas"
end

function Canvas.new(width, height)
	local self = setmetatable({
		Canvas = love.graphics.newCanvas(width, height);
		ClearColor = Color.new(0, 0, 0, 0);
	}, Canvas)

	return self
end

function Canvas:Use(callback)
	love.graphics.setCanvas(self.Canvas)
	callback()
	love.graphics.setCanvas()
end

function Canvas:Draw()
	love.graphics.draw(self.Canvas)
end

function Canvas:Clear()
	love.graphics.clear(self.ClearColor.R, self.ClearColor.G, self.ClearColor.B, self.ClearColor.A)
end

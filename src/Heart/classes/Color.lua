Color = {}
Color.__index = Color
Color.__tostring = function()
	return "Color"
end

function Color.new(r, g, b, a)
	local self = setmetatable({
		R = r;
		G = g;
		B = b;
		A = a;
	}, Color)

	return self
end

function Color.fromRGB(r, g, b)
	return Color.new(r / 255, g / 255, b / 255)
end

function Color.fromRGBA(r, g, b, a)
	return Color.new(r / 255, g / 255, b / 255, a / 255)
end

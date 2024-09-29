local BASE = (...):gsub("Sprite$", "")
require(BASE.."Vector2")
require(BASE.."Rect2D")
require(BASE.."Color")

Sprite = {
	ANCHOR_POINT = {
		TOP_LEFT = Vector2.new(0, 0);
		TOP_RIGHT = Vector2.new(1, 0);
		CENTER = Vector2.new(0.5, 0.5);
		BOTTOM_LEFT = Vector2.new(0, 1);
		BOTTOM_RIGHT = Vector2.new(1, 1);
	};
}
Sprite.__index = Sprite
Sprite.__tostring = function()
	return "Sprite"
end
setmetatable(Sprite, Rect2D)

function Sprite.new(path)
	local self = Rect2D.new()
	setmetatable(self, Sprite)

	self.Texture = nil
	self.Color = Color.new(1, 1, 1)

	self:SetTexture(path)

	return self
end

function Sprite:SetTexture(path)
	local Texture = love.graphics.newImage(path);
	self.Texture = Texture
	self.Size = Vector2.new(Texture:getWidth(), Texture:getHeight())
end

function Sprite:Draw()
	local Size = Vector2.new(
		self.Size.X * self.Scale.X,
		self.Size.Y * self.Scale.Y
	)
	love.graphics.setColor(self.Color.R, self.Color.G, self.Color.B, self.Color.A)
	love.graphics.draw(
		self.Texture,
		self.Position.X,
		self.Position.Y,
		math.rad(self.Rotation),
		Size.X / self.Texture:getWidth(),
		Size.Y / self.Texture:getHeight(),
		self.Texture:getWidth() * self.AnchorPoint.X,
		self.Texture:getHeight() * self.AnchorPoint.Y
	)
end

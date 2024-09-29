Vector2 = {}
Vector2.__index = Vector2

local function makeVector2(value)
	if (type(value) == "number") then
		return Vector2.new(value, value)
	end

	return value
end

function Vector2.new(x, y)
	local self = setmetatable({
		X = x;
		Y = y;
	}, Vector2)

	return self
end

function Vector2:Rotate(angle)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    return Vector2.new(self.X * cos - self.Y * sin, self.X * sin + self.Y * cos)
end

function Vector2:MoveTowards(position, distance)
	return self + (position - self):Unit() * distance
end

function Vector2:Magnitude()
	return math.sqrt(self.X * self.X + self.Y * self.Y)
end

function Vector2:Unit()
	return self / self:Magnitude()
end

function Vector2.__add(rhs, lhs)
	rhs = makeVector2(rhs)
	lhs = makeVector2(lhs)
	return Vector2.new(rhs.X + lhs.X, rhs.Y + lhs.Y)
end

function Vector2.__sub(rhs, lhs)
	rhs = makeVector2(rhs)
	lhs = makeVector2(lhs)
	return Vector2.new(rhs.X - lhs.X, rhs.Y - lhs.Y)
end

function Vector2.__mul(rhs, lhs)
	rhs = makeVector2(rhs)
	lhs = makeVector2(lhs)
	return Vector2.new(rhs.X * lhs.X, rhs.Y * lhs.Y)
end

function Vector2.__div(rhs, lhs)
	rhs = makeVector2(rhs)
	lhs = makeVector2(lhs)
	return Vector2.new(rhs.X / lhs.X, rhs.Y / lhs.Y)
end

function Vector2:__unm()
	return Vector2.new(-self.X, -self.Y)
end

function Vector2:__tostring()
	return self.X .. ", " .. self.Y
end

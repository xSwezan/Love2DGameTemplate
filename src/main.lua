require("Heart")
local moonshine = require("moonshine")

local player
local bullets = {}
local enemies = {}

local moveSpeed = 300
local bulletSpeed = 1000
local enemySpeed = 150

local score = 0

local spaceShader
local vignette

local screenCanvas

local bulletDebounce = false
local enemyDebounce = false

local shootCooldown = 0.25
local enemyCooldown = 1.2

local function shootBullet()
	local newBullet = Sprite.new("assets/bullet.png")
	newBullet.Texture:setFilter("nearest", "nearest")
	newBullet.Scale = Vector2.new(1, 1)
	newBullet.Position = player.Position - Vector2.new(0, player.Size.Y * player.Scale.Y / 2)
	table.insert(bullets, newBullet)

	bulletDebounce = true

	Task.delay(shootCooldown, function()
		bulletDebounce = false
	end)
end

local function spawnEnemy()
	local width, height = love.window.getMode()

	local newEnemy = Sprite.new("assets/enemy.png")
	newEnemy.Texture:setFilter("nearest", "nearest")
	newEnemy.Scale = Vector2.new(3, 3)
	newEnemy.Position = Vector2.new(width * math.random(), -player.Size.Y * player.Scale.Y)
	table.insert(enemies, newEnemy)
end

function love.load()
	love.window.setIcon(love.image.newImageData("assets/player.png"))
	love.window.setFullscreen(true)

	local width, height = love.window.getMode()

	player = Sprite.new("assets/player.png")
	player.Texture:setFilter("nearest", "nearest")
	player.Scale = Vector2.new(3, 3)
	player.Position = Vector2.new(width / 2, height - player.Size.Y * player.Scale.Y)

	player = Sprite.new("assets/player.png")
	player.Texture:setFilter("nearest", "nearest")
	player.Scale = Vector2.new(3, 3)
	player.Position = Vector2.new(width / 2, height - player.Size.Y * player.Scale.Y)

	screenCanvas = Canvas.new(width, height)

	spaceShader = Shader.new(require("assets.spaceShader"))
	spaceShader:Send("width", 2)
	spaceShader:Send("phase", 0)
	spaceShader:Send("thickness", 1)
	spaceShader:Send("opacity", 1)
	spaceShader:Send("color", {0, 0, 0})

	vignette = Shader.new(require("assets.vignette"))
	vignette:Send("radius", 0.8)
	vignette:Send("softness", 0.5)
	vignette:Send("opacity", 0.5)
	vignette:Send("color", {1, 0, 0, 1})
end

function love.update(dt)
	local mousePosition = Vector2.new(love.mouse.getX(), love.mouse.getY())
	local width, height = love.window.getMode()

	Task.update(dt)

	if (love.keyboard.isDown("left")) then
		player.Position = player.Position - Vector2.new(moveSpeed * dt, 0)
	end

	if (love.keyboard.isDown("right")) then
		player.Position = player.Position + Vector2.new(moveSpeed * dt, 0)
	end

	if (love.keyboard.isDown("up")) and not (bulletDebounce) then
		shootBullet()
	end

	player:LookAt(mousePosition)

	if not (enemyDebounce) then
		spawnEnemy()
		enemyDebounce = true
		Task.delay(enemyCooldown, function()
			enemyDebounce = false
		end)
	end

	for i, bullet in pairs(bullets) do
		bullet.Position = bullet.Position - Vector2.new(0, bulletSpeed * dt)
		if (bullet.Position.Y < -bullet.Size.Y * bullet.Scale.Y) then
			table.remove(bullets, i)
		end
	end

	for i, enemy in pairs(enemies) do
		enemy.Position = enemy.Position + Vector2.new(0, enemySpeed * dt)
		if (enemy.Position.Y > height + enemy.Size.Y * enemy.Scale.Y) then
			table.remove(enemies, i)
		end
	end

	for i, enemy in pairs(enemies) do
		local hit = false
		for j, bullet in pairs(bullets) do
			if (bullet:Overlaps(enemy)) then
				hit = true
				table.remove(bullets, j)
				break
			end
		end
		if (hit) then
			table.remove(enemies, i)
			score = score + 1
		end
	end
end

function love.draw()
	screenCanvas.ClearColor = Color.fromRGB(30, 30, 30)
	screenCanvas:Use(function()
		screenCanvas:Clear()

		player:Draw()

		for _, bullet in pairs(bullets) do
			bullet:Draw()
		end

		for _, bullet in pairs(enemies) do
			bullet:Draw()
		end
	end)

	local effect = moonshine(moonshine.effects.glow).chain(moonshine.effects.scanlines).chain(moonshine.effects.vignette).chain(moonshine.effects.crt)
	effect.vignette.radius = .9
	effect(function()
		screenCanvas:Draw()
	end)

	-- spaceShader:Use(function()
	-- 	spaceShader:Use(function()
	-- 		screenCanvas:Draw()
	-- 	end)
	-- end)

	love.graphics.print("Score: " .. score)
end

-- Config
local font = "rbxassetid://11702779517" -- Montserrat
local start = os.clock()


-- Environment
if game:GetService("CoreGui"):FindFirstChild("Crystal") then
	game:GetService("CoreGui").Crystal:Destroy()
end

local tws = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")
local rns = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local getHit = loadstring(game:HttpGet("https://github.com/agreeed/crystal/raw/main/gloves.lua"))()

local bypass;
bypass = hookmetamethod(game, "__namecall", function(method, ...) 
	if getnamecallmethod() == "FireServer" and table.find({rs.Ban, rs.AdminGUI, rs.WalkSpeedChanged}, method) then
		return
	end
	return bypass(method, ...)
end) -- This bypasses walkspeed ban

local function cwarn(t)
	warn("[Crystal Warning]: ".. t)
end
local function cassert(b, t)
	assert(b, "[Crystal Exception]: ".. t)
end

local function getChar()
	return plr.Character
end
local function getRoot()
	if not getChar() then
		return
	end
	return getChar():FindFirstChild("HumanoidRootPart") or
			getChar():FindFirstChild("Torso") or
			getChar():FindFirstChild("LowerTorso")
end
local viewport
local function pulse(pos)
	local part = Instance.new("Part", viewport)
	part.Position = pos
	part.Shape = Enum.PartType.Ball
	part.Material = Enum.Material.Neon
	part.Size = Vector3.one * 3
	part.Transparency = 0
	part.Anchored = true

	tws:Create(part, TweenInfo.new(1), {Transparency = 1}):Play()
	task.delay(1, part.Destroy, part)
end


-- Functionality
local services = {}
--world
services.SilentAntiVoid = {
	Type = "Toggle",
	Name = "Silent Anti-Void",
	Category = "World",
	Enabled = false,
	Config = {},
	Start = function()
		local fld = workspace:FindFirstChild(" .bound") or Instance.new("Model", workspace)
		fld.Name = " .bound"
		fld:ClearAllChildren()
		local iter = 40

		local function createPart()
			local part = Instance.new("Part", fld)
			part.Size = Vector3.new(100, 200, 35)
			part.Anchored = true
			part.CanCollide = true
			part.Transparency = 0.8
			return part
		end

		for i = 1, iter do
			local deg = i/iter*360
			local rad = math.rad(deg)

			local newpart = createPart()
			newpart.Position = Vector3.new(math.sin(rad), 1/2, math.cos(rad)) * 130
				+ Vector3.new(-4, 0, 3)
			newpart.Rotation = Vector3.new(0, deg, 0)
		end
	end,
	Stop = function()
		workspace:FindFirstChild(" .bound"):Destroy()
	end
}
services.AntiDeathBarrier = {
	Type = "Toggle",
	Name = "Anti-Death Barrier",
	Category = "World",
	Enabled = false,
	Config = {},
	Start = function()
		workspace.AntiDefaultArena.CanTouch = false
		workspace.DEATHBARRIER.CanTouch = false
		workspace.DEATHBARRIER2.CanTouch = false
		for i, v in workspace.DEATHBARRIER:GetChildren() do
			if v.Name == "Block" then
				v.CanTouch = false
			end
		end
	end,
	Stop = function()
		workspace.AntiDefaultArena.CanTouch = true
		workspace.DEATHBARRIER.CanTouch = true
		workspace.DEATHBARRIER2.CanTouch = true
		for i, v in workspace.DEATHBARRIER:GetChildren() do
			if v.Name == "Block" then
				v.CanTouch = true
			end
		end
	end
}
services.AntiVoid = {
	Type = "Toggle",
	Name = "Anti-Void",
	Category = "World",
	Enabled = false,
	Config = {},
	Start = function()
		workspace.dedBarrier.Transparency = 0.5
		workspace.dedBarrier.CanTouch = false
		workspace.dedBarrier.CanCollide = true
	end,
	Stop = function()
		workspace.dedBarrier.Transparency = 1
		workspace.dedBarrier.CanTouch = true
		workspace.dedBarrier.CanCollide = false
	end
}
services.RemoveColorCorrection = {
	Type = "Button",
	Name = "Remove Color-Correction",
	Category = "World",
	Config = {},
	Activate = function()
		for i, v in game:GetService("Lighting"):GetChildren() do
			if v:IsA("ColorCorrectionEffect") then
				v.Enabled = false
			end
		end
	end
}
--abilities
services.Null = {
	Type = "Button",
	Name = "Spawn Null",
	Category = "Abilities",
	Config = {},
	Activate = function()
		rs.NullAbility:FireServer()
	end
}
services.NullSpam = {
	Type = "Toggle",
	Name = "Spam Null",
	Category = "Abilities",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait(0.5) do
			rs.NullAbility:FireServer()
		end
	end,
	Stop = function() end
}
services.RhythmAOE = {
	Type = "Button",
	Name = "Spawn Rhythm AOE",
	Category = "Abilities",
	Config = {},
	Activate = function()
		rs.rhythmevent:FireServer("AoeExplosion", 86)
	end
}
services.RhythmSpam = {
	Type = "Toggle",
	Name = "Spam Rhythm AOE",
	Category = "Abilities",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait(0.5) do
			rs.rhythmevent:FireServer("AoeExplosion", 86)
		end
	end,
	Stop = function() end
}
services.Retro = {
	Type = "Button",
	Name = "Spawn Retro Ability",
	Category = "Abilities",
	Config = {},
	Activate = function()
		rs.RetroAbility:FireServer("Rocket Launcher")
		rs.RetroAbility:FireServer("Ban Hammer")
		rs.RetroAbility:FireServer("Bomb")
	end
}
services.RetroSpam = {
	Type = "Toggle",
	Name = "Spam Retro Ability",
	Category = "Abilities",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait(0.5) do
			rs.RetroAbility:FireServer("Rocket Launcher")
			rs.RetroAbility:FireServer("Ban Hammer")
			rs.RetroAbility:FireServer("Bomb")
		end
	end,
	Stop = function() end
}
--combat
services.Extend = {
	Type = "Button",
	Name = "Extend Glove",
	Category = "Combat",
	Config = {},
	Activate = function()
		local tool = getChar():FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
		if not tool then
			return
		end

		tool.Grip -= Vector3.yAxis * 10
	end
}
services.GhostN = {
	Type = "Button",
	Name = "Ghost Activate",
	Category = "Combat",
	Config = {},
	Activate = function()
		rs.Ghostinvisibilityactivated:FireServer()
	end
}
services.GhostF = {
	Type = "Button",
	Name = "Ghost Deactivate",
	Category = "Combat",
	Config = {},
	Activate = function()
		rs.Ghostinvisibilitydeactivated:FireServer()
	end
}
services.CVisible = {
	Type = "Toggle",
	Name = "Everyone Visible",
	Category = "Combat",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait(1) do
			for _, i in game:GetService("Players"):GetPlayers() do
				if not i.Character then
					continue
				end

				for _, v in i.Character:GetDescendants() do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Transparency > 0.9 then
						v.Transparency = 0.5
					end
				end
			end
		end
	end,
	Stop = function() end
}
services.AntiNull = {
	Type = "Toggle",
	Name = "Anti Null",
	Category = "Combat",
	Enabled = false,
	Config = {},
	Start = function()
		while true do
			for i,v in pairs(workspace:GetChildren()) do
				if v.Name ~= "Imp" then
					continue
				end
				getHit(plr.leaderstats.Glove.Value):FireServer(v.Body, true)
				pulse(v.Body.Position)
			end

			task.wait()
		end
	end,
	Stop = function() end
}
services.SlapAura = {
	Type = "Toggle",
	Name = "Slap Aura",
	Category = "Combat",
	Enabled = false,
	Config = {
		MaxDistance = {Name = "Max Distance", Value = 25}
	},
	Start = function()
		while true do
			for i,v in pairs(game.Players:GetChildren()) do
				if v == plr or not getChar():FindFirstChild("HumanoidRootPart") or not v.Character then
					continue
				end
				
				local entertag = v.Character:FindFirstChild("entered") or
					(v.Character:FindFirstChildOfClass("Tool") or v.Backpack:FindFirstChildOfClass("Tool"))
				local hrp = v.Character:FindFirstChild("HumanoidRootPart")
				local rocktag = v.Character:FindFirstChild("rock")
				local steve = v.Character:FindFirstChild("stevebody")
				local spec = v.leaderstats.Glove.Value == "Spectator"

				if not entertag or not hrp or rocktag or spec or steve then
					continue
				end
				if v.Character.Head:FindFirstChild("UnoReverseCard") then
					continue
				end

				Magnitude = (getChar().Torso.Position - v.Character.Torso.Position).Magnitude
				if Magnitude < services.SlapAura.Config.MaxDistance.Value then
					getHit(plr.leaderstats.Glove.Value):FireServer(hrp, true)
					pulse(hrp.Position)
					
					local cd = 0.45 + math.abs(math.sin(os.clock() * 0.3)) * 0.25
					task.wait(cd)
				end
			end

			task.wait()
		end
	end,
	Stop = function() end
}
services.NoCooldown = {
	Type = "Toggle",
	Name = "No Cooldown",
	Category = "Combat",
	Enabled = false,
	Config = {},
	Start = function()
		local function bind()
			local char = getChar()
			task.wait()

			local ls = (char:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")):FindFirstChildOfClass("LocalScript")
			ls.Enabled = false
			ls.Enabled = true
		end

		while task.wait() do
			local char = getChar()

			if char then
				local tool = char:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
				tool.Activated:Connect(bind)
				tool.Destroying:Wait()
			end
		end
	end,
	Stop = function() end
}
services.Speed = {
	Type = "Toggle",
	Name = "Speed",
	Category = "Combat",
	Enabled = false,
	Config = {
		Speed = {Name = "Speed", Value = 30}
	},
	Start = function()
		while task.wait() do
			local char = getChar()
			if not char then
				continue
			end

			if char:FindFirstChild("Humanoid") then
				char.Humanoid.WalkSpeed = services.Speed.Config.Speed.Value
			end
		end
	end,
	Stop = function() end
}
services.AntiRagdoll = {
	Type = "Toggle",
	Name = "Anti Ragdoll",
	Category = "Combat",
	Enabled = false,
	Config = {},
	Start = function()
		local function bind(char)
			if not char or not char:WaitForChild("HumanoidRootPart", 1) then
				return
			end

			local hrp = char.HumanoidRootPart
			local hum = char.Humanoid
			local ragdoll = char:WaitForChild("Ragdolled")
			local bp = Instance.new("BodyPosition", hrp)
			bp.MaxForce = Vector3.zero
			bp.D = 1000
			bp.P = 10000
			bp.Position = hrp.Position

			while task.wait() and char.Parent == workspace do
				local supragdoll = hum:GetState() == Enum.HumanoidStateType.PlatformStanding or
									hum:GetState() == Enum.HumanoidStateType.FallingDown
				
				if not ragdoll.Value and not supragdoll then
					bp.Position = hrp.Position
					bp.MaxForce = Vector3.zero
				else
					bp.MaxForce = Vector3.one * 100000
				end
			end
		end

		while task.wait() do
			if not getChar() then
				continue
			end

			if getChar():FindFirstChild("HumanoidRootPart") and not getChar().HumanoidRootPart:FindFirstChild("BodyPosition") then
				bind(getChar())
			end
		end
	end,
	Stop = function()
		if getChar():FindFirstChild("HumanoidRootPart") then
			getChar().HumanoidRootPart.BodyPosition:Destroy()
		end
	end
}
--movement
services.TPMain = {
	Type = "Button",
	Name = "TP: Main Island",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(CFrame.new(-4, 0, 3))
	end
}
services.TPMoyai = {
	Type = "Button",
	Name = "TP: Moyai Island",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(CFrame.new(196, -5, 0))
	end
}
services.TPSlapple = {
	Type = "Button",
	Name = "TP: Slapple Island",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(CFrame.new(-375, 55, -14))
	end
}
services.TPPlate = {
	Type = "Button",
	Name = "TP: Plate",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(workspace.Arena.Plate.CFrame + Vector3.yAxis * 3)
	end
}
services.TPPortal = {
	Type = "Button",
	Name = "TP: Arena Portal",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(workspace.Lobby.Teleport1.CFrame)
	end
}
services.SafeSpot1 = {
	Type = "Button",
	Name = "Safe Spot 1",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(CFrame.new(18830, 3043, -228))
	end
}
services.SafeSpot2 = {
	Type = "Button",
	Name = "Safe Spot 2",
	Category = "Movement",
	Config = {},
	Activate = function()
		getChar():PivotTo(CFrame.new(17909, 0, -3562))
	end
}
services.AntiFling = {
	Type = "Toggle",
	Name = "Anti Fling",
	Category = "Movement",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		while true do
			task.wait()
			local char = getChar()
			if not char or not char:FindFirstChild("HumanoidRootPart") then
				continue
			end

			local hrp = char.HumanoidRootPart

			if hrp.AssemblyLinearVelocity.Magnitude > 100 then
				hrp.AssemblyLinearVelocity = Vector3.new(
					math.clamp(hrp.AssemblyLinearVelocity.X, -100, 100),
					math.clamp(hrp.AssemblyLinearVelocity.Y, -100, 100),
					math.clamp(hrp.AssemblyLinearVelocity.Z, -100, 100)
				)
				hrp.Anchored = true
				task.wait()
				hrp.Anchored = false
			end
		end
	end,
	Stop = function()
		for i, v in services.AntiFling.CallBacks do
			v:Disconnect()
		end
		services.AntiFling.CallBacks = {}
	end
}
--bypass
services.MegarockBypass = {
	Type = "Toggle",
	Name = "Megarock Bypass",
	Category = "Bypass",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		local function react(dc)
			if dc.Name == "rock" and v:IsA("BasePart") then
				dc.CanTouch = false
				local cc = dc:GetPropertyChangedSignal("CanTouch"):Connect(function()
					if dc.CanTouch then
						dc.CanTouch = false
					end
				end)
				table.insert(services.MegarockBypass.CallBacks, cc)
			end
		end

		local cb = workspace.DescendantAdded:Connet(react)
		table.insert(services.MegarockBypass.CallBacks, cb)

		for i, v in workspace:GetDescendants() do
			react(v)
		end
	end,
	Stop = function()
		for i, v in services.MegarockBypass.CallBacks do
			v:Disconnect()
		end
		services.MegarockBypass.CallBacks = {}
	end
}
services.ObbyBypass = {
	Type = "Toggle",
	Name = "ObbyBricks Bypass",
	Category = "Bypass",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		local cb = workspace.ChildAdded:Connet(function(dc)
			if dc.Name:sub(0, 8) == "ObbyPart" then
				dc.CanTouch = false
				local cc = dc:GetPropertyChangedSignal("CanTouch"):Connect(function()
					if dc.CanTouch then
						dc.CanTouch = false
					end
				end)
				table.insert(services.ObbyBypass.CallBacks, cc)
			end
		end)
		
		table.insert(services.ObbyBypass.CallBacks, cb)
	end,
	Stop = function()
		for i, v in services.ObbyBypass.CallBacks do
			v:Disconnect()
		end
		services.ObbyBypass.CallBacks = {}
	end
}
services.RobBypass = {
	Type = "Toggle",
	Name = "Rob Bypass",
	Category = "Bypass",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		local function react(dc)
			if dc.Name == "rob" and dc:IsA("Model") then
				for i, v in dc:GetChildren() do
					if v:IsA("BasePart") then
						v.CanTouch = false
					end
				end
			end
		end

		local cb = workspace.ChildAdded:Connect(react)
		table.insert(services.RobBypass.CallBacks, cb)

		for i, v in workspace:GetChildren() do
			react(v)
		end
	end,
	Stop = function()
		for i, v in services.RobBypass.CallBacks do
			v:Disconnect()
		end
		services.RobBypass.CallBacks = {}
	end
}
services.BobBypass = {
	Type = "Toggle",
	Name = "Bob Bypass",
	Category = "Bypass",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		local function react(dc)
			if dc.Name:sub(0, 5) == "ÅBOB_" and dc:IsA("Model") then
				for i, v in dc:GetChildren() do
					if v:IsA("BasePart") then
						v.CanTouch = false
					end
				end
			end
		end
        
		local cb = workspace.ChildAdded:Connect(react)
		table.insert(services.BobBypass.CallBacks, cb)

		for i, v in workspace:GetChildren() do
			react(v)
		end
	end,
	Stop = function()
		for i, v in services.BobBypass.CallBacks do
			v:Disconnect()
		end
		services.BobBypass.CallBacks = {}
	end
}
services.TimestopBypass = {
	Type = "Toggle",
	Name = "TimeStop Bypass",
	Category = "Bypass",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		while task.wait() do
			local char = getChar()
			if not char then
				return
			end

			for i, v in char:GetChildren() do
				if v:IsA("BasePart") then
					v.Anchored = false
				end
			end
		end
	end,
	Stop = function() end
}
--farm
services.Slapples = {
	Type = "Toggle",
	Name = "Slapple Farm",
	Category = "Farm",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait(0.1) do
			for i, v in workspace.Arena.island5.Slapples:GetChildren() do
				local char = getChar()
				if not char then
					continue
				end

				if char:FindFirstChild("InLobby") then
					char:PivotTo(workspace.Lobby.Teleport1.CFrame)
					char.InLobby.Destroying:Wait()
				end

				if v.Glove.Transparency == 0 then
					char:PivotTo(v:GetPivot())
					rns.Heartbeat:Wait()
				end
			end
		end
	end,
	Stop = function() end
}
services.AdminGlove = {
	Type = "Button",
	Name = "Admin glove place",
	Category = "Farm",
	Config = {},
	Activate = function()
		rs.RetroTP:FireServer()
	end
}
services.TycoonFarm = {
	Type = "Toggle",
	Name = "Tycoon Farm",
	Category = "Farm",
	Enabled = false,
	Config = {},
	Start = function()
		while task.wait() do
			local char = getChar()
			if not char then
				continue
			end

			if char:FindFirstChild("InLobby") then
				char:PivotTo(workspace.Lobby.Teleport1.CFrame)
				continue
			end

			char:PivotTo(workspace.Arena.Plate.CFrame + Vector3.yAxis * -2)
			getRoot().AssemblyLinearVelocity = Vector3.yAxis * -100
		end
	end,
	Stop = function() end
}
services.FishFarm = {
	Type = "Toggle",
	Name = "Fish/Ghost Farm",
	Category = "Farm",
	Enabled = false,
	Config = {},
	Start = function()
		if plr.leaderstats.Glove.Value ~= "ZZZZZZZ" and plr.leaderstats.Glove.Value ~= "Ghost" then
			services.FishFarm.Enabled = false
			return
		end
		
		local char = getChar()
		if not char then
			services.FishFarm.Enabled = false
			return
		end
		if not char:FindFirstChild("HumanoidRootPart") then
			services.FishFarm.Enabled = false
			return
		end

		while task.wait() do
			char:PivotTo(CFrame.new(10000, 8000, 12888 + math.sin(os.clock() / 10) * 100))
			char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		end
	end,
	Stop = function() end
}
services.BobFarm = {
	Type = "Toggle",
	Name = "Bob Farm",
	Category = "Farm",
	Enabled = false,
	Config = {},
	CallBacks = {},
	Start = function()
		if plr.leaderstats.Glove.Value ~= "Replica" then
			services.BobFarm.Enabled = false
			return
		end

		local function farm(char)
			task.wait(0.5)
			if char.Parent ~= workspace then
				return
			end

			local humanoid = char:FindFirstChild("Humanoid")
			if not humanoid then
				return
			end

			humanoid:MoveTo(Vector3.new(-810, 330, 4)) -- Portal

			char:WaitForChild("regulararena", 1)
			if not char:FindFirstChild("regulararena") then
				humanoid:ChangeState(Enum.HumanoidStateType.Dead)
				return
			end

			task.wait(0.5)
			rs.Duplicate:FireServer() -- Ability
			task.wait(0.5)

			humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end

		table.insert(services.BobFarm.CallBacks, plr.CharacterAdded:Connect(farm))
		farm(getChar())
	end,
	Stop = function()
		for i, v in services.BobFarm.CallBacks do
			v:Disconnect()
		end
		services.BobFarm.CallBacks = {}
	end
}

local map = {
	{
		Category = "World",
		Services = {"SilentAntiVoid", "AntiDeathBarrier", "AntiVoid", "RemoveColorCorrection"}
	},
	{
		Category = "Abilities",
		Services = {"Null", "NullSpam", "RhythmAOE", "RhythmSpam", "Retro", "RetroSpam"}
	},
	{
		Category = "Combat",
		Services = {"Extend", "SlapAura", "NoCooldown", "GhostN", "GhostF", "CVisible", "AntiRagdoll", "Speed"}
	},
	{
		Category = "Movement",
		Services = {"TPMain", "TPMoyai", "TPSlapple", "TPPlate", "TPPortal", "SafeSpot1", "SafeSpot2", "AntiFling"}
	},
	{
		Category = "Bypass",
		Services = {"MegarockBypass", "ObbyBypass", "RobBypass", "BobBypass", "TimestopBypass"}
	},
	{
		Category = "Farm",
		Services = {"Slapples", "AdminGlove", "TycoonFarm", "BobFarm", "FishFarm"}
	}
}

local serviceThreads = {}

local function startService(service)
	services[service].Enabled = true
	local thread = coroutine.create(services[service].Start)
	serviceThreads[service] = thread
	coroutine.resume(thread)
end

local function stopService(service)
	local thread = serviceThreads[service]
	if not thread then
		cwarn("Failed to stop service ".. service.. ", it is not running.")
	end
	coroutine.close(thread)
	local thread = services[service].Stop()
	services[service].Enabled = false
end

local function toggleService(service)
	if services[service].Enabled then
		stopService(service)
	else
		startService(service)
	end
end

local function activateService(service)
	task.spawn(services[service].Activate)
end


-- UI
local function new(classname, parent, properties)
	local new = Instance.new(classname, parent)
	for i, v in properties do
		new[i] = v
	end
	return new
end
local rainbowGradients = {}
-- i am sorry for this mess, but im also not going to stretch the ui section to hundreds of lines of code
local gui = new("ScreenGui", game:GetService("CoreGui"), {Name = "Crystal", DisplayOrder = 500, IgnoreGuiInset = true, ResetOnSpawn = false})
viewport = new("ViewportFrame", gui, {Name = "MainViewport", BackgroundTransparency = 1, CurrentCamera = workspace.CurrentCamera, Size = UDim2.fromScale(1, 1)})
local canvas = new("CanvasGroup", gui, {Name = "Canvas", BackgroundTransparency = 1, GroupTransparency = 0, Size = UDim2.fromScale(1, 1), Visible = true})
local scale = new("UIScale", canvas, {})

local holder = new("Frame", canvas, {Name = "Holder", BackgroundTransparency = 0.5, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1)})
local layout = new("UIListLayout", holder, {Padding = UDim.new(0, 20), FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center})

local settings = new("Frame", canvas, {Name = "Settings", BackgroundTransparency = 0.5, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Visible = false})
local setui = new("Frame", settings, {Name = "UI", BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.2, Size = UDim2.fromOffset(300, 100), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.one * 0.5})
local setstr = new("UIStroke", setui, {Thickness = 3, Transparency = 0.5, Color = Color3.new(1, 1, 1), LineJoinMode = Enum.LineJoinMode.Miter})
table.insert(rainbowGradients, {setui, new("UIGradient", setstr, {})})
local setcont = new("Frame", setui, {Name = "Container", BackgroundTransparency = 1, Position = UDim2.fromOffset(5, 35), Size = UDim2.new(1, -10, 1, -40)})
new("UIListLayout", setcont, {Padding = UDim.new(0, 3)})
new("TextLabel", setui, {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Text = name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 26})

local uib1 = new("TextButton", canvas, {Name = "Functions", BackgroundTransparency = 0.3, BackgroundColor3 = Color3.new(0, 0, 0), Text = "Functions", FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 20, Size = UDim2.fromOffset(150, 30), Position = UDim2.new(0.5, -165, 0.2, 0), ZIndex = 3})
uib1.Activated:Connect(function() holder.Visible = true settings.Visible = false end)
local uib1s = new("UIStroke", uib1, {Thickness = 3, Transparency = 0.5, Color = Color3.new(1, 1, 1), LineJoinMode = Enum.LineJoinMode.Miter, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
table.insert(rainbowGradients, {uib1, new("UIGradient", uib1s, {})})

local uib2 = new("TextButton", canvas, {Name = "Settings", BackgroundTransparency = 0.3, BackgroundColor3 = Color3.new(0, 0, 0), Text = "Settings", FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 20, Size = UDim2.fromOffset(150, 30), Position = UDim2.new(0.5, 15, 0.2, 0), ZIndex = 3})
uib2.Activated:Connect(function() holder.Visible = false settings.Visible = true end)
local uib2s = new("UIStroke", uib2, {Thickness = 3, Transparency = 0.5, Color = Color3.new(1, 1, 1), LineJoinMode = Enum.LineJoinMode.Miter, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
table.insert(rainbowGradients, {uib2, new("UIGradient", uib2s, {})})

local scbox = new("TextBox", canvas, {BackgroundTransparency = 0.8, BorderColor3 = Color3.new(0.3, 0.3, 0.3), Size = UDim2.fromOffset(150, 30), Position = UDim2.new(0.5, -75, 0.2, 50), ZIndex = 3, Text = "", PlaceholderText = "UI Scale", FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 20})

new("TextLabel", canvas, {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 50), Position = UDim2.fromScale(0, 1), AnchorPoint = Vector2.yAxis, Text = "Press M to hide/show the menu.\nLeft Click to toggle function, Right Click to show function settings.", FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 20})

local function gui_setentry(parent, iden, setting)
	local service = services[iden]
	local entry = new("Frame", parent, {Name = setting, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 25)})
	new("TextLabel", entry, {BackgroundTransparency = 0.8, BorderColor3 = Color3.new(0.3, 0.3, 0.3), Size = UDim2.new(0.5, -3, 1, 0), Text = service.Config[setting].Name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 17})
	new("TextBox", entry, {BackgroundTransparency = 0.8, BorderColor3 = Color3.new(0.3, 0.3, 0.3), Size = UDim2.new(0.5, -3, 1, 0), Position = UDim2.fromScale(0.5, 0), Text = "", PlaceholderText = tostring(service.Config[setting].Value), FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 17})
	return entry
end
local function gui_settoggle(parent, iden, setting)
	local service = services[iden]
	local entry = new("Frame", parent, {Name = setting, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 25)})
	new("Frame", entry, {Name = "Indicator", BackgroundTransparency = 0.3, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromOffset(25, 0), BorderColor3 = Color3.new(.3, .3, .3), BorderMode = Enum.BorderMode.Inset})
	new("TextLabel", entry, {BackgroundTransparency = 1, Size = UDim2.new(1, -3, 1, 0), Text = service.Config[setting].Name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 17})
	new("TextButton", entry, {BackgroundTransparency = 1, Size = UDim2.new(1, 1), Text = ""})
	return entry
end

local function gui_settings(iden)
	holder.Visible = false
	settings.Visible = true

	if iden then
		local service = services[iden]

		setui.TextLabel.Text = service.Name
		setcont:ClearAllChildren()
		new("UIListLayout", setcont, {Padding = UDim.new(0, 3)})

		for i, v in service.Config do
			if type(v.Value) == "boolean" then
				local togg = gui_settoggle(setcont, iden, i)
				togg.TextButton.MouseButton1Click:Connect(function()
					service.Config[i].Value = not service.Config[i].Value

					if v.Value then
						togg.Indicator.BackgroundTransparency = Color3.new(0, 1, 0)
					else
						togg.Indicator.BackgroundTransparency = Color3.new(0, 0, 0)
					end
				end)

				if v.Value then
					togg.Indicator.BackgroundTransparency = Color3.new(0, 1, 0)
				else
					togg.Indicator.BackgroundTransparency = Color3.new(0, 0, 0)
				end
			elseif type(v.Value) == "number" then
				local entry = gui_setentry(setcont, iden, i)
				entry.TextBox.FocusLost:Connect(function()
					local val = tonumber(entry.TextBox.Text)
					if val then
						service.Config[i].Value = val
					end

					entry.TextBox.PlaceholderText = tostring(service.Config[i].Value)
					entry.TextBox.Text = ""
				end)
			elseif type(v.Value) == "string" then
				local entry = gui_setentry(setcont, iden, i)
				entry.TextBox.FocusLost:Connect(function()
					local val = entry.TextBox.Text
					if val then
						service.Config[i].Value = val
					end

					entry.TextBox.PlaceholderText = service.Config[i].Value
					entry.TextBox.Text = ""
				end)
			end
		end
	end
end

local function gui_category(name)
	local category = new("Frame", holder, {Name = name, BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.2})
	--new("UICorner", category, {CornerRadius = UDim.new(0, 8)})
	local stroke = new("UIStroke", category, {Thickness = 3, Transparency = 0.5, Color = Color3.new(1, 1, 1), LineJoinMode = Enum.LineJoinMode.Miter})
	table.insert(rainbowGradients, {category, new("UIGradient", stroke, {})})
	local container = new("Frame", category, {Name = "Container", BackgroundTransparency = 1, Position = UDim2.fromOffset(5, 35), Size = UDim2.new(1, -10, 1, -40)})
	new("UIListLayout", container, {Padding = UDim.new(0, 3)})
	new("TextLabel", category, {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Text = name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 26})
	return category
end

local function gui_entry(parent, iden)
	local service = services[iden]
	local entry = new("Frame", parent, {Name = service.Name, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 25)})
	new("Frame", entry, {Name = "Indicator", BackgroundTransparency = 0.3, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.new(0, 10, 1, 0), BorderColor3 = Color3.new(.3, .3, .3), BorderMode = Enum.BorderMode.Inset})
	new("TextLabel", entry, {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = service.Name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 17})
	local button = new("TextButton", entry, {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = ""})
	button.MouseButton1Click:Connect(function() toggleService(iden) end)
	button.MouseButton2Click:Connect(function() gui_settings(iden) end)
	return entry
end

local function gui_button(parent, iden)
	local service = services[iden]
	local entry = new("Frame", parent, {Name = service.Name, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 25)})
	new("Frame", entry, {Name = "Indicator", BackgroundTransparency = 0.3, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.new(1, 0, 1, 0), BorderColor3 = Color3.new(.3, .3, .3), BorderMode = Enum.BorderMode.Inset})
	new("TextLabel", entry, {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = service.Name, FontFace = Font.new(font), TextColor3 = Color3.new(1, 1, 1), TextSize = 17, ZIndex = 2})
	local button = new("TextButton", entry, {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = ""})
	button.MouseButton1Click:Connect(function() activateService(iden) end)
	button.MouseButton2Click:Connect(function() gui_settings(iden) end)
	return entry
end


-- UI Functionality
local sw = workspace.CurrentCamera.ViewportSize.X
local sh = workspace.CurrentCamera.ViewportSize.Y

cassert(sw > 100, "The screen width (100>".. tostring(sw).. ") is too low and Crystal cannot work with it correctly.")
cassert(sh > 100, "The screen height (100>".. tostring(sh).. ") is too low and Crystal cannot work with it correctly.")

local function hsvToRgb(h, s, v)
	h = h % 360
	s = s / 100
	v = v / 100

	local c = v * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = v - c

	local r, g, b

	if h < 60 then
		r, g, b = c, x, 0
	elseif h < 120 then
		r, g, b = x, c, 0
	elseif h < 180 then
		r, g, b = 0, c, x
	elseif h < 240 then
		r, g, b = 0, x, c
	elseif h < 300 then
		r, g, b = x, 0, c
	else
		r, g, b = c, 0, x
	end

	r = (r + m) 
	g = (g + m)
	b = (b + m)

	return Color3.new(r, g, b)
end

scbox.FocusLost:Connect(function()
	local sc = tonumber(scbox.Text)
	if sc then
		scale.Scale = sc
		canvas.Size = UDim2.fromScale(1 / sc, 1 / sc)
	end
	scbox.Text = ""
end)

for _, m in map do
	local mcategory, mservices = m.Category, m.Services

	local y = 40
	local ui = gui_category(mcategory)

	for _, mservice in mservices do
		y += 28
		if services[mservice].Type == "Toggle" then
			gui_entry(ui.Container, mservice)
		elseif services[mservice].Type == "Button" then
			gui_button(ui.Container, mservice)
		end
	end

	ui.Size = UDim2.fromOffset(250, y)
end

local pc = {}
task.wait()
for i, v in holder:GetChildren() do
	if not v:IsA("Frame") then
		continue
	end

	pc[v.Name] = UDim2.fromOffset(v.AbsolutePosition.X, v.AbsolutePosition.Y)
end

local rainbowLength = 180
local t = 0

local rnss, ine

local function offScreen()
	local x = math.random()
	local y = math.random()
	if x < 0.5 then
		x = -x - 1
	else
		x += 1
	end
	if y < 0.5 then
		y = -y - 1
	else
		y += 1
	end
	return x, y
end

ine = game:GetService('UserInputService').InputBegan:Connect(function(input, gme)
	if gme then
		return
	end

	if input.KeyCode == Enum.KeyCode.M then
		local tt = 0
		
		if holder.BackgroundTransparency == 1 then
			tt = 0.5
			canvas.Visible = true

			for i, v in holder:GetChildren() do
				if v:IsA("Frame") then
					local x, y = offScreen()
					v.Position = UDim2.fromOffset(x * sw, y * sh)
		
					tws:Create(
						v,
						TweenInfo.new(0.3),
						{Position = pc[v.Name]}
					):Play()
				end
			end

			local x, y = offScreen()
			setui.Position = UDim2.fromScale(x, y)
			
			tws:Create(
				setui,
				TweenInfo.new(0.3),
				{Position = UDim2.fromScale(0.5, 0.5)}
			):Play()

			for i, v in {uib1, uib2, scbox} do
				tws:Create(
					v,
					TweenInfo.new(0.3),
					{Position = UDim2.new(
						v.Position.X.Scale,
						v.Position.X.Offset,
						0.2,
						v.Position.Y.Offset
					)}
				):Play()
			end
		elseif holder.BackgroundTransparency == 0.5 then
			tt = 1
			
			for i, v in holder:GetChildren() do
				if v:IsA("Frame") then
					local x, y = offScreen()
					v.Position = pc[v.Name]
		
					tws:Create(
						v,
						TweenInfo.new(0.3),
						{Position = UDim2.fromScale(x, y)}
					):Play()
				end
			end

			local x, y = offScreen()
			setui.Position = UDim2.fromScale(0.5, 0.5)
			
			tws:Create(
				setui,
				TweenInfo.new(0.3),
				{Position = UDim2.fromScale(x, y)}
			):Play()

			layout.Parent = nil

			for i, v in {uib1, uib2, scbox} do
				tws:Create(
					v,
					TweenInfo.new(0.3),
					{Position = UDim2.new(
						v.Position.X.Scale,
						v.Position.X.Offset,
						1,
						v.Position.Y.Offset
					)}
				):Play()
			end
		else
			return
		end
		
		tws:Create(
			holder,
			TweenInfo.new(0.3),
			{BackgroundTransparency = tt}
		):Play()
		tws:Create(
			settings,
			TweenInfo.new(0.3),
			{BackgroundTransparency = tt}
		):Play()

		task.wait(0.3)
		if tt == 1 then
			canvas.Visible = false
		elseif tt == 0.5 then
			layout.Parent = holder
		end
	end
end)

rnss = rns.RenderStepped:Connect(function()
	if not gui.Parent then
		ine:Disconnect()
		rnss:Disconnect()
		for i, v in serviceThreads do
			stopService(i)
		end
		return
	end

	t = (t + 1) % 360

	for _, v in rainbowGradients do
		local cat, grad = v[1], v[2]
		
		local color = ColorSequence.new(
			hsvToRgb((cat.AbsolutePosition.X / sw) * rainbowLength + t, 100, 100),
			hsvToRgb(((cat.AbsolutePosition.X + cat.AbsoluteSize.X) / sw) * rainbowLength + t, 100, 100)
		)
		grad.Color = color
	end

	for _, v in viewport:GetDescendants() do
		if v:IsA("BasePart") then
			v.Color = hsvToRgb(t, 100, 100)
		end
	end

	for _, v in services do
		if v.Type ~= "Toggle" then
			continue
		end
		holder[v.Category].Container[v.Name].Indicator.BackgroundColor3 = if v.Enabled then Color3.new(0, 1, 0) else Color3.new(0, 0, 0)
	end
end)


-- Finish loading
print(("\n\n✨ Crystal loaded in %f ms!\n\n  [❄️] Slap Battles script\n  [✅] Press M to open the menu\n  [⚡] Discord invite: https://discord.gg/DwX6GWWaTt\n\n"):format(tostring(math.floor((os.clock() - start) * 100000) / 100)))

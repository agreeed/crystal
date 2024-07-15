return function(glove)
	local lookup = {
		["Default"] = game:GetService("ReplicatedStorage").b,
		["Extended"] = game:GetService("ReplicatedStorage").b,
		----------------------------------------
		["Diamond"] = game:GetService("ReplicatedStorage").DiamondHit,
		["ZZZZZZZ"] = game:GetService("ReplicatedStorage").ZZZZZZZHit,
		["Brick"] = game:GetService("ReplicatedStorage").BrickHit,
		["Snow"] = game:GetService("ReplicatedStorage").SnowHit,
		["Pull"] = game:GetService("ReplicatedStorage").PullHit,
		["Flash"] = game:GetService("ReplicatedStorage").FlashHit,
		["Spring"] = game:GetService("ReplicatedStorage").springhit,
		["Swapper"] = game:GetService("ReplicatedStorage").HitSwapper,
		["Bull"] = game:GetService("ReplicatedStorage").BullHit,
		["Dice"] = game:GetService("ReplicatedStorage").DiceHit,
		["Ghost"] = game:GetService("ReplicatedStorage").GhostHit,
		["Thanos"] = game:GetService("ReplicatedStorage").ThanosHit,
		["Stun"] = game:GetService("ReplicatedStorage").HtStun,
		["Za Hando"] = game:GetService("ReplicatedStorage").zhramt,
		["Fort"] = game:GetService("ReplicatedStorage").Fort,
		["Magnet"] = game:GetService("ReplicatedStorage").MagnetHIT,
		["Pusher"] = game:GetService("ReplicatedStorage").PusherHit,
		["Anchor"] = game:GetService("ReplicatedStorage").hitAnchor,
		["Space"] = game:GetService("ReplicatedStorage").HtSpace,
		["Boomerang"] = game:GetService("ReplicatedStorage").BoomerangH,
		["Speedrun"] = game:GetService("ReplicatedStorage").Speedrunhit,
		["Mail"] = game:GetService("ReplicatedStorage").MailHit,
		["Golden"] = game:GetService("ReplicatedStorage").GoldenHit,
		["Reaper"] = game:GetService("ReplicatedStorage").ReaperHit,
		["Defense"] = game:GetService("ReplicatedStorage").DefenseHit,
		["Killstreak"] = game:GetService("ReplicatedStorage").KSHit,
		["Reverse"] = game:GetService("ReplicatedStorage").ReverseHit,
		["Shukuchi"] = game:GetService("ReplicatedStorage").ShukuchiHit,
		["Duelist"] = game:GetService("ReplicatedStorage").DuelistHit,
		["Woah"] = game:GetService("ReplicatedStorage").woahHit,
		["Ice"] = game:GetService("ReplicatedStorage").IceHit,
		["Adios"] = game:GetService("ReplicatedStorage").hitAdios,
		["Blocked"] = game:GetService("ReplicatedStorage").BlockedHit,
		["Engineer"] = game:GetService("ReplicatedStorage").engiehit,
		["Rocky"] = game:GetService("ReplicatedStorage").RockyHit,
		["Conveyor"] = game:GetService("ReplicatedStorage").ConvHit,
		["STOP"] = game:GetService("ReplicatedStorage").STOP,
		["Custom"] = game:GetService("ReplicatedStorage").CustomHit,
		["Phantom"] = game:GetService("ReplicatedStorage").PhantomHit,
		["Wormhole"] = game:GetService("ReplicatedStorage").WormHit,
		["Acrobat"] = game:GetService("ReplicatedStorage").AcHit,
		["Plague"] = game:GetService("ReplicatedStorage").PlagueHit,
		["Megarock"] = game:GetService("ReplicatedStorage").DiamondHit,
		["[REDACTED]"] = game:GetService("ReplicatedStorage").ReHit,
		["bus"] = game:GetService("ReplicatedStorage").hitbus,
		["Phase"] = game:GetService("ReplicatedStorage").PhaseH,
		["Warp"] = game:GetService("ReplicatedStorage").WarpHt,
		["Bomb"] = game:GetService("ReplicatedStorage").BombHit,
		["Bubble"] = game:GetService("ReplicatedStorage").BubbleHit,
		["Jet"] = game:GetService("ReplicatedStorage").JetHit,
		["Shard"] = game:GetService("ReplicatedStorage").ShardHIT,
		["potato"] = game:GetService("ReplicatedStorage").potatohit,
		["Cult"] = game:GetService("ReplicatedStorage").CULTHit,
		["bob"] = game:GetService("ReplicatedStorage").bobhit,
		["Buddies"] = game:GetService("ReplicatedStorage").buddiesHIT,
		["Moon"] = game:GetService("ReplicatedStorage").CelestialHit,
		["Jupiter"] = game:GetService("ReplicatedStorage").CelestialHit,
		["Spy"] = game:GetService("ReplicatedStorage").SpyHit,
		["Detonator"] = game:GetService("ReplicatedStorage").DetonatorHit,
		["Rage"] = game:GetService("ReplicatedStorage").GRRRR,
		["Trap"] = game:GetService("ReplicatedStorage").traphi,
		["Orbit"] = game:GetService("ReplicatedStorage").Orbihit,
		["Hybrid"] = game:GetService("ReplicatedStorage").HybridCLAP,
		["Slapple"] = game:GetService("ReplicatedStorage").SlappleHit,
		["Disarm"] = game:GetService("ReplicatedStorage").DisarmH,
		["Dominance"] = game:GetService("ReplicatedStorage").DominanceHit,
		["Nightmare"] = game:GetService("ReplicatedStorage").nightmarehit,
		["rob"] = game:GetService("ReplicatedStorage").robhit,
		["Link"] = game:GetService("ReplicatedStorage").LinkHit,
		["Rhythm"] = game:GetService("ReplicatedStorage").rhythmhit,
		["Hitman"] = game:GetService("ReplicatedStorage").HitmanHit,
		["Rojo"] = game:GetService("ReplicatedStorage").RojoHit,
		["Thor"] = game:GetService("ReplicatedStorage").ThorHit,
		["Cloud"] = game:GetService("ReplicatedStorage").CloudHit,
		["Retro"] = game:GetService("ReplicatedStorage").RetroHit,
		["Null"] = game:GetService("ReplicatedStorage").NullHit,
		----------------------------------------
		["Mitten"] = game:GetService("ReplicatedStorage").MittenHit,
		["Hallow Jack"] = game:GetService("ReplicatedStorage").HallowHIT,
		----------------------------------------
		["Boogie"] = game:GetService("ReplicatedStorage").HtStun,
		["Balloony"] = game:GetService("ReplicatedStorage").HtStun,
		["Kinetic"] = game:GetService("ReplicatedStorage").HtStun,
		----------------------------------------
		["OVERKILL"] = game:GetService("ReplicatedStorage").Overkillhit,
		["The Flex"] = game:GetService("ReplicatedStorage").FlexHit,
		["God's Hand"] = game:GetService("ReplicatedStorage").Godshand,
		["Error"] = game:GetService("ReplicatedStorage").Errorhit
	}

	if not lookup[glove] then
		return game:GetService("ReplicatedStorage").GeneralHit
	else
		return lookup[glove]
	end
end

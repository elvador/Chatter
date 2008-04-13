local mod = Chatter:NewModule("Player Class Colors", "AceHook-3.0", "AceEvent-3.0")
local AceTab = LibStub("AceTab-3.0")

mod.modName = "Player Names"

local L = LibStub("AceLocale-3.0"):GetLocale("Chatter")
local local_names, local_levels = {}, {}
local leftBracket, rightBracket, separator
local gsub = _G.string.gsub
local find = _G.string.find
local pairs = _G.pairs
local string_format = _G.string.format
local GetDifficultyColor = _G.GetDifficultyColor
local lookup = {}
local classes = {"Druid", "Mage", "Paladin", "Priest", "Rogue", "Hunter", "Shaman", "Warlock", "Warrior"}
local channels = {
	GUILD = {},
	PARTY = {},
	RAID = {}
}
local colorMethods = {
	CLASS = "Class",
	NAME = "Name",
	NONE = "None",
}

local defaults = {
	realm = {
		names = {},
		levels = {},
	},
	profile = {
		saveData = false, 
		nameColoring = "CLASS", 
		leftBracket = "[", 
		rightBracket = "]", 
		separator = ":",
		useTabComplete = true
	}
}

local tabComplete
do
	function tabComplete(t, text, pos)
		local word = text:sub(pos)
		if #word == 0 then return end
		local channel = ChatFrameEditBox:GetAttribute("chatType")
		if channel == "CHANNEL" then
			channel = select(2, GetChannelName(ChatFrameEditBox:GetAttribute("channelTarget"))):lower()
		elseif channel == "OFFICER" then
			channel = "GUILD"
		elseif channel == "RAID_WARNING" or channel == "RAID_LEADER" or channel == "BATTLEGROUND" or channel == "BATTLEGROUND_LEADER" then
			channel = "RAID"
		end
		if channels[channel] then
			for k, v in pairs(channels[channel]) do
				if k:lower():match("^" .. word:lower()) then
					tinsert(t, k)
				end
			end
		end
		return t
	end
end

local getNameColor
do
	local sq2 = sqrt(2)
	local pi = _G.math.pi
	local cos = _G.math.cos
	local fmod = _G.math.fmod
	local strbyte = _G.strbyte
	local t = {}
	
	-- http://www.tecgraf.puc-rio.br/~mgattass/color/HSVtoRGB.htm
	local function HSVtoRGB(h, s, v)
		h = h * 6
		local i = floor(h)
		local i1 = v * (1 - s)
		local i2 = v * (1 - s * (h - i))
		local i3 = v * (1 - s * (1 - (h - i)))
		if i == 0 then
			return v, i3, i1
		elseif i == 1 then
			return i2, v, i1
		elseif i == 2 then
			return i1, v, i3
		elseif i == 3 then
			return i3, i2, v
		elseif i == 4 then
			return i3, i1, v
		else
			return v, i1, i2
		end
	end
	
	function getNameColor(name)
		local seed = 5124
		local h, s, v = 1, 1, 1
		local r, g, b
		for i = 1, #name do
			seed = 29 * seed + strbyte(name, i)
		end
		h = fmod(seed, 255) / 255
		
		t.r, t.g, t.b = HSVtoRGB(h, s, v)
		
		return t
	end
end

local names = setmetatable({}, {
	__index = function(t, v)
		local tab = mod.db.realm.names[v] or local_names[v]
		local class, level
		if tab then
			class = tab.class
			level = mod.db.profile.includeLevel and tab.level or nil
		end
		local coloring = mod.db.profile.nameColoring
		local dLevel
		if mod.db.profile.levelByDiff and level and (level ~= 70 or not mod.db.profile.excludeSeventies) then
			local c = GetDifficultyColor(level)
			dLevel = ("|cff%02x%02x%02x%s|r"):format(c.r * 255, c.g * 255, c.b * 255, level)
		elseif level and (level ~= 70 or not mod.db.profile.excludeSeventies) then
			dLevel = level
		end
		if coloring ~= "NONE" then
			local c
			if coloring == "CLASS" then
				c = RAID_CLASS_COLORS[class] or nil
			elseif coloring == "NAME" then
				c = getNameColor(v)
			end
			if c then
				t[v] = ("|cff%02x%02x%02x%s%s%s|r"):format(c.r * 255, c.g * 255, c.b * 255, v, dLevel and ":" or "", dLevel or "")
			else
				t[v] = string_format("|cffa0a0a0%s%s%s|r", v, dLevel and ":" or "", dLevel or "")
			end
		else
			t[v] = string_format("%s%s%s", v, dLevel and ":" or "", dLevel or "")
		end
		return t[v]
	end
})

local function updateSaveData(v)
	if v then
		for k, v in pairs(local_names) do
			mod.db.realm.names[k] = v
		end
	else
		for k, v in pairs(mod.db.realm.names) do
			local_names[k] = v
		end
	end
end

local options = {
	save = {
		type = "group",
		name = "Save Data",
		desc = "Save data between sessions. Will increase memory usage",
		args = {
			guild = {
				type = "toggle",
				name = "Guild",
				desc = "Save class data from guild between sessions.",
				get = function()
					return mod.db.profile.saveGuild
				end,
				set = function(info, v)
					mod.db.profile.saveGuild = v
					updateSaveData(v)
				end
			},
			group = {
				type = "toggle",
				name = "Group",
				desc = "Save class data from groups between sessions.",
				get = function()
					return mod.db.profile.saveGroup
				end,
				set = function(info, v)
					mod.db.profile.saveGroup = v
					updateSaveData(v)
				end
			},
			target = {
				type = "toggle",
				name = "Target/Mouseover",
				desc = "Save class data from target/mouseover between sessions.",
				get = function()
					return mod.db.profile.saveTarget
				end,
				set = function(info, v)
					mod.db.profile.saveTarget = v
					updateSaveData(v)
				end
			},
			who = {
				type = "toggle",
				name = "Who",
				desc = "Save class data from /who queries between sessions.",
				get = function()
					return mod.db.profile.saveWho
				end,
				set = function(info, v)
					mod.db.profile.saveWho = v
					updateSaveData(v)
				end
			},
			resetDB = {
				type = "execute",
				name = "Reset Data",
				desc = "Destroys all your saved class/level data",
				func = function()
					for k, v in pairs(mod.db.realm.names) do
						mod.db.realm.names = nil
					end
				end,
				order = 101,
				confirm = function() return "Are you sure you want to delete all your saved class/level data?" end
			}
		}
	},
	leftbracket = {
		type = "input",
		name = "Left Bracket",
		desc = "Character to use for the left bracket",
		get = function() return mod.db.profile.leftBracket end,
		set = function(i, v)
			mod.db.profile.leftBracket = v
			leftBracket = v
		end
	},
	rightbracket = {
		type = "input",
		name = "Right Bracket",
		desc = "Character to use for the right bracket",
		get = function() return mod.db.profile.rightBracket end,
		set = function(i, v)
			mod.db.profile.rightBracket = v
			rightBracket = v
		end
	},	
	separator = {
		type = "input",
		name = "Separator",
		desc = "Character to use for the separator",
		get = function() return mod.db.profile.separator end,
		set = function(i, v)
			mod.db.profile.separator = v
			separator = v
		end
	},
	useTabComplete = {
		type = "toggle",
		name = "Use Tab Complete",
		desc = "Use tab key to automatically complete character names.",
		get = function() return mod.db.profile.useTabComplete end,
		set = function(info, v)
			mod.db.profile.useTabComplete = v
			if v and not AceTab:IsTabCompletionRegistered("Chatter") then
				AceTab:RegisterTabCompletion("Chatter", nil, tabComplete)
			elseif not v and AceTab:IsTabCompletionRegistered("Chatter") then
				AceTab:UnregisterTabCompletion("Chatter")
			end
		end
	},
	levelHeader = {
		type = "header",
		name = "Level Options",
		order = 104
	},
	includeLevel = {
		type = "toggle",
		name = "Include level",
		desc = "Include the player's level",
		order = 105,
		get = function() return mod.db.profile.includeLevel end,
		set = function(info, val)
			mod.db.profile.includeLevel = val
			for k, v in pairs(names) do
				names[k] = nil
			end
		end
	},
	excludeSeventies = {
		type = "toggle",
		name = "Exclude Level 70s",
		desc = "Exclude level display for level 70s",
		order = 105,
		get = function() return mod.db.profile.excludeSeventies end,
		set = function(info, val)
			mod.db.profile.excludeSeventies = val
			for k, v in pairs(names) do
				names[k] = nil
			end
		end
	},
	colorLevelByDifficulty = {
		type = "toggle",
		name = "Color level by difficulty",
		desc = "Color level by difficulty",
		order = 105,
		get = function()
			return mod.db.profile.levelByDiff
		end,
		set = function(info, v)
			mod.db.profile.levelByDiff = v
			for k, v in pairs(names) do
				names[k] = nil
			end
		end
	},
	colorBy = {
		type = "select",
		name = "Color Player Names By...",
		desc = "Select a method for coloring player names",
		values = colorMethods,
		get = function() return mod.db.profile.nameColoring end,
		set = function(info, val)
			mod.db.profile.nameColoring = val
			for k, v in pairs(names) do
				names[k] = nil
			end
		end
	}
}

function mod:OnInitialize()
	for i = 1, #classes do
		lookup[L[classes[i]]] = classes[i]:upper()
	end
	
	self.db = Chatter.db:RegisterNamespace("PlayerNames", defaults)
	for k, v in pairs(self.db.realm.names) do
		if type(v) == "string" then
			self.db.realm.names[k] = {class = v}
		end
	end
	
	
	if self.db.global and self.db.global.names then
		self.db.global.names = nil	-- get rid of old data
	end
end

function mod:OnEnable()
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("WHO_LIST_UPDATE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("FRIENDLIST_UPDATE")
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
	self:RegisterEvent("CHAT_MSG_CHANNEL_JOIN")
	self:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE")
	self:RegisterEvent("CHAT_MSG_CHANNEL", "CHAT_MSG_CHANNEL_JOIN")
	
	leftBracket, rightBracket, separator = self.db.profile.leftBracket, self.db.profile.rightBracket, self.db.profile.separator
	GuildRoster()

	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		if cf ~= COMBATLOG then
			self:RawHook(cf, "AddMessage", true)
		end
	end
	self:RAID_ROSTER_UPDATE()
	self:PARTY_MEMBERS_CHANGED()
	if self.db.profile.useTabComplete then
		AceTab:RegisterTabCompletion("Chatter", nil, tabComplete)
	end
end

function mod:OnDisable()
	if AceTab:IsTabCompletionRegistered("Chatter") then
		AceTab:UnregisterTabCompletion("Chatter")
	end
end

function mod:AddPlayer(name, class, level, save)
	if name and class and class ~= "UNKNOWN" then
		if save then
			self.db.realm.names[name] = self.db.realm.names[name] or {}
			self.db.realm.names[name].class = class
			if level and level ~= 0 then
				self.db.realm.names[name].level = level
			end
		else
			local_names[name] = local_names[name] or {}
			local_names[name].class = class
			if level and level ~= 0 then
				local_names[name].level = level
			end
		end
		names[name] = nil
	end
end

function mod:FRIENDLIST_UPDATE(evt)
	for i = 1, GetNumFriends() do
		local name, level, class = GetFriendInfo(i)
		if class then
			self:AddPlayer(name, lookup[class], level, self.db.profile.saveFriends)
		end
	end
end

function mod:GUILD_ROSTER_UPDATE(evt)
	local n = GetNumGuildMembers()
	if not n or n == 0 then
		return
	end

	local offline = GetGuildRosterShowOffline()
	local selection = GetGuildRosterSelection()
	self:UnregisterEvent("GUILD_ROSTER_UPDATE")
	
	SetGuildRosterShowOffline(true)
	SetGuildRosterSelection(0)
	GetGuildRosterInfo(0)
	n = GetNumGuildMembers()
	for k, v in pairs(channels.GUILD) do
		channels.GUILD[k] = nil
	end
	for i = 1, n do
		local name, _, _, level, _, _, _, _, online, _, class = GetGuildRosterInfo(i)
		if online then
			channels.GUILD[name] = name
		end
		self:AddPlayer(name, class, level, self.db.profile.saveGuild)
	end
	SetGuildRosterShowOffline(offline)
	SetGuildRosterSelection(selection)
	
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
end


function mod:RAID_ROSTER_UPDATE(evt)
	for k, v in pairs(channels.RAID) do
		channels.RAID[k] = nil
	end

	for i = 1, GetNumRaidMembers() do
		local n, _, _, l, _, c = GetRaidRosterInfo(i)
		if n and c and l then
			channels.RAID[n] = true
			self:AddPlayer(n, c, l, self.db.profile.saveParty)
		end
	end
end

function mod:PARTY_MEMBERS_CHANGED(evt)
	for k, v in pairs(channels.PARTY) do
		channels.PARTY[k] = nil
	end
	
	for i = 1, GetNumPartyMembers() do
		local n = UnitName("party" .. i)
		local _, c = UnitClass("party" .. i)
		local l = UnitLevel("party" .. i)
		channels.PARTY[n] = true
		self:AddPlayer(n, c, l, self.db.profile.saveParty)
	end
end

function mod:PLAYER_TARGET_CHANGED(evt)
	if not UnitExists("target") or not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then return end
	local _, cls = UnitClass("target")
	local l = UnitLevel("target")
	self:AddPlayer(UnitName("target"), cls, l, self.db.profile.saveTarget)
end

function mod:UPDATE_MOUSEOVER_UNIT(evt)
	if not UnitExists("mouseover") or not UnitIsPlayer("mouseover") or not UnitIsFriend("player", "mouseover") then return end
	local _, cls = UnitClass("mouseover")
	local l = UnitLevel("mouseover")
	self:AddPlayer(UnitName("mouseover"), cls, l, self.db.profile.saveTarget)
end

function mod:CHAT_MSG_SYSTEM(evt, msg)
	local name, level, class = select(3, msg:find("^|Hplayer:%w+|h%[(%w+)%]|h: %w+ (%d+) %w+ (%w+)"))
	if name and class then
		self:AddPlayer(name, lookup[class], level)
	end
end

function mod:WHO_LIST_UPDATE(evt)
	for i = 1, GetNumWhoResults() do
		local name, _, level, _, class = GetWhoInfo(i)
		if class then
			self:AddPlayer(name, lookup[class], level, self.db.profile.saveWho)
		end
	end
end

function mod:CHAT_MSG_CHANNEL_JOIN(evt, _, name, _, _, _, _, _, _, chan)
	channels[chan:lower()] = channels[chan:lower()] or {}
	channels[chan:lower()][name] = true
end

function mod:CHAT_MSG_CHANNEL_LEAVE(evt, _, name, _, _, _, _, _, _, chan)
	if not channels[chan:lower()] then return end
	channels[chan:lower()][name] = nil
end

local function changeName(name, name2, sep)
	return "|h" .. leftBracket .. names[name2] .. rightBracket .. "|h" .. (sep and #sep > 0 and separator or "")
end

function mod:AddMessage(frame, text, ...)
	if not text then 
		return self.hooks[frame].AddMessage(frame, text, ...)
	end

	local name = arg2
	if event == "CHAT_MSG_SYSTEM" then name = text:match("|h%[([^%]]+)%]|h") end
	if name and type(name) == "string" then
		text = text:gsub("|h(%[("..name..")%])|h(:?)", changeName)
	end
	return self.hooks[frame].AddMessage(frame, text, ...)
end

function mod:Info()
	return "Provides options to color player names, add player levels, and add tab completion of player names."
end

function mod:GetOptions()
	return options
end

mod.names = names

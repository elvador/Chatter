local mod = Chatterbox:NewModule("Justify Text")
mod.toggleLabel = "Enable text justification"

local defaults = {
	profile = {}
}

local VALID_JUSTIFICATIONS = {
	LEFT = "Left",
	RIGHT = "Right",
	CENTER = "Center"
}

local options = {}
function mod:OnInitialize()
	self.db = Chatterbox.db:RegisterNamespace("JustifyText", defaults)
	for i = 1, NUM_CHAT_WINDOWS do
		local s = "FRAME_" .. i
		local f = _G["ChatFrame" .. i]
		options[s] = {
			type = "select",
			name = "Chat Frame " .. i,
			desc = "Chat Frame " .. i,
			values = VALID_JUSTIFICATIONS,
			get = function() return self.db.profile[s] or "LEFT" end,
			set = function(info, v)
				self.db.profile[s] = v
				f:SetJustifyH(v)
			end
		}
	end
end

function mod:OnEnable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetJustifyH(self.db.profile["FRAME_" .. i] or "LEFT")
	end
end

function mod:OnDisable()
	for i = 1, NUM_CHAT_WINDOWS do
		local cf = _G["ChatFrame" .. i]
		cf:SetJustifyH("LEFT")
	end
end

function mod:GetOptions()
	return options
end

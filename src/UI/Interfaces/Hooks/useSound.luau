local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local useCallback = React.useCallback

local function useSound(name: string): () -> ()
	local sound: Sound
	-- TODO: fetch sound asset

	return useCallback(function()
		if sound then
			sound:Play()
		end
	end, { name })
end

return useSound

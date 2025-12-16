-- [[
-- Similar to Roblox's BasePart.LocalTransparencyModifier, this hook returns
-- a new transparency binding modified from an input transparency and a modifier value

-- ex: local useModifiedTransparency = useTransparencyModifier(props.TransparencyModifier)
--     local backgroundTransparency = useModifiedTransparency(props.BackgroundTransparency)
-- ]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)

export type Binding<T> = useSingleTransparencyModifier.Binding<T>
export type TransparencyBinding = useSingleTransparencyModifier.TransparencyBinding
export type TransparencyValue = useSingleTransparencyModifier.TransparencyValue

local function useTransparencyModifier(modifier: TransparencyValue?): (TransparencyValue) -> TransparencyBinding
	return function(transparency: TransparencyValue): TransparencyBinding
		return useSingleTransparencyModifier(transparency, modifier)
	end
end

return useTransparencyModifier

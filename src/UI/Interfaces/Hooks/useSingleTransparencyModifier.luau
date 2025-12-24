-- [[
-- Similar to Roblox's BasePart.LocalTransparencyModifier, this hook returns
-- a new transparency binding modified from an input transparency and a modifier value

-- ex: local backgroundTransparency = useSingleTransparencyModifier(props.BackgroundTransparency, 0.5)
-- ]]

local EPSILON = 1e-2

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks
local Utilities = ReplicatedStorage.UI.Utilities

local React = require(Libraries.React)

local isReactBinding = require(Utilities.isReactBinding)
local useBindingEffect = require(Hooks.useBindingEffect)

local useBinding = React.useBinding

export type Binding<T> = React.Binding<T>
export type TransparencyBinding = Binding<number | NumberSequence>
export type TransparencyValue = number | NumberSequence | TransparencyBinding | nil

local function modifyNumberTransparency(modifier: number, transparency: number): number
	local value = 1 - ((1 - transparency) * (1 - modifier))

	-- clamp and round to 0 or 1
	if value < EPSILON then
		return 0
	elseif value > 1 - EPSILON then
		return 1
	end

	return value
end

local function modifyNumberSequenceTransparency(modifier: number, sequence: NumberSequence): NumberSequence
	local keypoints = table.create(#sequence.Keypoints)

	for i, keypoint in sequence.Keypoints do
		keypoints[i] = NumberSequenceKeypoint.new(
			keypoint.Time,
			modifyNumberTransparency(modifier, keypoint.Value),
			keypoint.Envelope
		)
	end

	return NumberSequence.new(keypoints)
end

local function useSingleTransparencyModifier(
	transparency: TransparencyValue,
	modifier: TransparencyValue?
): TransparencyBinding
	local isModifierBinding = isReactBinding(modifier)
	local isTransparencyBinding = isReactBinding(transparency)

	local baseTransparency: TransparencyValue = if isTransparencyBinding
		then (transparency :: TransparencyBinding):getValue()
		else transparency or 0

	local modifierDependency = if isModifierBinding then modifier :: TransparencyBinding else useBinding(modifier)
	local transparencyDependency = if isTransparencyBinding
		then transparency :: TransparencyBinding
		else useBinding(transparency)

	local modifiedTransparency, updateModifiedTransparency = useBinding(baseTransparency)

	useBindingEffect(function(modifierValue: number?, transparencyValue: TransparencyValue?)
		transparencyValue = transparencyValue or baseTransparency

		if modifierValue then
			if typeof(transparencyValue) == "number" then
				updateModifiedTransparency(modifyNumberTransparency(modifierValue, transparencyValue))
			elseif typeof(transparencyValue) == "NumberSequence" then
				updateModifiedTransparency(modifyNumberSequenceTransparency(modifierValue, transparencyValue))
			end
		else
			updateModifiedTransparency(transparencyValue)
		end
	end, { modifierDependency, transparencyDependency }, {
		baseTransparency,
	})

	return modifiedTransparency :: TransparencyBinding
end

return useSingleTransparencyModifier

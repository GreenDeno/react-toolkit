local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)
local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)

local createElement = React.createElement

export type Props = {
	GradientColor: React.PropBinding<ColorSequence>?,
	GradientRotation: React.PropBinding<number>?,
	GradientOffset: React.PropBinding<Vector2>?,
	GradientTransparency: React.PropBinding<NumberSequence>?,

	Transparency: useSingleTransparencyModifier.TransparencyValue?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.GradientColor ~= nil or props.GradientTransparency ~= nil
	end,
	element = function(props: Props)
		local gradientTransparency = useSingleTransparencyModifier(
			props.GradientTransparency or Constants.DEFAULTS.BACKGROUND_GRADIENT_TRANSPARENCY,
			props.Transparency
		)

		return createElement("UIGradient", {
			Color = props.GradientColor,
			Rotation = props.GradientRotation,
			Offset = props.GradientOffset,
			Transparency = gradientTransparency,
		})
	end,
}

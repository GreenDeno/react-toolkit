local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)
local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)

local createElement = React.createElement

export type Props = {
	StrokeColor: React.PropBinding<Color3>?,
	StrokeThickness: React.PropBinding<number>?,
	StrokeTransparency: React.PropBinding<number>?,
	StrokeGradientColor: React.PropBinding<ColorSequence>?,
	StrokeGradientRotation: React.PropBinding<number>?,
	StrokeGradientOffset: React.PropBinding<Vector2>?,
	StrokeGradientTransparency: React.PropBinding<NumberSequence>?,

	Transparency: useSingleTransparencyModifier.TransparencyValue?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.StrokeColor ~= nil or props.StrokeThickness ~= nil or props.StrokeTransparency ~= nil
	end,
	element = function(props: Props)
		local hasStrokeGradient = props.StrokeGradientColor ~= nil or props.StrokeGradientTransparency ~= nil

		local strokeTransparency = useSingleTransparencyModifier(
			props.StrokeTransparency or Constants.DEFAULTS.STROKE_TRANSPARENCY,
			props.Transparency
		)
		local strokeGradientTransparency = useSingleTransparencyModifier(
			props.StrokeGradientTransparency or Constants.DEFAULTS.STROKE_GRADIENT_TRANSPARENCY,
			props.Transparency
		)

		return createElement("UIStroke", {
			Color = props.StrokeColor,
			Thickness = props.StrokeThickness,
			Transparency = strokeTransparency,
		}, {
			uiGradient = hasStrokeGradient and createElement("UIGradient", {
				Offset = props.StrokeGradientOffset,
				Color = props.StrokeGradientColor,
				Rotation = props.StrokeGradientRotation,
				Transparency = strokeGradientTransparency,
			}),
		})
	end,
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)

local Constraints = script.Parent.Constraints
local TextConstraints = require(Constraints.TextConstraints)

local useTransparencyModifier = require(Hooks.useTransparencyModifier)
local createElement = React.createElement

type PropBinding<T> = React.PropBinding<T>

return function(props: {
	Size: PropBinding<UDim2>?,
	Position: PropBinding<UDim2>?,
	AnchorPoint: PropBinding<Vector2>?,

	BackgroundTransparency: PropBinding<number>?,
	BackgroundColor3: PropBinding<Color3>?,

	Visible: PropBinding<boolean>?,
	Rotation: PropBinding<number>?,
	ZIndex: PropBinding<number>?,
	LayoutOrder: PropBinding<number>?,
	AutomaticSize: PropBinding<Enum.AutomaticSize>?,

	TextScaled: PropBinding<boolean>?,
	TextWrapped: PropBinding<boolean>?,
	TextTruncate: PropBinding<Enum.TextTruncate>?,
	TextSize: PropBinding<number>?,
	TextTransparency: PropBinding<number>?,
	Text: PropBinding<string>?,
	TextColor3: PropBinding<Color3>?,
	TextXAlignment: PropBinding<Enum.TextXAlignment>?,
	TextYAlignment: PropBinding<Enum.TextYAlignment>?,
	RichText: PropBinding<boolean>?,
	Font: string?,
	FontWeight: Enum.FontWeight?,

	Transparency: useTransparencyModifier.TransparencyValue?,
	children: { [any]: any }?,
} & TextConstraints.Props)
	-- Configs
	local hasTextFont = props.Font ~= nil or props.FontWeight ~= nil

	-- Transparency Modifiers
	local useModifiedTransparency = useTransparencyModifier(props.Transparency)

	local backgroundTransparency =
		useModifiedTransparency(props.BackgroundTransparency or Constants.DEFAULTS.BACKGROUND_TRANSPARENCY)
	local textTransparency = useModifiedTransparency(props.TextTransparency)

	-- Render Component
	return createElement("TextLabel", {
		Size = props.Size or Constants.DEFAULTS.SIZE,
		Position = props.Position or Constants.DEFAULTS.POSITION,
		AnchorPoint = props.AnchorPoint or Constants.DEFAULTS.ANCHOR_POINT,

		BackgroundTransparency = backgroundTransparency,
		BackgroundColor3 = props.BackgroundColor3 or Constants.DEFAULTS.BACKGROUND_COLOR3,

		Visible = props.Visible,
		Rotation = props.Rotation,
		ZIndex = props.ZIndex,

		LayoutOrder = props.LayoutOrder,
		AutomaticSize = props.AutomaticSize,

		TextScaled = props.TextScaled ~= false,
		TextWrapped = props.TextWrapped,
		TextTruncate = props.TextTruncate,

		TextSize = props.TextSize,
		TextTransparency = textTransparency,

		Text = props.Text or "",
		TextColor3 = props.TextColor3 or Constants.DEFAULTS.TEXT_COLOR3,

		TextXAlignment = props.TextXAlignment or Constants.DEFAULTS.TEXT_XALIGNMENT,
		TextYAlignment = props.TextYAlignment or Constants.DEFAULTS.TEXT_YALIGNMENT,

		RichText = props.RichText,
		Font = not hasTextFont and Enum.Font.Roboto or nil,
		FontFace = hasTextFont and Font.fromName(
			props.Font or Constants.DEFAULTS.TEXT_FONT_FACE,
			props.FontWeight or Constants.DEFAULTS.TEXT_FONT_WEIGHT
		) or nil,

		[React.Change.AbsoluteSize] = props[React.Change.AbsoluteSize],
		[React.Change.AbsolutePosition] = props[React.Change.AbsolutePosition],
	}, {
		children = createElement(React.Fragment, {}, props.children),
		constraints = createElement(TextConstraints, props),
	})
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)

local Constraints = script.Parent.Constraints
local ContainerConstraints = require(Constraints.ContainerConstraints)

local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)
local createElement = React.createElement

type PropBinding<T> = React.PropBinding<T>

return function(props: {
	Size: PropBinding<UDim2>?,
	Position: PropBinding<UDim2>?,
	AnchorPoint: PropBinding<Vector2>?,

	BackgroundTransparency: PropBinding<number>?,
	BackgroundColor3: PropBinding<Color3>?,
	BorderSizePixel: PropBinding<number>?,

	Active: PropBinding<boolean>?,
	Visible: PropBinding<boolean>?,
	ClipsDescendants: PropBinding<boolean>?,
	Rotation: PropBinding<number>?,
	ZIndex: PropBinding<number>?,
	LayoutOrder: PropBinding<number>?,
	AutomaticSize: PropBinding<Enum.AutomaticSize>?,

	Transparency: useSingleTransparencyModifier.TransparencyValue?,
	reference: any?,

	children: { [any]: any }?,
} & ContainerConstraints.ButtonConstraints)
	-- Transparency Modifiers
	local backgroundTransparency = useSingleTransparencyModifier(
		props.BackgroundTransparency or Constants.DEFAULTS.BACKGROUND_TRANSPARENCY,
		props.Transparency
	)

	-- Render Component
	return createElement("Frame", {
		Size = props.Size or Constants.DEFAULTS.SIZE,
		Position = props.Position or Constants.DEFAULTS.POSITION,
		AnchorPoint = props.AnchorPoint or Constants.DEFAULTS.ANCHOR_POINT,

		BackgroundTransparency = backgroundTransparency,
		BackgroundColor3 = props.BackgroundColor3 or Constants.DEFAULTS.BACKGROUND_COLOR3,
		BorderSizePixel = props.BorderSizePixel or Constants.DEFAULTS.BACKGROUND_BORDER_SIZE_PIXEL,

		Active = props.Active,
		Visible = props.Visible,
		ClipsDescendants = props.ClipsDescendants,

		Rotation = props.Rotation,
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,

		AutomaticSize = props.AutomaticSize,

		ref = props.reference,

		[React.Change.AbsoluteSize] = props[React.Change.AbsoluteSize],

		[React.Event.MouseEnter] = props[React.Event.MouseEnter],
		[React.Event.MouseLeave] = props[React.Event.MouseLeave],
	}, {
		children = createElement(React.Fragment, {}, props.children),
		constraints = createElement(ContainerConstraints, props),
	})
end

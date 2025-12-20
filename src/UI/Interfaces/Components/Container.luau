local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)

local Constraints = script.Parent.Constraints
local ContainerConstraints = require(Constraints.ContainerConstraints)

local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)
local createElement = React.createElement

type Bindable<T> = React.Bindable<T>

return function(props: {
	Size: Bindable<UDim2>?,
	Position: Bindable<UDim2>?,
	AnchorPoint: Bindable<Vector2>?,

	BackgroundTransparency: Bindable<number>?,
	BackgroundColor3: Bindable<Color3>?,
	BorderSizePixel: Bindable<number>?,

	Active: Bindable<boolean>?,
	Visible: Bindable<boolean>?,
	ClipsDescendants: Bindable<boolean>?,
	Rotation: Bindable<number>?,
	ZIndex: Bindable<number>?,
	LayoutOrder: Bindable<number>?,
	AutomaticSize: Bindable<Enum.AutomaticSize>?,

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

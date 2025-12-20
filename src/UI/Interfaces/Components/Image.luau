local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)

local Constraints = script.Parent.Constraints
local ImageConstraints = require(Constraints.ImageConstraints)

local useTransparencyModifier = require(Hooks.useTransparencyModifier)
local createElement = React.createElement

type Bindable<T> = React.Bindable<T>

return function(props: {
	Size: Bindable<UDim2>?,
	Position: Bindable<UDim2>?,
	AnchorPoint: Bindable<Vector2>?,

	BackgroundTransparency: Bindable<number>?,
	BackgroundColor3: Bindable<Color3>?,

	Visible: Bindable<boolean>?,
	Rotation: Bindable<number>?,
	ZIndex: Bindable<number>?,
	LayoutOrder: Bindable<number>?,
	Selectable: Bindable<boolean>?,

	Image: Bindable<string>,
	ImageColor3: Bindable<Color3>?,
	ImageTransparency: Bindable<number>?,
	ScaleType: Bindable<Enum.ScaleType>?,
	SliceCenter: Bindable<Rect>?,
	ImageRectOffset: Bindable<Vector2>?,
	ImageRectSize: Bindable<Vector2>?,

	Transparency: useTransparencyModifier.TransparencyValue?,
	children: { [any]: any }?,
} & ImageConstraints.Props)
	-- Transparency Modifiers
	local useModifiedTransparency = useTransparencyModifier(props.Transparency)

	local backgroundTransparency =
		useModifiedTransparency(props.BackgroundTransparency or Constants.DEFAULTS.BACKGROUND_TRANSPARENCY)
	local imageTransparency = useModifiedTransparency(props.ImageTransparency)

	-- Render Component
	return createElement("ImageLabel", {
		Size = props.Size or Constants.DEFAULTS.SIZE,
		Position = props.Position or Constants.DEFAULTS.POSITION,
		AnchorPoint = props.AnchorPoint or Constants.DEFAULTS.ANCHOR_POINT,

		BackgroundTransparency = backgroundTransparency,

		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,
		Rotation = props.Rotation,
		ZIndex = props.ZIndex,
		Selectable = props.Selectable,

		Image = props.Image,
		ImageColor3 = props.ImageColor3 or Constants.DEFAULTS.IMAGE_COLOR3,
		ImageTransparency = imageTransparency,

		ScaleType = props.ScaleType,
		SliceCenter = props.SliceCenter,

		ImageRectOffset = props.ImageRectOffset,
		ImageRectSize = props.ImageRectSize,

		[React.Event.MouseEnter] = props[React.Event.MouseEnter],
		[React.Event.MouseLeave] = props[React.Event.MouseLeave],
	}, {
		children = createElement(React.Fragment, {}, props.children),
		constraints = createElement(ImageConstraints, props),
	})
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local Hooks = ReplicatedStorage.UI.Interfaces.Hooks
local Components = ReplicatedStorage.UI.Interfaces.Components

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)
local ReactFlow = require(Libraries.ReactFlow)

local Constraints = script.Parent.Constraints
local ButtonConstraints = require(Constraints.ButtonConstraints)

local Image = require(Components.Image)
local Text = require(Components.Text)

local useDebounce = require(Hooks.useDebounce)
local useSingleTransparencyModifier = require(Hooks.useSingleTransparencyModifier)
local useSound = require(Hooks.useSound)

local createElement = React.createElement
local useSpring = ReactFlow.useSpring

type PropBinding<T> = React.PropBinding<T>

return function(props: {
	Size: PropBinding<UDim2>?,
	Position: PropBinding<UDim2>?,
	AnchorPoint: PropBinding<Vector2>?,

	ContentSize: PropBinding<UDim2>?,
	ContentPosition: PropBinding<UDim2>?,
	ContentAnchorPoint: PropBinding<Vector2>?,

	BackgroundTransparency: PropBinding<number>?,
	BackgroundColor3: PropBinding<Color3>?,

	Active: boolean?,
	Visible: PropBinding<boolean>?,
	ClipsDescendants: PropBinding<boolean>?,
	Rotation: PropBinding<number>?,
	ZIndex: PropBinding<number>?,
	LayoutOrder: PropBinding<number>?,

	Selectable: boolean?,
	Modal: boolean?,

	Text: string?,
	TextSize: PropBinding<Vector2>?,
	TextPosition: PropBinding<UDim2>?,
	TextAnchorPoint: PropBinding<Vector2>?,
	TextZIndex: PropBinding<number>?,
	TextColor3: PropBinding<Color3>?,
	TextTransparency: PropBinding<number>?,
	TextXAlignment: PropBinding<Enum.TextXAlignment>?,
	TextYAlignment: PropBinding<Enum.TextYAlignment>?,
	TextFontWeight: PropBinding<Enum.FontWeight>?,
	TextStrokeColor: PropBinding<Color3>?,
	TextStrokeThickness: PropBinding<number>?,
	TextStrokeTransparency: PropBinding<number>?,
	TextStrokeMode: PropBinding<Enum.ApplyStrokeMode>?,
	TextStrokeLineJoinMode: PropBinding<Enum.LineJoinMode>?,

	Image: string?,
	ImageSize: PropBinding<UDim2>?,
	ImagePosition: PropBinding<UDim2>?,
	ImageAnchorPoint: PropBinding<Vector2>?,
	ImageRotation: PropBinding<number>?,
	ImageZIndex: PropBinding<number>?,
	ImageColor3: PropBinding<Color3>?,
	ImageTransparency: PropBinding<number>?,
	ImageScaleType: Enum.ScaleType?,
	ImageSliceCenter: Rect?,
	ImageRectOffset: Vector2?,
	ImageRectSize: Vector2?,

	AutoButtonAnimate: boolean?,
	HoverScaleSize: number?,
	DepressScaleSize: number?,

	HoverSound: string?,
	PressSound: string?,
	ClickDebounce: number?,

	AspectRatio: number?,
	Transparency: useSingleTransparencyModifier.TransparencyValue?,

	children: { [any]: any }?,
} & ButtonConstraints.Props)
	-- Configs
	local hasText = props.Text ~= nil
	local hasImage = props.Image ~= nil
	local hasAspectRatio = props.AspectRatio ~= nil
	local hasEventAnimations = props.AutoButtonAnimate ~= false

	-- Animation Configs
	local hoverScaleSize = props.HoverScaleSize or Constants.DEFAULTS.BUTTON_HOVER_SIZE_SCALE
	local depressScaleSize = props.DepressScaleSize or Constants.DEFAULTS.BUTTON_DEPRESS_SIZE_SCALE

	local buttonScaleSpring, updateButtonScaleSpring = useSpring({ start = 1, speed = 30, damper = 0.7 })

	-- Events
	local hasDebounce = props.ClickDebounce and useDebounce(props.ClickDebounce)

	local playHoverSound = props.HoverSound and useSound(props.HoverSound)
	local playPressSound = props.PressSound and useSound(props.PressSound)

	local function onMouseDown()
		if hasEventAnimations then
			updateButtonScaleSpring({ target = depressScaleSize })
		end

		if props[React.Event.MouseButton1Down] then
			props[React.Event.MouseButton1Down]()
		end
	end

	local function onMouseUp()
		if hasEventAnimations then
			updateButtonScaleSpring({ target = hoverScaleSize })
		end

		if playPressSound then
			playPressSound()
		end

		if props[React.Event.MouseButton1Up] then
			props[React.Event.MouseButton1Up]()
		end
	end

	local function onMouseEnter()
		if hasEventAnimations then
			updateButtonScaleSpring({ target = hoverScaleSize })
		end

		if playHoverSound then
			playHoverSound()
		end

		if props[React.Event.MouseEnter] then
			props[React.Event.MouseEnter]()
		end
	end

	local function onMouseLeave()
		if hasEventAnimations then
			updateButtonScaleSpring({ target = 1 })
		end

		if props[React.Event.MouseLeave] then
			props[React.Event.MouseLeave]()
		end
	end

	-- Transparency Modifiers
	local backgroundTransparency = useSingleTransparencyModifier(props.BackgroundTransparency, props.Transparency)

	-- Render Component
	return createElement("TextButton", {
		Size = props.Size or Constants.DEFAULTS.SIZE,
		Position = props.Position or Constants.DEFAULTS.POSITION,
		AnchorPoint = props.AnchorPoint or Constants.DEFAULTS.ANCHOR_POINT,

		BackgroundTransparency = 1,

		Active = props.Active,
		Visible = props.Visible,
		Rotation = props.Rotation,

		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,

		Selectable = props.Selectable,
		Modal = props.Modal,

		Text = "",
		AutoButtonColor = false,

		[React.Event.Activated] = function()
			if props[React.Event.Activated] then
				if not hasDebounce or hasDebounce() then
					props[React.Event.Activated]()
				end
			end
		end,

		[React.Event.MouseButton1Down] = onMouseDown,
		[React.Event.MouseButton1Up] = onMouseUp,

		[React.Event.MouseEnter] = onMouseEnter,
		[React.Event.MouseLeave] = onMouseLeave,

		[React.Event.SelectionGained] = onMouseEnter,
		[React.Event.SelectionLost] = onMouseLeave,
	}, {
		buttonContainer = createElement("Frame", {
			Size = props.ContentSize or UDim2.fromScale(1, 1),
			Position = props.ContentPosition or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = props.ContentAnchorPoint or Vector2.new(0.5, 0.5),

			BackgroundTransparency = backgroundTransparency,
			BackgroundColor3 = props.BackgroundColor3 or Constants.DEFAULTS.BACKGROUND_COLOR3,
			BorderSizePixel = 0,

			ClipsDescendants = props.ClipsDescendants,
		}, {
			textLabel = hasText and createElement(
				Text,
				{
					Size = props.TextSize,
					Position = props.TextPosition,
					AnchorPoint = props.TextAnchorPoint,

					ZIndex = props.TextZIndex or 2,

					Text = props.Text,
					TextColor3 = props.TextColor3,
					TextTransparency = props.TextTransparency,
					TextSizeMax = props.TextSizeMax,

					TextXAlignment = props.TextXAlignment,
					TextYAlignment = props.TextYAlignment,
					FontWeight = props.TextFontWeight,

					StrokeColor = props.TextStrokeColor,
					StrokeThickness = props.TextStrokeThickness,
					StrokeTransparency = props.TextStrokeTransparency,
					StrokeMode = props.TextStrokeMode,
					StrokeLineJoinMode = props.TextStrokeLineJoinMode,

					Transparency = props.Transparency,
				} :: any
			),

			imageLabel = hasImage and createElement(
				Image,
				{
					Size = props.ImageSize,
					Position = props.ImagePosition,
					AnchorPoint = props.ImageAnchorPoint,

					BackgroundTransparency = 1,

					Rotation = props.ImageRotation,
					ZIndex = props.ImageZIndex,

					Image = props.Image,
					ImageColor3 = props.ImageColor3,
					ImageTransparency = props.ImageTransparency,

					ScaleType = props.ImageScaleType,
					SliceCenter = props.ImageSliceCenter,

					ImageRectOffset = props.ImageRectOffset,
					ImageRectSize = props.ImageRectSize,

					Transparency = props.Transparency,
				} :: any
			),

			uiScale = hasEventAnimations and createElement("UIScale", {
				Scale = buttonScaleSpring,
			}),

			children = createElement(React.Fragment, {}, props.children),
			constraints = createElement(ButtonConstraints, props),
		}),

		uiAspectRatio = hasAspectRatio and createElement("UIAspectRatioConstraint", {
			AspectRatio = props.AspectRatio,
		}),
	})
end

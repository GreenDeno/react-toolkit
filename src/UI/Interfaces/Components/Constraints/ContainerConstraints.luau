local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local PrimitiveConstraints = script.Parent.Primitives

local AspectRatio = require(PrimitiveConstraints.AspectRatio)
local Corner = require(PrimitiveConstraints.Corner)
local Gradient = require(PrimitiveConstraints.Gradient)
local List = require(PrimitiveConstraints.List)
local MaxSize = require(PrimitiveConstraints.MaxSize)
local Padding = require(PrimitiveConstraints.Padding)
local Scale = require(PrimitiveConstraints.Scale)
local Stroke = require(PrimitiveConstraints.Stroke)

export type ButtonConstraints =
	Gradient.Props
	& Stroke.Props
	& Corner.Props
	& List.Props
	& Scale.Props
	& AspectRatio.Props
	& MaxSize.Props
	& Padding.Props

local createElement = React.createElement
local constraints = {
	uiCorner = Corner,
	uiGradient = Gradient,
	uiStroke = Stroke,
	uiList = List,
	uiScale = Scale,
	uiAspectRatio = AspectRatio,
	uiMaxSize = MaxSize,
	uiPadding = Padding,
}

local function ContainerConstraints(props: ButtonConstraints)
	local elements = {}

	for name, constraint in pairs(constraints) do
		if constraint.has(props) then
			elements[name] = createElement(constraint.element, props)
		end
	end

	return createElement(React.Fragment, nil, elements)
end

return ContainerConstraints

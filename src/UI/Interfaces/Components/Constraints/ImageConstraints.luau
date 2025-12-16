local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local PrimitiveConstraints = script.Parent.Primitives

local AspectRatio = require(PrimitiveConstraints.AspectRatio)
local Corner = require(PrimitiveConstraints.Corner)
local Gradient = require(PrimitiveConstraints.Gradient)
local Scale = require(PrimitiveConstraints.Scale)
local Stroke = require(PrimitiveConstraints.Stroke)

export type Props = Stroke.Props & Corner.Props & AspectRatio.Props & Gradient.Props & Scale.Props

local createElement = React.createElement
local constraints = {
	uiCorner = Corner,
	uiStroke = Stroke,
	uiAspectRatio = AspectRatio,
	uiGradient = Gradient,
	uiScale = Scale,
}

local function ImageConstraints(props: Props)
	local elements = {}

	for name, constraint in pairs(constraints) do
		if constraint.has(props) then
			elements[name] = createElement(constraint.element, props)
		end
	end

	return createElement(React.Fragment, nil, elements)
end

return ImageConstraints

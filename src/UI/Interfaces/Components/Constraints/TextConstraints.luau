local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local PrimitiveConstraints = script.Parent.Primitives

local Corner = require(PrimitiveConstraints.Corner)
local Stroke = require(PrimitiveConstraints.Stroke)
local TextMaxSize = require(PrimitiveConstraints.TextMaxSize)

export type Props = Stroke.Props & Corner.Props & TextMaxSize.Props

local createElement = React.createElement
local constraints = {
	uiCorner = Corner,
	uiStroke = Stroke,
	uiTextMaxSize = TextMaxSize,
}

local function TextConstraints(props: Props)
	local elements = {}

	for name, constraint in pairs(constraints) do
		if constraint.has(props) then
			elements[name] = createElement(constraint.element, props)
		end
	end

	return createElement(React.Fragment, nil, elements)
end

return TextConstraints

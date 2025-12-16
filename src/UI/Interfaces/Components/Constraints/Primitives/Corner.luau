local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	CornerRadius: number?,
	CornerRadiusScale: number?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.CornerRadius ~= nil or props.CornerRadiusScale ~= nil
	end,
	element = function(props: Props)
		return createElement("UICorner", {
			CornerRadius = UDim.new(props.CornerRadiusScale, props.CornerRadius),
		})
	end,
}

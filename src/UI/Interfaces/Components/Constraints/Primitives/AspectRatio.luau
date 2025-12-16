local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	AspectRatio: number?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.AspectRatio ~= nil
	end,
	element = function(props: Props)
		return createElement("UIAspectRatioConstraint", {
			AspectRatio = props.AspectRatio,
		})
	end,
}

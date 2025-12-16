local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	MaxSize: React.PropBinding<Vector2>?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.MaxSize ~= nil
	end,
	element = function(props: Props)
		return createElement("UISizeConstraint", {
			MaxSize = props.MaxSize,
		})
	end,
}

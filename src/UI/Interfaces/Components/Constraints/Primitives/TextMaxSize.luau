local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	TextSizeMax: React.PropBinding<number>?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.TextSizeMax ~= nil
	end,
	element = function(props: Props)
		return createElement("UITextSizeConstraint", {
			MaxTextSize = props.TextSizeMax,
		})
	end,
}

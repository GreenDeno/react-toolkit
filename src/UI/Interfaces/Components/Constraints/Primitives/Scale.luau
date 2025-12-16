local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	Scale: React.PropBinding<number>?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.Scale ~= nil
	end,
	element = function(props: Props)
		return createElement("UIScale", {
			Scale = props.Scale,
		})
	end,
}

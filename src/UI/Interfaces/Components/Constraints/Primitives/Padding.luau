local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	PaddingLeft: number?,
	PaddingLeftScale: number?,
	PaddingRight: number?,
	PaddingRightScale: number?,
	PaddingTop: number?,
	PaddingTopScale: number?,
	PaddingBottom: number?,
	PaddingBottomScale: number?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.PaddingLeft ~= nil
			or props.PaddingLeftScale ~= nil
			or props.PaddingRight ~= nil
			or props.PaddingRightScale ~= nil
			or props.PaddingTop ~= nil
			or props.PaddingTopScale ~= nil
			or props.PaddingBottom ~= nil
			or props.PaddingBottomScale ~= nil
	end,
	element = function(props: Props)
		return createElement("UIPadding", {
			PaddingLeft = UDim.new(props.PaddingLeftScale, props.PaddingLeft),
			PaddingRight = UDim.new(props.PaddingRightScale, props.PaddingRight),
			PaddingTop = UDim.new(props.PaddingTopScale, props.PaddingTop),
			PaddingBottom = UDim.new(props.PaddingBottomScale, props.PaddingBottom),
		})
	end,
}

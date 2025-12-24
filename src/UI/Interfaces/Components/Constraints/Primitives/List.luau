local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries

local Constants = require(Libraries.Constants)
local React = require(Libraries.React)

local createElement = React.createElement

export type Props = {
	ListFillDirection: React.Bindable<Enum.FillDirection>?,
	ListHorizontalAlignment: React.Bindable<Enum.HorizontalAlignment>?,
	ListVerticalAlignment: React.Bindable<Enum.VerticalAlignment>?,
	ListPadding: React.Bindable<UDim>?,
	ListSortOrder: React.Bindable<Enum.SortOrder>?,
	ListWraps: React.Bindable<boolean>?,

	[typeof(React.Change.AbsoluteContentSize)]: ((listLayout: UIListLayout) -> ())?,
}

return {
	has = function(props: { [string]: any }): boolean
		return props.ListFillDirection ~= nil
			or props.ListHorizontalAlignment ~= nil
			or props.ListVerticalAlignment ~= nil
			or props.ListPadding ~= nil
			or props.ListSortOrder ~= nil
			or props.ListWraps ~= nil
	end,
	element = function(props: Props)
		return createElement("UIListLayout", {
			FillDirection = props.ListFillDirection or Constants.DEFAULTS.LIST_FILL_DIRECTION,
			HorizontalAlignment = props.ListHorizontalAlignment or Constants.DEFAULTS.LIST_HORIZONTAL_ALIGNMENT,
			VerticalAlignment = props.ListVerticalAlignment or Constants.DEFAULTS.LIST_VERTICAL_ALIGNMENT,
			SortOrder = props.ListSortOrder or Constants.DEFAULTS.LIST_SORT_ORDER,
			Padding = props.ListPadding,
			Wraps = props.ListWraps,

			[React.Change.AbsoluteContentSize] = props[React.Change.AbsoluteContentSize],
		})
	end,
}

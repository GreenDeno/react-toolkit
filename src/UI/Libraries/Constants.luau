local Constants = {
	DEFAULTS = {
		SIZE = UDim2.fromScale(1, 1),
		POSITION = UDim2.fromScale(0.5, 0.5),
		ANCHOR_POINT = Vector2.new(0.5, 0.5),

		BACKGROUND_COLOR3 = Color3.fromRGB(255, 255, 255),
		BACKGROUND_TRANSPARENCY = 1,
		BACKGROUND_GRADIENT_TRANSPARENCY = NumberSequence.new(0),
		BACKGROUND_BORDER_SIZE_PIXEL = 0,

		TEXT_COLOR3 = Color3.fromRGB(255, 255, 255),
		TEXT_XALIGNMENT = Enum.TextXAlignment.Center,
		TEXT_YALIGNMENT = Enum.TextYAlignment.Center,
		TEXT_FONT = Enum.Font.Roboto,
		TEXT_FONT_FACE = "Montserrat",
		TEXT_FONT_WEIGHT = Enum.FontWeight.Regular,

		IMAGE_COLOR3 = Color3.fromRGB(255, 255, 255),

		STROKE_TRANSPARENCY = 0,
		STROKE_GRADIENT_TRANSPARENCY = NumberSequence.new(0),

		LIST_FILL_DIRECTION = Enum.FillDirection.Horizontal,
		LIST_HORIZONTAL_ALIGNMENT = Enum.HorizontalAlignment.Center,
		LIST_VERTICAL_ALIGNMENT = Enum.VerticalAlignment.Center,
		LIST_SORT_ORDER = Enum.SortOrder.LayoutOrder,

		BUTTON_HOVER_SIZE_SCALE = 1.15,
		BUTTON_DEPRESS_SIZE_SCALE = 2 - 1.15,
	},

	ASSET_IDs = {},
	THEME = {},

	EPSILON = 0.001,
}

return Constants

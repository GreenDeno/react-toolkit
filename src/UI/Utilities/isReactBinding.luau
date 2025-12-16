local function isReactBinding(instance: any): boolean
	return type(instance) == "table" and instance.getValue ~= nil
end

return isReactBinding

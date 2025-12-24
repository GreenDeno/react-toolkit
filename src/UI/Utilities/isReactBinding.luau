local REACT_BINDING_TYPE = 0xeae4

local function isReactBinding(instance: any): boolean
	return type(instance) == "table" and instance["$$typeof"] == REACT_BINDING_TYPE
end

return isReactBinding

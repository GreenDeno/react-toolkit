local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local useCallback = React.useCallback
local useRef = React.useRef

local function useDebounce(bounceDuration: number)
	local lastBouncedRef = useRef(0)

	return useCallback(function()
		local now = time()
		if now - lastBouncedRef.current > bounceDuration then
			lastBouncedRef.current = now
			return true
		end

		return false
	end, { bounceDuration })
end

return useDebounce

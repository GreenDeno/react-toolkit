-- [[
-- Similar to React.useEffect, allows subscribing to one or more Bindings
-- from a react lifecycle method. The current values of the bindings are passed
-- to the callback whenever any of the bindings update. An optional dependencies
-- array can be provided to control when the effect is re-subscribed.
-- ]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Libraries = ReplicatedStorage.UI.Libraries
local React = require(Libraries.React)

local subscribeToBinding = React.__subscribeToBinding
local useEffect = React.useEffect

type Binding<T> = React.Binding<T>

local function useBindingEffect(callback: (any) -> (), bindings: { Binding<any> }, dependencies: { any }?)
	useEffect(function()
		local disconnects = {}
		local values = {}

		local running = true
		local numBindings = #bindings

		-- CRITICAL: need to assign values in reverse order otherwise
		-- LUA will automatically convert table to a dictionary whenever
		-- there is a nil entry. This will cause the unpack to fail
		-- and the callback to receive the wrong number of arguments
		for i = numBindings, 1, -1 do
			local bindingRef = bindings[i]
			values[i] = if bindingRef then bindingRef:getValue() else nil
		end

		for i = 1, numBindings do
			local idx = i
			local bindingRef = bindings[i]

			if not bindingRef then
				continue
			end

			disconnects[idx] = subscribeToBinding(bindingRef, function(newValue)
				if not running then
					warn("Binding updated after unmount")
					return
				end

				local oldValue = values[idx]
				values[idx] = newValue

				if oldValue ~= newValue or typeof(newValue) == "table" then
					callback(unpack(values))
				end
			end)
		end

		callback(unpack(values))

		return function()
			for _, disconnect in disconnects do
				disconnect()
			end

			running = false

			table.clear(disconnects)
			table.clear(values)
		end
	end, { unpack(bindings), unpack(dependencies or {}) })
end

return useBindingEffect

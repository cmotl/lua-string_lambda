describe("string lambda", function()
	require("string_lambda")

	it("creates the global L function", function()
		assert.is.equal("function", type(L))
		assert.is.equal(L, _G["L"])
	end)

	it("can return an identity lambda", function()
		local something_specific = {}

		local fn = L("_")

		assert.is.equal(something_specific, fn(something_specific))
	end)

	it("can return an increment lambda", function()
		local fn = L("_+1")

		assert.is.equal(2, fn(1))
		assert.is.equal(3, fn(2))
	end)

	it("can use pipe syntax with multiple parameters", function()
		local fn = L("|x,y| x+y")

		assert.is.equal(3, fn(1, 2))
		assert.is.equal(14, fn(11, 3))
	end)

	it("can use pipe syntax with multiple parameters and partial application", function()
		local fn = L("|x,y| y/x", 2)

		assert.is.equal(4, fn(8))
		assert.is.equal(5, fn(10))
	end)

	it("can bind multiple values resulting in a function which still takes multiple arguments", function()
		local fn = L("|a,b,c,d| a*b+c/d", 2, 3)

		assert.is.equal(6.5, fn(1, 2))
		assert.is.equal(8, fn(10, 5))
	end)

	it("memoizes the result of the same string value", function()
		local fn_a = L("_+2")
		local fn_b = L("_" .. "+" .. tostring(2 // 1))

		assert.is.equal(fn_a, fn_b)
	end)

	it("raises an error for invalid Lua code", function()
		assert.has_errors(function()
			L("|a| this is not valid lua code")
		end)
	end)
end)

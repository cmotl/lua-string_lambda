-- Background for the reader:
--  https://stevedonovan.github.io/Penlight/api/libraries/pl.utils.html#string_lambda
--  https://stevedonovan.github.io/Penlight/api/libraries/pl.utils.html#bind1

local pl_utils = require 'pl.utils'
local StringLambda = {}

function StringLambda.new(l, ...)
  local fn = pl_utils.string_lambda(l)

  for _, arg in pairs { ... } do
    fn = pl_utils.bind1(fn, arg)
  end

  if 'function' ~= type(fn) then
    error(string.format("String lambda '%s' did not generate a function", l))
  end

  return fn
end

L = StringLambda.new

return StringLambda

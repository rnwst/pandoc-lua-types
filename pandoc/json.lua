-- JSON module to work with JSON; based on the Aeson Haskell package.
---@meta

json = {}

---@type lightuserdata  value used to represent the null JSON value
json.null = {}

---Creates a Lua object from a JSON string. If the input can be decoded
---as representing an [Inline](lua://Inline), [Block](lua://Block),
---[Pandoc](lua://Pandoc), [Inlines](lua://Inlines), or [Blocks](lua://Blocks)
---element, the function will return an object of the appropriate type.
---Otherwise, if the input does not represent any of the AST types, the default
---decoding is applied: Objects and arrays are represented as tables, the JSON
---`null` value becomes [null](lua://json.null), and JSON booleans, strings, and
---numbers are converted using the Lua types of the same name.
---
---The special handling of AST elements can be disabled by setting
---`pandoc_types` to `false`.
---@param str string     JSON string
---@param pandoc_types?  boolean  whether to use pandoc types when possible
---@return any  decoded object
json.decode = function(str, pandoc_types) end

---Encodes a Lua object as JSON string.
---
---If the object has a metamethod with name `__tojson`, then the result is that of
---a call to that method with `object` passed as the sole argument. The result of
---that call is expected to be a valid JSON string, but this is not checked.
---@param object any
---@return string  JSON encoding of the given object
json.encode = function(object) end

return json

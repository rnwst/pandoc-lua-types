---@meta

---Constructors for types that are not part of the pandoc AST.
---Currently, this module is pretty pointless. The function below should really
---be implemented as a constructor for the Version type, rather than live in a
---separate module.
types = {}

---Creates a [Version](lua://Version) object.
---@param version_specifier (string | integer[] | Version)
---@return Version # new [Version](lua://Version) object
types.Version = function(version_specifier) end

return types

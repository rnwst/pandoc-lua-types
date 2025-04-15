-- Information about the formats supported by pandoc.
---@meta

format = {}

---Returns the list of all valid extensions for a format. No distinction is
---made between input and output; an extension can have an effect when reading a
---format but not when writing it, or vice versa.
---@param format string  format format_identifier
---@return List<Extension>  all extensions supported for format
format.all_extensions = function(format) end

---Returns the [List](lua://List) of default extensions of the given format; this function
---does not check if the format is supported, it will return a fallback list of
---extensions even for unknown formats.
---@param format string  format identifier
---@return List<Extension>  default extensions enabled for `format`
format.default_extensions = function(format) end

---Returns the extension configuration for the given format. The configuration
---is represented as a table with all supported extensions as keys and their
---default status as value, with `true` indicating that the extension is enabled
---by default, while `false` marks a supported extension that’s disabled.
---
---This function can be used to assign a value to the Extensions global in
---custom readers and writers.
---@param format string format identifier
---@return table<Extension, boolean>
format.extensions = function(format) end

---Use heuristic to determine format of provided file(s).
---@param path (string | string[])  file path, or list of paths
---@return (string | nil)  format determined by heuristic
format.from_path = function(path) end

return format

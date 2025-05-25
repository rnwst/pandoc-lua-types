---@meta

---Handle pandoc templates.
template = {}

---@alias TemplateContext table<string, (Doc | string | boolean | TemplateContext)>

---Applies a context with variable assignments to a template, returning the
---rendered template. The context parameter must be a table with variable names
---as keys and [Doc](lua://Doc), string, boolean, or table as values, where
---the table can be either be a list of the aforementioned types, or a nested
---context.
---@param template Template         template to apply
---@param context  TemplateContext  template variable values
---@return Doc # rendered template
template.apply = function(template, context) end

---Compiles a template string into a [Template](lua://Template) object usable
---by pandoc.
---
---If the templates_path parameter is specified, then it should be the file path
---associated with the template. It is used when checking for partials. Partials
---will be taken only from the default data files if this parameter is omitted.
---
---An error is raised if compilation fails.
---@param template        string  template string
---@param templates_path? string  parameter to determine a default path and extension for partials; uses the data files templates path by default.
---@return Template # compiled template
template.compile = function(template, templates_path) end

---Returns the default template for a given writer as a string. An error is
---thrown if no such template can be found.
---@param writer? string  name of the writer for which the template should be retrieved; defaults to the global `FORMAT`
---@return string # raw template
template.default = function(writer) end

---Retrieve text for a template.
---
---This function first checks the resource paths for a file of this name; if
---none is found, the templates directory in the user data directory is checked.
---Returns the content of the file, or throws an error if no file is found.
---@param filename string  name of the template
---@return string # content of template file
template.get = function(filename) end

---Creates template context from the document’s [Meta](lua://Meta) data, using the given
---functions to convert [Blocks](lua://Blocks) and Inlines to Doc values.
---@param meta any
---@param blocks_writer fun(blocks: Blocks | Block[]): (Doc | string)                         converter from Blocks to [Doc](lua://doc) values
---@param inlines_writer fun(inlines: Inlines | Inline[] | string | boolean): (Doc | string)  converter from Inlines to [Doc](lua://doc) values
---@return TemplateContext # template context
template.meta_to_context = function(meta, blocks_writer, inlines_writer) end

return template

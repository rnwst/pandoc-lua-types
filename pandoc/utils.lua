-- This module exposes internal pandoc functions and utility functions.
---@meta

utils = {}

---Squash a list of blocks into a list of inlines.
---
---Usage:
--- ```lua
--- local blocks = {
---   pandoc.Para{ pandoc.Str 'Paragraph1' },
---   pandoc.Para{ pandoc.Emph 'Paragraph2' }
--- }
--- local inlines = pandoc.utils.blocks_to_inlines(blocks)
--- assert(
---   inlines == pandoc.Inlines {
---     pandoc.Str 'Paragraph1',
---     pandoc.Linebreak(),
---     pandoc.Emph{ pandoc.Str 'Paragraph2' }
---   }
--- )
--- ```
---@param blocks (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)  List of Block elements to be flattened
---@param sep?   (Inlines | Inline[] | Inline | string[] | string)                     List of Inline elements inserted as separator between two consecutive blocks; defaults to `{pandoc.LineBreak()}`
---@return Inlines
utils.blocks_to_inlines = function(blocks, sep) end

---Process the citations in the file, replacing them with rendered citations
---and adding a bibliography. See the manual section on citation rendering for
---details.
---
---Usage:
--- ```lua
--- -- Lua filter that behaves like `--citeproc`
--- function Pandoc (doc)
---   return pandoc.utils.citeproc(doc)
--- end
--- ```
---@param doc Pandoc
---@return Pandoc # processed document
utils.citeproc = function(doc) end

---Creates a `Table` block element from a `SimpleTable`. This is useful for dealing
---with legacy code which was written for pandoc versions older than 2.10.
---
---Usage:
--- ```lua
--- local simple = pandoc.SimpleTable(table)
--- -- modify, using pre pandoc 2.10 methods
--- simple.caption = pandoc.SmallCaps(simple.caption)
--- -- create normal table block again
--- table = pandoc.utils.from_simple_table(simple)
--- ```
---@param simple_tbl SimpleTable
---@return Table
utils.from_simple_table = function(simple_tbl) end

---Converts a `List` of `Block` elements into sections. `Divs` will be created
---beginning at each `Header` and containing following content until the next
---`Header` of comparable level. If `number_sections` is true, a number attribute
---will be added to each `Header` containing the section number. If `base_level` is
---non-null, `Header` levels will be reorganized so that there are no gaps, and so
---that the base level is the level specified.
---@param number_sections boolean          whether section divs should bet an additional `number` attribute containing the section number
---@param base_level      (integer | nil)  shift top-level headings to this level
---@param blocks          (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)  list of blocks to process
---@return Blocks # blocks with sections
utils.make_sections = function(number_sections, base_level, blocks) end

---Parse a date and convert (if possible) to “YYYY-MM-DD” format. We limit years
---to the range 1601-9999 (ISO 8601 accepts greater than or equal to 1583, but
---MS Word only accepts dates starting 1601). Returns `nil` instead of a `string` if
---the conversion failed.
---@param date string  the date string
---@return (string | nil) # normalized date, or `nil` if the conversion failed
utils.normalize_date = function(date) end

---Get references defined inline in the metadata and via an external
---bibliography. Only references that are actually cited in the document
---(either with a genuine citation or with nocite) are returned. URL variables
---are converted to links.
---
---The structure used to represent reference values corresponds to that used in
---CSL JSON; the return value can be use as `references` metadata, which is one of
---the values used by pandoc and citeproc when generating bibliographies.
---
---Usage:
--- ```lua
--- -- Include all cited references in document
--- function Pandoc (doc)
---   doc.meta.references = pandoc.utils.references(doc)
---   doc.meta.bibliography = nil
---   return doc
--- end
--- ```
---@param doc Pandoc
---@return table # list of references
utils.references = function(doc) end

---Filter the given doc by passing it through a JSON filter.
---@param doc    Pandoc    the Pandoc document to filter
---@param filter string    filter to run
---@param args?  string[]  list of arguments passed to the filter; defaults to `{FORMAT}`
utils.run_json_filter = function(doc, filter, args) end

---Filter the given doc by passing it through a JSON filter.
---The filter will be run in the current Lua process.
---@param doc    Pandoc  the Pandoc document to filter
---@param filter string  filepath of the filter to run
---@param env?   table   environment to load and run the filter in
---@return Pandoc # filtered document
utils.run_lua_filter = function(doc, filter, env) end

---Computes the SHA1 hash of the given string input.
---@param input string
---@return string # hexadecimal hash value
utils.sha1 = function(input) end

---Converts the given element (`Pandoc`, `Meta`, `Block`, or `Inline`) into a string with all formatting removed.
---@param element (Pandoc | Meta | Block | Inline)  some pandoc AST element
---@return string # a plain string representation of the given element
utils.stringify = function(element) end

---Converts an integer < 4000 to uppercase roman numeral
---
---Usage:
--- ```lua
--- local to_roman_numeral = pandoc.utils.to_roman_numeral
--- local pandoc_birth_year = to_roman_numeral(2006)
--- -- pandoc_birth_year == 'MMVI'
--- ```
---@param n integer  positive integer below 4000
---@return string # a roman numeral
utils.to_roman_numeral = function(n) end

---Converts a `Table` into an old/simple table.
---
---Usage:
--- ```lua
--- local simple = pandoc.utils.to_simple_table(table)
--- -- modify, using pre pandoc 2.10 methods
--- simple.caption = pandoc.SmallCaps(simple.caption)
--- -- create normal table block again
--- table = pandoc.utils.from_simple_table(simple)
--- ```
---@param tbl Table
---@return SimpleTable
utils.to_simple_table = function(tbl) end

---Pandoc-friendly version of Lua’s default type function, returning type
---information similar to what is presented in the manual.
---
---The function works by checking the metafield `__name`. If the argument has a
---string-valued metafield `__name`, then it returns that string. Otherwise it
---behaves just like the normal type function.
---
---Usage:
--- ```lua
--- -- Prints one of 'string', 'boolean', 'Inlines', 'Blocks',
--- -- 'table', and 'nil', corresponding to the Haskell constructors
--- -- MetaString, MetaBool, MetaInlines, MetaBlocks, MetaMap,
--- -- and an unset value, respectively.
--- 
--- function Meta (meta)
---   print('type of metavalue `author`:', pandoc.utils.type(meta.author))
--- end
--- ```
---@param value any
---@return string # type of the given value
utils.type = function(value) end

---Creates a [Version](lua://Version) object.
---@param v (string | integer[] | integer)  version description
---@return Version
utils.Version = function(v) end

return utils

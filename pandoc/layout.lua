-- Plain-text document layouting. Useful for writing custom writers.
---@meta

layout = {}

---@type Doc  Inserts a blank line unless one already exists.
layout.blankline = {}

---@type Doc  A carriage return. Does nothing if we’re at the beginning of a line; otherwise inserts a newline.
layout.cr = {}

---@type Doc  The empty document.
layout.empty = {}

---@type Doc  A breaking (reflowable) space.
layout.space = {}

---Creates a [Doc](lua://Doc) which is conditionally included only if it comes
---at the beginning of a line.
---
---An example where this is useful is for escaping line-initial `.` in roff man.
---@param text string  content to include when placed after a break
---@return Doc # new doc
layout.after_break = function(text) end

---Conditionally includes the given doc unless it is followed by a blank space.
---@param doc Doc  document
---@return Doc # conditional doc
layout.before_non_blank = function(doc) end

---Inserts blank lines unless they exist already.
---@param n integer  number of blank lines
---@return Doc # conditional blank lines
layout.blanklines = function(n) end

---Puts the `doc` in curly braces.
---@param doc Doc  document
---@return Doc # document enclosed by `{}`
layout.braces = function(doc) end

---Puts the `doc` in square brackets.
---@param doc Doc
---@return Doc # document enclosed by `[]`
layout.brackets = function(doc) end

---Creates a block with the given width and content, aligned centered.
---@param doc   Doc      document
---@param width integer  block width in chars
---@return Doc # doc; aligned centered in a block with max width chars per line
layout.cblock = function(doc, width) end

---Chomps trailing blank space off of the `doc`.
---@param doc Doc  document
---@return Doc # `doc` without trailing blanks
layout.chomp = function(doc) end

---Concatenates a list of [Docs](lua://Doc).
---@param docs (List<Doc> | Doc[])  list of Docs
---@param sep? Doc                  separator (default: none)
---@return Doc # concatenated doc
layout.concat = function(docs, sep) end

---Wraps a `Doc` in double quotes.
---@param doc Doc  document
---@return Doc # `doc` enclosed by `"` chars 
layout.double_quotes = function(doc) end

---Makes a [Doc](lua://Doc) flush against the left margin.
---@param doc Doc  document
---@return Doc # flushed `doc`
layout.flush = function(doc) end

---Creates a hanging indent.
---@param doc   Doc      document
---@param ind   integer  indentation width
---@param start Doc      prefix for first line
---@return Doc # `doc` prefixed by `start` on the first line, subsequent lines indented by `ind` spaces
layout.hang = function(doc, ind, start) end

---Encloses a [Doc](lua://Doc) inside a `start` and `end` [Doc](lua://Doc).
---@param contents Doc  document to be enclosed
---@param start    Doc  start document
---@param _end     Doc  end document
---@return Doc # enclosed contents
layout.inside = function(contents, start, _end) end

---Creates a block with the given width and content, aligned to the left.
---@param doc   Doc      document
---@param width integer  block width in chars
---@return Doc # doc put into block with max width chars per line
layout.lblock = function(doc, width) end

---Creates a [Doc](lua://Doc) from a string.
---@param text string  literal value
---@return Doc # doc containing just the literal string
layout.literal = function(text) end

---Indents a Doc by the specified number of spaces.
---@param doc Doc      document
---@param ind integer  indentation size
layout.nest = function(doc, ind) end

---Removes leading blank lines from a [Doc](lua://Doc).
---@param doc Doc  document
---@return Doc # `doc` with leading blanks removed
layout.nestle = function(doc) end

---Makes a Doc non-reflowable.
---@param doc Doc  document
---@return Doc # same as input, but non-reflowable
layout.nowrap = function(doc) end

---Puts the `doc` in parentheses.
---@param doc Doc  document
---@return Doc # doc enclosed by `()`
layout.parens = function(doc) end

---Uses the specified string as a prefix for every line of the document
---(except the first, if not at the beginning of the line).
---@param doc    Doc     document
---@param prefix string  prefix for each line
---@return Doc # prefixed doc
layout.prefixed = function(doc, prefix) end

---Wraps a Doc in single quotes.
---@param doc Doc  document
---@return Doc # doc enclosed in `'`
layout.quotes = function(doc) end

---Creates a block with the given width and content, aligned to the right.
---@param doc   Doc      document
---@param width integer  block width in chars
---@return Doc # `doc`, right aligned in a block with max width chars per line
layout.rblock = function(doc, width) end

---An expandable border that, when placed next to a box, expands to the height of
---the box. Strings cycle through the list provided.
---@param border string  vertically expanded characters
---@return Doc # automatically expanding border
layout.vfill = function(border) end

---Render a [Doc](lua://Doc). The text is reflowed on breakable spaces to match
---the given line length. Text is not reflowed if the line line length parameter
---is omitted or `nil`.
---@param doc       Doc
---@param colwidth? integer  maximum number of characters per line; a value of `nil`, the default, means that the text is not reflown
---@param style?    string   whether to generate plain text or ANSI terminal output; must be either `plain` or `ansi`. Defaults to `plain`.
---@return string  rendered `doc`
layout.render = function(doc, colwidth, style) end

---Checks whether a doc is empty.
---@param doc Doc  document
---@return boolean  `true` iff `doc` is the empty document, `false` otherwise
layout.is_empty = function(doc) end

---Returns the height of a block or other [Doc](lua://Doc).
---@param doc Doc  document
---@return (integer | string) # doc height
layout.height = function(doc) end

---Returns the minimal width of a [Doc](lua://Doc) when reflowed at breakable spaces.
---@param doc Doc  document
---@return (integer | string) # minimal possible width
layout.min_offset = function(doc) end

---Returns the width of a [Doc](lua://Doc) as number of characters.
---@param doc Doc  document
---@return (integer | string) # doc width
layout.offset = function(doc) end

---Returns the real length of a string in a monospace font: 0 for a combining
---character, 1 for a regular character, 2 for an East Asian wide character.
---@param str string  UTF-8 string to measure
---@return (integer | string) # text length
layout.real_length = function(str) end

---Returns the column that would be occupied by the last laid out character.
---@param doc Doc      document
---@param i   integer  start column
---@return (integer | string) # column number
layout.update_column = function(doc, i) end

---Puts a [Doc](lua://Doc) in boldface.
---@param doc Doc  document
---@return Doc # bolded `doc`
layout.bold = function(doc) end

---Puts a [Doc](lua://Doc) in italics.
---@param doc Doc
---@return Doc #styled `doc`
layout.italic = function(doc) end

---Underlines a [Doc](lua://Doc).
---@param doc Doc  document
---@return Doc # styled `doc`
layout.underlined = function(doc) end

---Puts a line through the [Doc](lua://Doc).
---@param doc Doc  document
---@return Doc # styled `doc`
layout.strikeout = function(doc) end

---Set the foreground color.
---@param doc Doc  document
---@param color ('black' | 'red' | 'green' | 'yellow' | 'blue' | 'magenta' | 'cyan' | 'white') foreground color
---@return Doc # styled `doc`
layout.fg = function(doc, color) end

---Set the background color.
---@param doc Doc  document
---@param color ('black' | 'red' | 'green' | 'yellow' | 'blue' | 'magenta' | 'cyan' | 'white')  background color
---@return Doc # styled `doc`
layout.bg = function(doc, color) end

return layout

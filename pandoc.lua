-- Definitions for the pandoc module.
---@meta


pandoc = {}

---Creates a new Pandoc document.
---@param blocks (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)
---@param meta? Meta
---@return Pandoc
pandoc.Pandoc = function(blocks, meta) end

---Creates a Meta table containing document metadata.
---@param meta {[string]: any} document metadata
---@return Meta
pandoc.Meta = function(meta) end

pandoc.MetaBlocks = pandoc.Blocks

---Converts the argument into a boolean. This function is pretty pointless.
---@param arg any
---@return boolean
pandoc.MetaBool = function(arg) end

pandoc.MetaInlines = pandoc.Inlines

pandoc.MetaList = pandoc.List

---Creates a value to be used as a MetaMap in document metadata.
---Creates a copy of the input table, keeping only pairs with string keys and discards all other keys.
---@param tbl table
---@return {[string]: any}
pandoc.MetaMap = function(tbl) end

---Converts the argument into a string, but acts as the identity function if the argument is a boolean. This function exists only for completeness and is pretty pointless.
---@param arg (string | integer | boolean)
---@return string | boolean
pandoc.MetaString = function(arg) end

---Creates a BlockQuote block-level element.
---@param content (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) block content
---@return BlockQuote
pandoc.BlockQuote = function(content) end

---Creates a BulletList block-level element.
---@param items (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)[] list items, list of a list of block-level-like elements
---@return BulletList
pandoc.BulletList = function(items) end

---Creates a CodeBlock block-level element.
---@param text string code string
---@param attr? Attr element attributes
---@return CodeBlock
pandoc.CodeBlock = function(text, attr) end

---Creates a DefinitionList block-level element.
---@param content [(Inlines | Inline[] | Inline | string[] | string), (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)][] definition items (a list of tuples, where a tuple consists of a list of inline-level elements, and list of a list of block-level elements) 
---@return DefinitionList
pandoc.DefinitionList = function(content) end

---Creates a Div block-level element.
---@param content (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) block content
---@param attr? Attr element attributes
---@return Div
pandoc.Div = function(content, attr) end

---Creates a Figure block-level element.
---@param content (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) figure block content
---@param caption Caption figure caption
---@param attr? Attr element attributes
---@return Figure
pandoc.Figure = function(content, caption, attr) end

---Creates a Header block-level element.
---@param level integer heading level
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@param attr? Attr element attributes
---@return Header
pandoc.Header = function(level, content, attr) end

---Creates a HorizontalRule block-level element.
---@return HorizontalRule
pandoc.HorizontalRule = function() end

---Creates a LineBlock block-level element.
---@param content (Inlines | Inline[] | Inline | string[] | string) list of lines, i.e. list of inline elements
---@return LineBlock
pandoc.LineBlock = function(content) end

---Creates an OrderedList block-level element.
---@param items (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)[] list items, list of a list of block-level elements
---@param listAttributes? ListAttributes list parameters
---@return OrderedList
pandoc.OrderedList = function(items, listAttributes) end

---Creates a Para block-level element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Para
pandoc.Para = function(content) end

---Creates a Plain block-level element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Plain
pandoc.Plain = function(content) end

---Creates a RawBlock block-level element.
---@param format string format of content
---@param text string raw content
---@return RawBlock
pandoc.RawBlock = function(format, text) end

---Creates a Table block-level element.
---@param caption Caption table caption
---@param colspecs ColSpec[] column alignments and widths
---@param head TableHead table head
---@param bodies TableBody[] table bodies
---@param foot TableFoot table foot
---@param attr? Attr element attributes
---@return Table
pandoc.Table = function(caption, colspecs, head, bodies, foot, attr) end

---Creates a List of Blocks.
---@param block_like_elements (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) list where each element can be treated as a Block, or a single such value
---@return Blocks
pandoc.Blocks = function(block_like_elements) end

---Creates a Cite inline element.
---@param inlines (Inlines | Inline[] | Inline | string[] | string) placeholder content
---@param citations Citation[] list of citations
---@return Cite
pandoc.Cite = function(inlines, citations) end

---Creates a Code inline element.
---@param code string code string
---@param attr? Attr element attributes
---@return Code
pandoc.Code= function(code, attr) end

---Creates a Emph inline element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Emph
pandoc.Emph = function(content) end

---Creates an Image inline element.
---@param caption (Inlines | Inline[] | Inline | string[] | string) text used to describe the image
---@param str string path to the image file
---@param title? string brief image description
---@param attr? Attr image attributes
---@return Image
pandoc.Image = function(caption, str, title, attr) end

---Creates a LineBreak inline element.
---@return LineBreak
pandoc.LineBreak = function() end

---Creates a Link inline element (usually a hyperlink).
---@param content (Inlines | Inline[] | Inline | string[] | string) text for this link
---@param target string the link target
---@param title? string brief link description
---@param attr? Attr link attributes
---@return Link
pandoc.Link = function(content, target, title, attr) end

---Creates a Math inline-level element. Math elements can be either inline or displayed.
---@param mathtype ('InlineMath' | 'DisplayMath') rendering specifier
---@param text string math content
---@return Math
pandoc.Math = function(mathtype, text) end

---Creates a Note inline element. A Note is the only inline element that has block-level content.
---@param content (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) footnote block content
---@return Note
pandoc.Note = function(content) end

---Creates a Quoted inline element.
---@param quotetype ('SingleQuote' | 'DoubleQuote') type of quotes
---@param content (Inlines | Inline[] | Inline | string[] | string) inline element in quotes
---@return Quoted
pandoc.Quoted = function(quotetype, content) end

---Creates a RawInline inline element.
---@param format string format of content
---@param text string string content
---@return RawInline
pandoc.RawInline = function(format, text) end

---Creates a SmallCaps inline element i.e. text rendered in small caps.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return SmallCaps
pandoc.SmallCaps = function(content) end

---Creates a SoftBreak inline element.
---@return SoftBreak
pandoc.SoftBreak = function() end

---Creates a Space inline element.
---@return Space
pandoc.Space = function() end

---Creates a Span inline element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@param attr? Attr element attributes
---@return Span
pandoc.Span = function(content, attr) end

---Creates a Str inline element.
---@param text string
---@return Str
pandoc.Str = function(text) end

---Creates a Strikeout inline element i.e. text which is struck out.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Strikeout
pandoc.Strikeout = function(content) end

---Creates a Strong inline element, whose text is usually displayed in a bold font.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Strong
pandoc.Strong = function(content) end

---Creates a Subscript inline element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Subscript
pandoc.Subscript = function(content) end

---Creates a Superscript inline element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Superscript
pandoc.Superscript = function(content) end

---Creates an Underline inline element.
---@param content (Inlines | Inline[] | Inline | string[] | string) inline content
---@return Underline
pandoc.Underline = function(content) end

---Creates a List of Inlines.
---@param inline_like_elements (Inlines | Inline[] | Inline | string[] | string)
---@return Inlines
pandoc.Inlines = function(inline_like_elements) end

---Creates a new set of attributes.
---@param identifier? string
---@param classes? string[]
---@param attributes? Attributes
---@return Attr
pandoc.Attr = function(identifier, classes, attributes) end

---Creates a new table cell.
---@param blocks (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) cell contents
---@param align? Alignment text alignment, defaults to 'AlignDefault'
---@param rowspan? integer number of rows occupied by the cell, defaults to 1
---@param colspan? integer number of columns occupied by the cell, defaults to 1
---@param attr? Attr cell attributes
---@return Cell
pandoc.Cell = function(blocks, align, rowspan, colspan, attr) end

---Creates an Attributes object, i.e. a string-indexed table of strings when
---passed a string-indexed table of strings or integers. This function seems to
---be pretty pointless. I would also have expected it to be named 'Attributes',
---not 'AttributesList'.
---@param attributes {[string]: string | integer}
---@return Attributes
pandoc.AttributeList = function(attributes) end

---Creates a single citation.
---@param id string citation Id
---@param mode? CitationMode citation rendering mode
---@param prefix? (Inlines | Inline[] | Inline | string[] | string)
---@param suffix? (Inlines | Inline[] | Inline | string[] | string)
---@param note_num? integer note number
---@param hash? integer hash number
---@return Citation
pandoc.Citation = function(id, mode, prefix, suffix, note_num, hash) end

---Creates a new ListAttributes object.
---@param start integer number of the first list item
---@param style ListNumberStyle style used for list numbering
---@param delimiter ListNumberDelim delimiter of list numbers
---@return ListAttributes
pandoc.ListAttributes = function(start, style, delimiter) end

---Creates a table row.
---@param cells? Cell[] list of table cells in this row
---@param attr? Attr row attributes
---@return Row
pandoc.Row = function(cells, attr) end

---Creates a table foot.
---@param rows? Row[] list of table rows
---@param attr? table foot attributes
---@return TableFoot
pandoc.TableFoot = function(rows, attr) end

---Creates a table head.
---@param rows Row[] list of table rows
---@param attr Attr table head attributes
---@return TableHead
pandoc.TableHead = function(rows, attr) end

---Creates a SimpleTable object.
---@param caption (Inlines | Inline[] | Inline | string[] | string)  table caption
---@param align   Alignment[]                                        column alignments
---@param widths  number[]                                           relative column widths
---@param header  (Block[])[]                                        table header row
---@param rows    (Block[])[]                                        table rows
---@return SimpleTable
pandoc.SimpleTable = function(caption, align, widths, header, rows) end


-- Other constructors ------------------------------------------------------------------------------

---Creates a new `ReaderOptions` value.
---@param opts ReaderOptions  Either a table with a subset of the properties of a `ReaderOptions` object, or another `ReaderOptions` object. Uses the defaults specified in the manual for all properties that are not explicitly specified.
---@return ReaderOptions
pandoc.ReaderOptions = function(opts) end

---Creates a new `WriterOptions` values.
---@param opts WriterOptions  Either a table with a subset of the properties of a `WriterOptions` object, or another `WriterOptions` object. Uses the defaults specified in the manual for all properties that are not explicitly specified.
---@return WriterOptions
pandoc.WriterOptions = function(opts) end


-- Helper functions --------------------------------------------------------------------------------

---Runs command with arguments, passing it some input, and returns the output.
---@param command string    program to run; the executable will be resolved using default system methods
---@param args    string[]  List of arguments to pass to the program
---@param input any
pandoc.pipe = function(command, args, input) end

---Apply a filter inside a block-level element, walking its contents. Returns a (deep) copy on which the filter has been applied: the original element is left untouched.
---@generic T: Block
---@param block  `T`     the block element
---@param filter Filter  Lua filter to be applied within the block element
---@return T
pandoc.walk_block = function(block, filter) end

---Apply a filter inside an inline-level element, walking its contents. Returns a (deep) copy on which the filter has been applied: the original element is left untouched.
---@generic T: Inline
---@param inline `T`     the block element
---@param filter Filter  Lua filter to be applied within the block element
---@return T
pandoc.walk_inline = function(inline, filter) end

---Parses the given string into a Pandoc document.
---@param markup string The markup to be parsed.
---@param format? string | {format: string, extensions: (Extension[] | table<Extension, (boolean | 'enable' | 'disable')>)} The format parameter defines the format flavor that will be parsed. This can be either a string, using + and - to enable and disable extensions, or a table with fields format (string) and extensions (table). The extensions table can be a list of all enabled extensions, or a table with extensions as keys and their activation status as values (true or 'enable' to enable an extension, false or 'disable' to disable it).
---@param reader_options? ReaderOptions Options passed to the reader; may be a ReaderOptions object or a table with a subset of the keys and values of a ReaderOptions object; defaults to the default values documented in the manual.
---@return Pandoc
pandoc.read = function(markup, format, reader_options) end

---Converts a document to the given target format.
---@param doc Pandoc Document to convert.
---@param format? string | {format: string, extensions: (Extension[] | table<Extension, (boolean | 'enable' | 'disable')>)} The format parameter defines the format flavor that will be written. This can be either a string, using + and - to enable and disable extensions, or a table with fields format (string) and extensions (table). The extensions table can be a list of all enabled extensions, or a table with extensions as keys and their activation status as values (true or 'enable' to enable an extension, false or 'disable' to disable it).
---@param writer_options? WriterOptions Options passed to the writer; may be a WriterOptions object or a table with a subset of the keys and values of a WriterOptions object; defaults to the default values documented in the manual.
---@return string
pandoc.write = function(doc, format, writer_options) end

---Runs a classic custom Lua writer, using the functions defined in the current environment.
---@param doc             Pandoc         document to convert
---@param writer_options? WriterOptions  options passed to the writer; may be a `WriterOptions` object or a table with a subset of th ekeys and values of a `WriterOptions` object; defaults to the default values documented in the manual 
pandoc.write_classic = function(doc, writer_options) end


-- Other modules =======================================================================================================
-- These modules are part of the `pandoc` table, or they can be `require`d.

pandoc.cli = require('pandoc.cli')

pandoc.utils = require('pandoc.utils')

-- TBD: pandoc.mediabag

-- TBD: pandoc.format

-- TBD: pandoc.image

-- TBD: pandoc.json

pandoc.log = require('pandoc.log')

pandoc.path = require('pandoc.path')

-- TBD: pandoc.structure

-- TBD: pandoc.system

-- TBD: pandoc.layout

-- TBD: pandoc.scaffolding

-- TBD: pandoc.text

-- TBD: pandoc.template

-- TBD: pandoc.types

pandoc.zip = require('pandoc.zip')

-- Pandoc filter type definitions
-- lua-language-server's type checking is not currently as powerful as it could be - see https://github.com/LuaLS/lua-language-server/issues/3101
-- That being said, it seems to catch at least 90% of my errors! 
---@meta


-- Lua types ===========================================================================================================

-- Pandoc ------------------------------------------------------------------------------------------

---@class Pandoc
---@field blocks (Blocks | Block[]) document content
---@field meta Meta document meta information
---@field walk fun(filter: table): Pandoc


-- Meta --------------------------------------------------------------------------------------------

-- TBD 
---@alias Meta table


-- Blocks ------------------------------------------------------------------------------------------

---@alias Block
---| BlockQuote
---| BulletList
---| CodeBlock
---| DefinitionList
---| Div
---| Figure
---| Header
---| HorizontalRule
---| LineBlock
---| OrderedList
---| Para
---| Plain
---| RawBlock
---| Table

---@class Blocks
Blocks = {}
Blocks.__index = Blocks

---Sequence of block-level elements
---@param blocks Block[]
---@return Blocks
function Blocks:new(blocks)
   setmetatable(blocks, self)
   return blocks
end

---Applies a Lua filter to the Blocks list. Just as for
---full-document filters, the order in which elements are
---traversed can be controlled by setting the 'traverse' field
---of the filter. The filter is applied to all list items
---and to the list itself. Returns a (deep) copy on which
---the filter has been  applied: the original list is left
---untouched.
---@param filter table
---@return Blocks
function Blocks:walk(filter) end

-- TBD
---@alias BlockQuote table

-- TBD
---@alias BulletList table

---@class CodeBlock
---@field text string code string
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'CodeBlock'
---@field t 'CodeBlock'

-- TBD
---@alias DefinitionList table

---@class Div
---@field content (Blocks | Block[]) block content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Div'
---@field t 'Div'

---@class Figure
---@field content (Blocks | Block[])
---@field caption Caption
---@field attr Attr
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Figure'
---@field t 'Figure'

---@class Header
---@field level integer header level
---@field content (Inlines | Inline[]) inline content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Header'
---@field t 'Header'

-- TBD
---@alias HorizontalRule table

-- TBD
---@alias LineBlock table

-- TBD
---@alias OrderedList table

---@class Para: Element
---@field content (Inlines | Inline[]) inline content
---@field tag 'Para'
---@field t 'Para'

---@class Plain
---@field content (Inlines | Inline[])
---@field tag 'Plain'
---@field t 'Plain'

---@class RawBlock
---@field format string format of content
---@field text string raw content
---@field tag 'RawBlock'
---@field t 'RawBlock'

---@class Table
---@field attr Attr table attributes
---@field caption Caption table caption
---@field colspecs ColSpec column specifications, i.e. alignments and widths
---@field head TableHead table head
---@field bodies TableBody[] table bodies
---@field foot TableFoot table foot
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Table'
---@field t 'Table'


-- Inlines -----------------------------------------------------------------------------------------

---@alias Inline
---| Cite
---| Code
---| Emph
---| Image
---| LineBreak
---| Link
---| Math
---| Note
---| Quoted
---| RawInline
---| SmallCaps
---| SoftBreak
---| Space
---| Span
---| Str
---| Strikeout
---| Strong
---| Subscript
---| Superscript
---| Underline

---@class Inlines
Inlines = {}
Inlines.__index = Inlines

---Sequence of block-level elements
---@param inlines Inline[]
---@return Inlines
function Inlines:new(inlines)
   setmetatable(inlines, self)
   return inlines
end

---Applies a Lua filter to the Inlines list. Just as for
---full-document filters, the order in which elements are
---traversed can be controlled by setting the 'traverse' field
---of the filter. The filter is applied to all list items
---and to the list itself. Returns a (deep) copy on which
---the filter has been  applied: the original list is left
---untouched.
---@param filter table
---@return Inlines
function Inlines:walk(filter) end

-- TBD
---@alias Cite table

---@class Code
---@field text string code string
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Code'
---@field t 'Code'

-- TBD
---@alias Emph table

---@class Image
---@field caption (Inlines | Inline[]) text used to describe the image
---@field src string path to the image file
---@field title string brief image description
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Image'
---@field t 'Image'

-- TBD
---@alias LineBreak table

---@class Link
---@field attr Attr attributes
---@field content (Inlines | Inline[]) text for this link
---@field target string the link target
---@field title string brief link description
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Link'
---@field t 'Link'

---@class Math
---@field mathtype ('InlineMath' | 'DisplayMath')
---@field text string
---@field tag 'Math'
---@field t 'Math'

---@class Note Footnote or endnote. A Note is the only inline element which can contain Block content. Values of this type can be created with the `pandoc.Note` constructor.
---@field content (Blocks | Block[]) note content
---@field tag 'Note'
---@field t 'Note'

-- TBD
---@alias Quoted table

---@class RawInline
---@field format string the format of the content
---@field text string raw content
---@field tag 'RawInline'
---@field t 'RawInline'

-- TBD
---@alias SmallCaps table

-- TBD
---@alias SoftBreak table

---@class Space
---@field tag 'Space'
---@field t 'Space'

---@class Span
---@field attr Attr attributes
---@field content (Inlines | Inline[]) wrapped content
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Span'
---@field t 'Span'

---@class Str
---@field tag 'Str'
---@field text string Content

-- TBD
---@alias Strikeout table

-- TBD
---@alias Strong table

-- TBD
---@alias Subscript table

-- TBD
---@alias Superscript table

-- TBD
---@alias Underline table


-- Element components ------------------------------------------------------------------------------

---@alias Alignment 'AlignDefault' | 'AlignLeft' | 'AlignRight' | 'AlignCenter'

---@class Attr
---@field identifier string element identifier
---@field classes string[] element classes
---@field attributes Attributes element attributes

---@alias Attributes table<string, string> collection of key/value pairs

---@class Caption The caption of a table, with an optional short caption.
---@field long (Blocks | Block[])
---@field short (Inlines | Inline[])

---@class Cell A table cell.
---@field alignment Alignment individual cell alignment
---@field contents (Blocks | Block[]) cell contents
---@field col_span integer number of columns spanned by the cell; the width of the cell in columns
---@field row_span integer number of rows spanned by the cell; the height of the cell in rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`

---@alias ColSpec [Alignment, number]

---@class Row A table row.
---@field attr Attr element attributes
---@field cells Cell[] list of table cells

---@class TableBody A body of a table, with an intermediate head and the specified number of row header columns.
---@field attr Attr table body attributes
---@field body Row[] table body rows
---@field head Row[] intermediate head
---@field row_head_columns number Number of columns taken up by the row head of each row of a TableBody. The row body takes up the remaining columns.

---@class TableFoot The foot of a table.
---@field attr Attr table foot attributes
---@field rows Row[] list of rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`

---@class TableHead The head of a table.
---@field attr Attr table head attributes
---@field rows Row[] list of rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`


-- Other types -------------------------------------------------------------------------------------

---@class ReaderOptions
---@field abbreviations string[] set of known abbreviations
---@field columns integer number of columns in terminal
---@field default_image_extension string default extension for images
---@field indented_code_classes string[] default classes for indented code blocks
---@field standalone boolean whether the input was a standalone document with header
---@field strip_comments boolean whether HTML comments were stripped instead of parsed as raw HTML
---@field tab_stop integer width (i.e. equivalent number of spaces) of tab stops
---@field track_changes 'accept-changes' | 'reject-changes' | 'all-changes' track changes setting for docx

---@class WriterOptions
---@field number_sections boolean
---@field number_offset integer[]
---@field html_math_method HTMLMathMethod
---@class WriterOptions

---@alias HTMLMathMethod
---| 'plain'
---| 'mathjax'
---| 'mathml'
---| 'webtex'
---| 'katex'
---| 'gladtex'
---| { method: ('plain' | 'mathjax' | 'mathml' | 'webtex' | 'katex' | 'gladtex'), url: string }


-- Module pandoc =======================================================================================================

pandoc = {}

---Returns new Pandoc document.
---@param blocks (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string)
---@param meta? Meta
---@return Pandoc
pandoc.Pandoc = function(blocks, meta) end

-- TBD: Meta

---TBD: MetaBlocks

-- TBD: MetaBool

-- TBD: MetaInlines

-- TBD: MetaList

-- TBD: MetaMap

-- TBD: MetaString

-- TBD: BlockQuote

-- TBD: BulletList

-- TBD: 
---Creates a CodeBlock block-level element.
---@param text string code string
---@param attr? Attr element attributes
---@return CodeBlock
pandoc.CodeBlock = function(text, attr) end

-- TBD: DefinitionList

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

-- TBD: HorizontalRule

-- TBD: LineBlock

-- TBD: OrderedList

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

---Creates a list of Blocks.
---@param block_like_elements (Blocks | Block[] | Inlines | Inline[] | Inline | string[] | string) list where each element can be treated as a Block, or a single such value
---@return Blocks
pandoc.Blocks = function(block_like_elements) end

-- TBD: Cite

---Creates a Code inline element.
---@param code string code string
---@param attr? Attr element attributes
---@return Code
pandoc.Code= function(code, attr) end

-- TBD: Emph

---Creates an Image inline element.
---@param caption (Inlines | Inline[] | Inline | string[] | string) text used to describe the image
---@param str string path to the image file
---@param title? string brief image description
---@param attr? Attr image attributes
---@return Image
pandoc.Image = function(caption, str, title, attr) end

-- TBD: LineBreak

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

-- TBD: Quoted

---Creates a RawInline inline element.
---@param format string format of content
---@param text string string content
---@return RawInline
pandoc.RawInline = function(format, text) end

-- TBD: SmallCaps

-- TBD: SoftBreak

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

-- TBD: Strikeout

-- TBD: Strong

-- TBD: Subscript

-- TBD: Superscript

-- TBD: Underline

---Creates a list of Inlines.
---@param inline_like_elements (Inlines | Inline[] | Inline | string[] | string)
---@return Inlines
pandoc.Inlines = function(inline_like_elements) end

---Creates a new set of attributes.
---@param identifier? string
---@param classes? string[]
---@param attributes? Attributes
---@return Attr
pandoc.Attr = function(identifier, classes, attributes) end

-- TBD: Cell

-- TBD: AttributeList

-- TBD: Citation

-- TBD: ListAttributes

-- TBD: Row

-- TBD: TableFoot

-- TBD: TableHead

-- TBD: SimpleTable


-- Other constructors ------------------------------------------------------------------------------

-- TBD: ReaderOptions

-- TBD: WriterOptions


-- Helper functions --------------------------------------------------------------------------------

-- TBD: pipe

---Parses the given string into a Pandoc document.
---@param markup string The markup to be parsed.
---@param format? string | {format: string, extensions: (string[] | table<string, (boolean | 'enable' | 'disable')>)} The format parameter defines the format flavor that will be parsed. This can be either a string, using + and - to enable and disable extensions, or a table with fields format (string) and extensions (table). The extensions table can be a list of all enabled extensions, or a table with extensions as keys and their activation status as values (true or 'enable' to enable an extension, false or 'disable' to disable it).
---@param reader_options? ReaderOptions | table<string, any> Options passed to the reader; may be a ReaderOptions object or a table with a subset of the keys and values of a ReaderOptions object; defaults to the default values documented in the manual.
---@return Pandoc
pandoc.read = function(markup, format, reader_options) end

---Converts a document to the given target format.
---@param doc Pandoc Document to convert.
---@param format? string | {format: string, extensions: (string[] | table<string, (boolean | 'enable' | 'disable')>)} The format parameter defines the format flavor that will be written. This can be either a string, using + and - to enable and disable extensions, or a table with fields format (string) and extensions (table). The extensions table can be a list of all enabled extensions, or a table with extensions as keys and their activation status as values (true or 'enable' to enable an extension, false or 'disable' to disable it).
---@param writer_options? WriterOptions | table<string, any> Options passed to the writer; may be a WriterOptions object or a table with a subset of the keys and values of a WriterOptions object; defaults to the default values documented in the manual.
---@return string
pandoc.write = function(doc, format, writer_options) end


-- Globals =============================================================================================================

---@type WriterOptions
PANDOC_WRITER_OPTIONS = {}

---@type string
FORMAT = ''

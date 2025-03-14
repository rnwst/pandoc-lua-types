-- Pandoc filter type definitions
-- lua-language-server's type checking is not currently as powerful as it could be - see https://github.com/LuaLS/lua-language-server/issues/3101
-- That being said, it seems to catch at least 90% of my errors! 
---@meta


-- Lua types ===========================================================================================================

-- Pandoc ------------------------------------------------------------------------------------------

---@class (exact) Pandoc
---@field blocks (Blocks | Block[]) document content
---@field meta Meta document meta information
---@field walk fun(filter: Filter): Pandoc


-- Meta --------------------------------------------------------------------------------------------

-- TBD - don't forget about `clone` and `walk` methods!
---@alias Meta {[string]: any}


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
Blocks.__name = 'Blocks'

---Blocks constructor
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
---@param filter Filter
---@return Blocks
function Blocks:walk(filter) end

---@class (exact) BlockQuote
---@field content (Blocks | Block[]) block content
---@field tag 'BlockQuote'
---@field t 'BlockQuote'

---@class (exact) BulletList
---@field content (Blocks | Block[])[] list items, list of a list of block-level elements
---@field tag 'BulletList'
---@field t 'BulletList'

---@class (exact) CodeBlock
---@field text string code string
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'CodeBlock'
---@field t 'CodeBlock'

---@class (exact) DefinitionList
---@field content [(Inlines | Inline[]), (Blocks | Block[])][] a list of tuples, where a tuple consists of a list of inline-level elements, and list of a list of block-level elements 
---@field tag 'DefinitionList'
---@field t 'DefinitionList'

---@class (exact) Div
---@field content (Blocks | Block[]) block content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Div'
---@field t 'Div'

---@class (exact) Figure
---@field content (Blocks | Block[])
---@field caption Caption
---@field attr Attr
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Figure'
---@field t 'Figure'

---@class (exact) Header
---@field level integer header level
---@field content (Inlines | Inline[]) inline content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Header'
---@field t 'Header'

---@class (exact) HorizontalRule
---@field tag 'HorizontalRule'
---@field t 'HorizontalRule'

---@class (exact) LineBlock
---@field content (Inlines | Inline[]) list of lines, i.e. list of inline elements
---@field tag 'LineBlock'
---@field t 'LineBlock'

---@class (exact) OrderedList
---@field content (Blocks | Block[])[] list items, list of a list of block-level elements
---@field listAttributes ListAttributes list parameters
---@field start integer alias for `listAttributes.start`
---@field style string alias for `listAttributes.style`
---@field delimiter string alias for `listAttributes.delimiter`

---@class (exact) Para
---@field content (Inlines | Inline[]) inline content
---@field tag 'Para'
---@field t 'Para'

---@class (exact) Plain
---@field content (Inlines | Inline[])
---@field tag 'Plain'
---@field t 'Plain'

---@class (exact) RawBlock
---@field format string format of content
---@field text string raw content
---@field tag 'RawBlock'
---@field t 'RawBlock'

---@class (exact) Table
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
Inlines.__name = 'Inlines'

---Inlines constructor
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
---@param filter Filter
---@return Inlines
function Inlines:walk(filter) end

---@class (exact) Cite
---@field content (Inlines | Inline[]) citation content
---@field citations Citation[] list of citations
---@field tag 'Cite'
---@field t 'Cite'

---@class (exact) Code
---@field text string code string
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Code'
---@field t 'Code'

---@class (exact) Emph
---@field content (Inlines | Inline[])
---@field tag 'Emph'
---@field t 'Emph'

---@class (exact) Image
---@field caption (Inlines | Inline[]) text used to describe the image
---@field src string path to the image file
---@field title string brief image description
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Image'
---@field t 'Image'

---@class (exact) LineBreak
---@field tag 'LineBreak'
---@field t 'LineBreak'

---@class (exact) Link
---@field attr Attr attributes
---@field content (Inlines | Inline[]) text for this link
---@field target string the link target
---@field title string brief link description
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Link'
---@field t 'Link'

---@class (exact) Math
---@field mathtype ('InlineMath' | 'DisplayMath')
---@field text string
---@field tag 'Math'
---@field t 'Math'

---@class (exact) Note Footnote or endnote. A Note is the only inline element which can contain Block content. Values of this type can be created with the `pandoc.Note` constructor.
---@field content (Blocks | Block[]) note content
---@field tag 'Note'
---@field t 'Note'

---@class (exact) Quoted
---@field quotetype ('SingleQuote' | 'DoubleQuote')
---@field content (Inlines | Inline[])
---@field tag 'Quoted'
---@field t 'Quoted'

---@class (exact) RawInline
---@field format string the format of the content
---@field text string raw content
---@field tag 'RawInline'
---@field t 'RawInline'

---@class (exact) SmallCaps
---@field content (Inlines | Inline[]) small caps content
---@field tag 'SmallCaps'
---@field t 'SmallCaps'

---@class (exact) SoftBreak
---@filed tag 'SoftBreak'
---@field t 'SoftBreak'

---@class (exact) Space
---@field tag 'Space'
---@field t 'Space'

---@class (exact) Span
---@field attr Attr attributes
---@field content (Inlines | Inline[]) wrapped content
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Span'
---@field t 'Span'

---@class (exact) Str
---@field tag 'Str'
---@field text string Content

---@class (exact) Strikeout
---@field content (Inlines | Inline[]) struck out content
---@field tag 'Strikeout'
---@field t 'Strikeout'

---@class (exact) Strong
---@field content (Inlines | Inline[]) inline content
---@field tag 'Strong'
---@field t 'Strong'

---@class (exact) Subscript
---@field content (Inlines | Inline[]) inline content
---@field tag 'Subscript'
---@field t 'Subscript'

---@class (exact) Superscript
---@field content (Inlines | Inline[]) inline content
---@field tag 'Superscript'
---@field t 'Superscript'

---@class (exact) Underline
---@field content (Inlines | Inline[]) inline content
---@field tag 'Underline'
---@field t 'Underline'


-- Element components ------------------------------------------------------------------------------

---@alias Alignment 'AlignDefault' | 'AlignLeft' | 'AlignRight' | 'AlignCenter'

---@class (exact) Attr
---@field identifier string element identifier
---@field classes string[] element classes
---@field attributes Attributes element attributes

---@alias Attributes table<string, string> collection of key/value pairs

---@class (exact) Caption The caption of a table, with an optional short caption.
---@field long (Blocks | Block[])
---@field short (Inlines | Inline[])

---@class (exact) Cell A table cell.
---@field alignment Alignment individual cell alignment
---@field contents (Blocks | Block[]) cell contents
---@field col_span integer number of columns spanned by the cell; the width of the cell in columns
---@field row_span integer number of rows spanned by the cell; the height of the cell in rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`

---@class (exact) Citation
---@field id string citation identifier, e.g. a bibtex key
---@field mode CitationMode citation mode
---@field prefix (Inlines | Inline[]) citation prefix
---@field suffix (Inlines | Inline[]) citation suffix
---@field note_num integer note number
---@field hash integer hash

---@alias CitationMode ('AuthorInText' | 'SuppressAuthor' | 'NormalCitation')

---@alias ColSpec [Alignment, number]

---@class (exact) ListAttributes
---@field start integer number of the first list item
---@field style ListNumberStyle style used for list numbers
---@field delimiter ListNumberDelim delimiter of list numbers

---@alias ListNumberStyle ('DefaultStyle' | 'Example' | 'Decimal' | 'LowerRoman' | 'UpperRoman' | 'LowerAlpha' | 'UpperAlpha')

---@alias ListNumberDelim ('DefaultDelim' | 'Period' | 'OneParen' | 'TwoParens')

---@class (exact) Row A table row.
---@field attr Attr element attributes
---@field cells Cell[] list of table cells

---@class (exact) TableBody A body of a table, with an intermediate head and the specified number of row header columns.
---@field attr Attr table body attributes
---@field body Row[] table body rows
---@field head Row[] intermediate head
---@field row_head_columns number Number of columns taken up by the row head of each row of a TableBody. The row body takes up the remaining columns.

---@class (exact) TableFoot The foot of a table.
---@field attr Attr table foot attributes
---@field rows Row[] list of rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`

---@class (exact) TableHead The head of a table.
---@field attr Attr table head attributes
---@field rows Row[] list of rows
---@field identifier string alias for `attr.identifier`
---@field classes string[] alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`


-- Other types -------------------------------------------------------------------------------------

-- Fields of ReaderOptions and WriterOptions are all optional since the
-- `reader_options` and `writer_options` arguments of the `pandoc.read`
-- and `pandoc.write` functions can take tables with a subset of the fields
-- of ReaderOptions and WriterOptions. This way, the `reader_options` and
-- `writer_options` arguments can be declared to be of type ReaderOptions
-- and WriterOptions respectively, without needing to define more types
-- with optional fields (which one might have called ReaderOptionsSubset or
-- similar...).

---@class (exact) ReaderOptions
---@field abbreviations?           string[]           set of known abbreviations
---@field columns?                 integer            number of columns in terminal
---@field default_image_extension? string             default extension for images
---@field indented_code_classes?   string[]           default classes for indented code blocks
---@field standalone?              boolean            whether the input was a standalone document with header
---@field strip_comments?          boolean            whether HTML comments were stripped instead of parsed as raw HTML
---@field tab_stop?                integer            width (i.e. equivalent number of spaces) of tab stops
---@field track_changes?           TrackChangesOption track changes setting for docx

---@alias TrackChangesOption
---| 'accept-changes'
---| 'reject-changes'
---| 'all-changes'

---@alias Extension
---| 'smart'
---| 'auto_identifiers'
---| 'ascii_identifiers'
---| 'gfm_auto_identifiers'
---| 'tex_math_dollars'
---| 'tex_math_gfm'
---| 'tex_math_single_backslash'
---| 'tex_math_double_backslash'
---| 'raw_html'
---| 'raw_tex'
---| 'native_divs'
---| 'native_spans'
---| 'literate_haskell'
---| 'empty_paragraphs'
---| 'native_numbering'
---| 'xrefs_name'
---| 'xrefs_number'
---| 'styles'
---| 'amuse'
---| 'raw_markdown'
---| 'citations'
---| 'fancy_lists'
---| 'element_citations'
---| 'ntb'
---| 'tagging'

---@class (exact) WriterOptions
---@field chunk_template?     string                 template used to generate chunked HTML filenames
---@field cite_method?        CiteMethod             how to print cites
---@field columns?            integer                number of characters in a line (for text wrapping)
---@field dpi?                integer                DPI for pixel to/from inch/cm conversions
---@field email_obfuscation?  EmailObfuscationMethod how to obfuscate emails
---@field epub_chapter_level? integer                header level for chapters, i.e. how the document is split into separate files
---@field epub_fonts?         string[]               paths to fonts to embed
---@field epub_metadata?      (string | nil)         metadata to include in EPUB
---@field epub_subdirectory?  string                 subdirectory for epub in OCF
---@field extensions?         Extension[]            writer extensions to use
---@field highlight_style?    (table | nil)          style to use for syntax highlighting
---@field html_math_method?   HTMLMathMethod         how to print math in HTML
---@field html_q_tags?        boolean                whether to use `<q>` tags for quotes in HTML
---@field identifier_prefix?  string                 prefix for section and note ids in HTML and for footnote marks in markdown
---@field incremental?        boolean                whether lists in slide shows should be displayed incrementally
---@field listings?           boolean                whether to use listings package for code
---@field number_offset?      integer[]              starting numbers for section, subsection, ...
---@field number_sections?    boolean                whether to number sections in LaTeX
---@field prefer_ascii?       boolean                whether to prefer ASCII representations of characters when possible
---@field reference_doc?      (string | nil)         path to reference document if specified
---@field reference_links?    boolean                whether to use reference links in writing markdown, rst
---@field reference_location? ReferenceLocation      location of footnotes and references for writing markdown
---@field section_divs?       boolean                whether to put sections in div tags in HTML
---@field setext_headers?     boolean                whether to use setext headers for levels 1-2 in markdown
---@field slide_level?        (integer | nil)        force header level of slides
---@field tab_stop?           integer                number of spaces per tab for conversion between spaces and tabs
---@field table_of_contents?  boolean                whether to include table of contents
---@field template?           (Template | nil)       template to use
---@field toc_depth?          integer                number of levels to include in TOC
---@field top_level_division? TopLevelDivision       type of top-level divisions
---@field variables?          table<string, any>     variables to set in template
---@field wrap_text?          TextWrapMethod         option for wrapping text

---@alias CiteMethod ('citeproc' | 'natbib' | 'biblatex')
---@alias EmailObfuscationMethod ('none' | 'references' | 'javascript')
---@alias ReferenceLocation ('end-of-block' | 'block' | 'end-of-section' | 'section' | 'end-of-document' | 'document')
---@alias TopLevelDivision ('top-level-part' | 'part' | 'top-level-chapter' | 'chapter' | 'top-level-section' | 'section' | 'top-level-default' | 'default')
---@alias TextWrapMethod ('wrap-auto' | 'auto' | 'wrap-none' | 'none' | 'wrap-preserve' | 'preserve')

---@alias HTMLMathMethod
---| 'plain'
---| 'mathjax'
---| 'mathml'
---| 'webtex'
---| 'katex'
---| 'gladtex'
---| { method: ('plain' | 'mathjax' | 'mathml' | 'webtex' | 'katex' | 'gladtex'), url: string }

-- TBD: CommonState

-- TBD: Doc

---@class List
List = {}
List.__index = List
List.__name = 'List'

---List constructor
---@param list List
---@return List
function Blocks:new(list)
   setmetatable(list, self)
   return list
end

-- TBD: missing List methods

-- TBD: LogMessage

-- TBD: SimpleTable

---@class Template opaque type holding a compiled template

-- TBD: Version

-- TBD: Chunk

-- TBD: ChunkedDoc


-- Globals =============================================================================================================

---@type WriterOptions
PANDOC_WRITER_OPTIONS = {}

---@type string
FORMAT = ''


-- Filters =============================================================================================================

-- I wasn't sure if this recursive definition would work, but there seem to be no complaints from lua-language-server!
---@alias Filter (FilterTable | Filter)[]

---@class (exact) FilterTable
---@field traverse?       ('topdown' | 'typewise')
---@field Pandoc?         fun(blocks: Blocks, meta: Meta):      Pandoc | nil
---@field Meta?           fun(meta: Meta):                      Meta   | nil
---@field Blocks?         fun(blocks: Blocks):                  Blocks  | Block[]  | nil, false?
---@field Inlines?        fun(inlines: Inlines):                Inlines | Inline[] | nil, false?
---@field BlockQuote?     fun(block_quote: BlockQuote):         Block | Blocks | Block[] | nil, false?
---@field BulletList?     fun(bullet_list: BulletList):         Block | Blocks | Block[] | nil, false?
---@field CodeBlock?      fun(code_block:CodeBlock):            Block | Blocks | Block[] | nil, false?
---@field DefinitionList? fun(definition_list: DefinitionList): Block | Blocks | Block[] | nil, false?
---@field Div?            fun(div: Div):                        Block | Blocks | Block[] | nil, false?
---@field Figure?         fun(figure: Figure):                  Block | Blocks | Block[] | nil, false?
---@field Header?         fun(header: Header):                  Block | Blocks | Block[] | nil, false?
---@field HorizontalRule? fun(horizontal_rule: HorizontalRule): Block | Blocks | Block[] | nil, false?
---@field LineBlock?      fun(line_block: LineBlock):           Block | Blocks | Block[] | nil, false?
---@field OrderedList?    fun(ordered_list: OrderedList):       Block | Blocks | Block[] | nil, false?
---@field Para?           fun(para: Para):                      Block | Blocks | Block[] | nil, false?
---@field Plain?          fun(plain: Plain):                    Block | Blocks | Block[] | nil, false?
---@field RawBlock?       fun(raw_block: RawBlock):             Block | Blocks | Block[] | nil, false?
---@field Table?          fun(table: Table):                    Block | Blocks | Block[] | nil, false?
---@field Cite?           fun(cite: Cite):                      Inline | Inlines | Inline[] | nil, false?
---@field Code?           fun(code: Code):                      Inline | Inlines | Inline[] | nil, false?
---@field Emph?           fun(emph: Emph):                      Inline | Inlines | Inline[] | nil, false?
---@field Image?          fun(image: Image):                    Inline | Inlines | Inline[] | nil, false?
---@field LineBreak?      fun(line_break: LineBreak):           Inline | Inlines | Inline[] | nil, false?
---@field Link?           fun(link: Link):                      Inline | Inlines | Inline[] | nil, false?
---@field Math?           fun(math: Math):                      Inline | Inlines | Inline[] | nil, false?
---@field Note?           fun(note: Note):                      Inline | Inlines | Inline[] | nil, false?
---@field Quoted?         fun(quoted: Quoted):                  Inline | Inlines | Inline[] | nil, false?
---@field RawInline?      fun(raw_inline: RawInline):           Inline | Inlines | Inline[] | nil, false?
---@field SmallCaps?      fun(small_caps: SmallCaps):           Inline | Inlines | Inline[] | nil, false?
---@field SoftBreak?      fun(soft_break: SoftBreak):           Inline | Inlines | Inline[] | nil, false?
---@field Space?          fun(space: Space):                    Inline | Inlines | Inline[] | nil, false?
---@field Span?           fun(span: Span):                      Inline | Inlines | Inline[] | nil, false?
---@field Str?            fun(str: Str):                        Inline | Inlines | Inline[] | nil, false?
---@field Strikeout?      fun(strikeout: Strikeout):            Inline | Inlines | Inline[] | nil, false?
---@field Strong?         fun(strong: Strong):                  Inline | Inlines | Inline[] | nil, false?
---@field Subscript?      fun(subscript: Subscript):            Inline | Inlines | Inline[] | nil, false?
---@field Superscript?    fun(superscript: Superscript):        Inline | Inlines | Inline[] | nil, false?
---@field Underline?      fun(underline: Underline):            Inline | Inlines | Inline[] | nil, false?


-- Module pandoc =======================================================================================================

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

---Creates a list of Blocks.
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

-- TBD: improve description of function --- mention available List methods.
---Creates a table which will be treated by pandoc as a List rather than a Map.
---This is useful when passing an empty table as a MetaValue to ensure it is treated as a List.
---Sets the table's metatable, which has the field `__name` with value 'List'.
---@param tbl table
---@return List
pandoc.List = function(tbl) end

-- TBD: SimpleTable
---Creates a SimpleTable object.
pandoc.SimpleTable = function(caption, align, widths, header, rows) end


-- Other constructors ------------------------------------------------------------------------------

-- TBD: ReaderOptions

-- TBD: WriterOptions


-- Helper functions --------------------------------------------------------------------------------

-- TBD: pipe

-- TBD: walk_block

-- TBD: walk_inline

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

-- TBD: write_classic

-- Other modules =======================================================================================================

-- TBD: pandoc.cli

-- TBD: pandoc.utils

-- TBD: pandoc.mediabag

-- TBD: pandoc.format

-- TBD: pandoc.image

-- TBD: pandoc.json

-- TBD: pandoc.log

-- TBD: pandoc.path

-- TBD: pandoc.structure

-- TBD: pandoc.system

-- TBD: pandoc.layout

-- TBD: pandoc.scaffolding

-- TBD: pandoc.text

-- TBD: pandoc.text

-- TBD: pandoc.template

-- TBD: pandoc.types

-- TBD: pandoc.zip

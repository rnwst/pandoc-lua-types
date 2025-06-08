-- Pandoc type definitions
-- lua-language-server's type checking is not currently as powerful as it could be - see https://github.com/LuaLS/lua-language-server/issues/3101
-- That being said, it seems to catch at least 90% of my errors! 
---@meta

-- `clone` method ----------------------------------------------------------------------------------

---@class Cloneable
Cloneable = {}

---Creates a clone of the element.
---@generic T
---@param self T
---@return T
function Cloneable:clone() end


-- `walk` method -----------------------------------------------------------------------------------

---@class Walkable: Cloneable
Walkable = {}

---Applies a Lua filter to the element. The order in which elements are
---traversed can be controlled by setting the `traverse` field of the filter.
---Returns a (deep) copy on which the filter has been applied: the original
---object is left untouched.
---@generic T
---@param self T
---@param filter Filter
---@return T
function Walkable:walk(filter) end


-- Pandoc ------------------------------------------------------------------------------------------

---@class (exact) Pandoc: Walkable
---@field blocks (Blocks | Block[]) document content
---@field meta Meta document meta information


-- Meta --------------------------------------------------------------------------------------------

---@class (exact) Meta: Walkable
---@field [string] MetaValue

---@alias MetaValue
---| MetaBool
---| MetaString
---| MetaInlines
---| MetaBlocks
---| MetaList
---| MetaMap

---@alias MetaBool boolean

---@alias MetaString (string | number)

---@alias MetaInlines Inlines

---@alias MetaBlocks Blocks

---@alias MetaList {[integer]: MetaValue}

---@alias MetaMap {[string]: MetaValue}


-- List --------------------------------------------------------------------------------------------

---@class List<T>: {[integer]: T}  A Pandoc List
---@operator concat(List): List
---@overload fun(tbl: table): List
pandoc.List = {}
pandoc.List.__index = pandoc.List
pandoc.List.__name = 'List'
pandoc.List.__call = pandoc.List.new

---Creates a table which will be treated by pandoc as a List rather than a Map.
---This is useful when passing an empty table as a MetaValue to ensure it is
---treated as a List. It is also useful for making List methods such as `find`,
---`filter`, `includes`, `insert`, `map`, `remove`, and `sort` available on an
---existing list, as well as the metamethods `__concat` and `__eq`, which allow
---for concatenation and to test for equality of Lists.
---@param tbl table
---@return List
function pandoc.List:new(tbl)
   setmetatable(tbl, self)
   return tbl
end

---Returns the element at the given index, or `default`
---if the List contains no item at the given position.
---@generic T
---@param self List<T>
---@param index integer
---@param default? T
---@return T | nil
function pandoc.List:at(index, default) end

---Returns a shallow copy of the List. (To get a deep copy, use `walk` with an empty filter.)
---@generic T
---@self List<T>
---@return List<T>
function pandoc.List:clone() end

---Adds the given List to the end of this List. The same can be achieved by using
---the concatenation operator (`..`).
---@generic T
---@param list List<T>
---@return List<T>
function pandoc.List:extend(list) end

---Returns the value and index of the first occurrence of the given item.
---@generic T
---@param needle T        item to search for
---@param init?  integer  index at which the search is started
---@return T, integer | nil
function pandoc.List:find(needle, init) end

---Returns the value and index of the first element for which the predicate holds true.
---@generic T
---@param self  List<T>
---@param pred  fun(T): boolean  the predicate function
---@param init? integer          index at which the search is started
---@return T, integer | nil
function pandoc.List:find_if(pred, init) end

---Returns a new List containing all items satisfying a given condition.
---@generic T
---@param self List<T>
---@param pred fun(T): boolean  the predicate function
---@return List<T>
function pandoc.List:filter(pred) end

---Checks if the List has an item equal to the given needle.
---@generic T
---@param self   List<T>
---@param needle T        item to search for
---@param init?  integer  index at which the search is started
---@return boolean
function pandoc.List:includes(needle, init) end

---Inserts element `value` at position `pos` in List, shifting elements to the next-greater index if necessary.
---This function is identical to `table.insert`.
---@generic T
---@param self  List<T>
---@param pos   integer  index of new value; defaults to length of the List + 1
---@param value T        value to insert into the List
function pandoc.List:insert(pos, value) end

---Append element `value` to the end of the List.
---This function is identical to `table.insert`.
---@generic T
---@param self  List<T>
---@param value T        value to insert into the List
function pandoc.List:insert(value) end

---Create an iterator over the List. The resulting function returns the next value each time it is called.
---
---Usage:
---```
---for item in List{1, 1, 2, 3, 5, 8}:iter() do
---  -- process item
---end
---```
---@generic T
---@param self List<T>
---@param step? integer  step width with which to step through the List; negative step sizes cause the iterator to start from the end of the List; defaults to 1
---@return fun(): T
function pandoc.List:iter(step) end

---Returns a copy of the current List by applying the given function to all elements.
---@generic T
---@param self List<T>
---@param fn fun(item: T): any  function which is applied to all List items
---@return List<T>
function pandoc.List:map(fn) end

---Removes the element at position `pos`, returning the value of the removed element.
---This function is identical to `table.remove`.
---@generic T
---@param self List<T>
---@param pos integer  position of the List value to be removed; defaults to the index of the last element
---@return List<T>
function pandoc.List:remove(pos) end

---Sorts List elements in a given order, in-place. If `comp` is given, then it
---must be a function that receives two List elements and returns `true` when
---the first element must come before the second in the final order (so that,
---after the sort, `i < j` implies `not comp(list[j],list[i]))`. If `comp` is
---not given, then the standard Lua operator `<` is used instead.
---
---Note that the comp function must define a strict partial order over the
---elements in the List; that is, it must be asymmetric and transitive.
---Otherwise, no valid sort may be possible.
---
---The sort algorithm is not stable: elements considered equal by the given
---order may have their relative positions changed by the sort.
---
---This function is identical to `table.sort`.
---@generic T
---@param self List<T>
---@param comp? fun(T, T): boolean  comparison function
---@return List<T>
function pandoc.List:sort(comp) end


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

---@class Blocks: List<Block>  A List of block-level elements
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

---Applies a Lua filter to the Blocks List. Just as for
---full-document filters, the order in which elements are
---traversed can be controlled by setting the `traverse` field
---of the filter. The filter is applied to all List items
---and to the List itself. Returns a (deep) copy on which
---the filter has been  applied: the original List is left
---untouched.
---@param filter Filter
---@return Blocks
function Blocks:walk(filter) end

---@class (exact) BlockQuote: Walkable
---@field content (Blocks | Block[])  block content
---@field tag 'BlockQuote'
---@field t 'BlockQuote'

---@class (exact) BulletList: Walkable
---@field content (List<(Blocks | Block[])> | (Blocks | Block[])[])  List items, List of a List of block-level elements
---@field tag 'BulletList'
---@field t 'BulletList'

---@class (exact) CodeBlock: Cloneable
---@field text string code string
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'CodeBlock'
---@field t 'CodeBlock'

---@class (exact) DefinitionList: Walkable
---@field content (List<[(Inlines | Inline[]), (Blocks | Block[])]> | [(Inlines | Inline[]), (Blocks | Block[])][]) a List of tuples, where a tuple consists of a List of inline-level elements, and List of a List of block-level elements 
---@field tag 'DefinitionList'
---@field t 'DefinitionList'

---@class (exact) Div: Walkable
---@field content (Blocks | Block[]) block content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Div'
---@field t 'Div'

---@class (exact) Figure: Walkable
---@field content (Blocks | Block[])
---@field caption Caption
---@field attr Attr
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Figure'
---@field t 'Figure'

---@class (exact) Header: Walkable
---@field level integer header level
---@field content (Inlines | Inline[]) inline content
---@field attr Attr element attributes
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Header'
---@field t 'Header'

---@class (exact) HorizontalRule: Cloneable
---@field tag 'HorizontalRule'
---@field t 'HorizontalRule'

---@class (exact) LineBlock: Walkable
---@field content (Inlines | Inline[])  List of lines, i.e. List of inline elements
---@field tag 'LineBlock'
---@field t 'LineBlock'

---@class (exact) OrderedList: Walkable
---@field content        (List<(Blocks | Block[])> | (Blocks | Block[])[])  List items, List of a List of block-level elements
---@field listAttributes ListAttributes                                     List parameters
---@field start          integer                                            alias for `listAttributes.start`
---@field style          ListNumberStyle                                    alias for `listAttributes.style`
---@field delimiter      ListNumberDelim                                    alias for `listAttributes.delimiter`

---@class (exact) Para: Walkable
---@field content (Inlines | Inline[]) inline content
---@field tag 'Para'
---@field t 'Para'

---@class (exact) Plain: Walkable
---@field content (Inlines | Inline[])
---@field tag 'Plain'
---@field t 'Plain'

---@class (exact) RawBlock: Cloneable
---@field format string format of content
---@field text string raw content
---@field tag 'RawBlock'
---@field t 'RawBlock'

---@class (exact) Table: Walkable
---@field attr Attr table attributes
---@field caption Caption table caption
---@field colspecs ColSpec column specifications, i.e. alignments and widths
---@field head TableHead table head
---@field bodies (List<TableBody> | TableBody[]) table bodies
---@field foot TableFoot table foot
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
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

---@class Inlines: List<Inline>  A List of inline elements
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

---Applies a Lua filter to the Inlines List. Just as for
---full-document filters, the order in which elements are
---traversed can be controlled by setting the 'traverse' field
---of the filter. The filter is applied to all List items
---and to the List itself. Returns a (deep) copy on which
---the filter has been  applied: the original List is left
---untouched.
---@param filter Filter
---@return Inlines
function Inlines:walk(filter) end

---@class (exact) Cite: Walkable
---@field content (Inlines | Inline[])             citation content
---@field citations (List<Citation> | Citation[])  List of citations
---@field tag 'Cite'
---@field t 'Cite'

---@class (exact) Code: Cloneable
---@field text string code string
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Code'
---@field t 'Code'

---@class (exact) Emph: Walkable
---@field content (Inlines | Inline[])
---@field tag 'Emph'
---@field t 'Emph'

---@class (exact) Image: Cloneable
---@field caption (Inlines | Inline[]) text used to describe the image
---@field src string path to the image file
---@field title string brief image description
---@field attr Attr attributes
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Image'
---@field t 'Image'

---@class (exact) LineBreak: Cloneable
---@field tag 'LineBreak'
---@field t 'LineBreak'

---@class (exact) Link: Walkable
---@field attr Attr attributes
---@field content (Inlines | Inline[]) text for this link
---@field target string the link target
---@field title string brief link description
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Link'
---@field t 'Link'

---@class (exact) Math: Cloneable
---@field mathtype ('InlineMath' | 'DisplayMath')
---@field text string
---@field tag 'Math'
---@field t 'Math'

---@class (exact) Note: Walkable  Footnote or endnote. A Note is the only inline element which can contain Block content. Values of this type can be created with the `pandoc.Note` constructor.
---@field content (Blocks | Block[]) note content
---@field tag 'Note'
---@field t 'Note'

---@class (exact) Quoted: Walkable
---@field quotetype ('SingleQuote' | 'DoubleQuote')
---@field content (Inlines | Inline[])
---@field tag 'Quoted'
---@field t 'Quoted'

---@class (exact) RawInline: Cloneable
---@field format string the format of the content
---@field text string raw content
---@field tag 'RawInline'
---@field t 'RawInline'

---@class (exact) SmallCaps: Walkable
---@field content (Inlines | Inline[]) small caps content
---@field tag 'SmallCaps'
---@field t 'SmallCaps'

---@class (exact) SoftBreak: Cloneable
---@filed tag 'SoftBreak'
---@field t 'SoftBreak'

---@class (exact) Space: Cloneable
---@field tag 'Space'
---@field t 'Space'

---@class (exact) Span: Walkable
---@field attr Attr attributes
---@field content (Inlines | Inline[]) wrapped content
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`
---@field tag 'Span'
---@field t 'Span'

---@class (exact) Str: Cloneable
---@field tag 'Str'
---@field text string Content

---@class (exact) Strikeout: Walkable
---@field content (Inlines | Inline[]) struck out content
---@field tag 'Strikeout'
---@field t 'Strikeout'

---@class (exact) Strong: Walkable
---@field content (Inlines | Inline[]) inline content
---@field tag 'Strong'
---@field t 'Strong'

---@class (exact) Subscript: Walkable
---@field content (Inlines | Inline[]) inline content
---@field tag 'Subscript'
---@field t 'Subscript'

---@class (exact) Superscript: Walkable
---@field content (Inlines | Inline[]) inline content
---@field tag 'Superscript'
---@field t 'Superscript'

---@class (exact) Underline: Walkable
---@field content (Inlines | Inline[]) inline content
---@field tag 'Underline'
---@field t 'Underline'


-- Element components ------------------------------------------------------------------------------

---@alias Alignment 'AlignDefault' | 'AlignLeft' | 'AlignRight' | 'AlignCenter'

---@class (exact) Attr: Cloneable
---@field identifier string element identifier
---@field classes (List<string> | string[]) element classes
---@field attributes Attributes element attributes

---@alias Attributes table<string, string> collection of key/value pairs

---@class (exact) Caption: Cloneable  The caption of a table, with an optional short caption.
---@field long (Blocks | Block[])
---@field short (Inlines | Inline[])

---@class (exact) Cell: Cloneable  A table cell.
---@field alignment Alignment individual cell alignment
---@field contents (Blocks | Block[]) cell contents
---@field col_span integer number of columns spanned by the cell; the width of the cell in columns
---@field row_span integer number of rows spanned by the cell; the height of the cell in rows
---@field identifier string alias for `attr.identifier`
---@field classes (List<string> | string[]) alias for `attr.classes`
---@field attributes Attributes alias for `attr.attributes`

---@class (exact) Citation: Cloneable
---@field id string citation identifier, e.g. a bibtex key
---@field mode CitationMode citation mode
---@field prefix (Inlines | Inline[]) citation prefix
---@field suffix (Inlines | Inline[]) citation suffix
---@field note_num integer note number
---@field hash integer hash

---@alias CitationMode ('AuthorInText' | 'SuppressAuthor' | 'NormalCitation')

---@alias ColSpec [Alignment, number]

---@class (exact) ListAttributes: Cloneable
---@field start integer number of the first list item
---@field style ListNumberStyle style used for list numbers
---@field delimiter ListNumberDelim delimiter of list numbers

---@alias ListNumberStyle ('DefaultStyle' | 'Example' | 'Decimal' | 'LowerRoman' | 'UpperRoman' | 'LowerAlpha' | 'UpperAlpha')

---@alias ListNumberDelim ('DefaultDelim' | 'Period' | 'OneParen' | 'TwoParens')

---@class (exact) Row: Cloneable  A table row.
---@field attr  Attr                   element attributes
---@field cells (List<Cell> | Cell[])  List of table cells

---@class (exact) TableBody: Cloneable  A body of a table, with an intermediate head and the specified number of row header columns.
---@field attr             Attr                  table body attributes
---@field body             (List<Row> | Row[])   table body rows
---@field head             (List<Row> | Row[])   intermediate head
---@field row_head_columns number                Number of columns taken up by the row head of each row of a TableBody. The row body takes up the remaining columns.

---@class (exact) TableFoot: Cloneable  The foot of a table.
---@field attr       Attr                       table foot attributes
---@field rows       (List<Row> | Row[])        List of rows
---@field identifier string                     alias for `attr.identifier`
---@field classes    (List<string> | string[])  alias for `attr.classes`
---@field attributes Attributes                 alias for `attr.attributes`

---@class (exact) TableHead: Cloneable  The head of a table.
---@field attr       Attr                       table head attributes
---@field rows       (List<Row> | Row[])        List of rows
---@field identifier string                     alias for `attr.identifier`
---@field classes    (List<string> | string[])  alias for `attr.classes`
---@field attributes Attributes                 alias for `attr.attributes`


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
---@field abbreviations?           (List<string> | string[])  set of known abbreviations
---@field columns?                 integer                    number of columns in terminal
---@field default_image_extension? string                     default extension for images
---@field indented_code_classes?   (List<string> | string[])  default classes for indented code blocks
---@field standalone?              boolean                    whether the input was a standalone document with header
---@field strip_comments?          boolean                    whether HTML comments were stripped instead of parsed as raw HTML
---@field tab_stop?                integer                    width (i.e. equivalent number of spaces) of tab stops
---@field track_changes?           TrackChangesOption         track changes setting for docx

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
---@field chunk_template?     string                           template used to generate chunked HTML filenames
---@field cite_method?        CiteMethod                       how to print cites
---@field columns?            integer                          number of characters in a line (for text wrapping)
---@field dpi?                integer                          DPI for pixel to/from inch/cm conversions
---@field email_obfuscation?  EmailObfuscationMethod           how to obfuscate emails
---@field epub_chapter_level? integer                          header level for chapters, i.e. how the document is split into separate files
---@field epub_fonts?         (List<string> | string[])        paths to fonts to embed
---@field epub_metadata?      (string | nil)                   metadata to include in EPUB
---@field epub_subdirectory?  string                           subdirectory for epub in OCF
---@field extensions?         (List<Extension> | Extension[])  writer extensions to use
---@field highlight_style?    (table | nil)                    style to use for syntax highlighting
---@field html_math_method?   HTMLMathMethod                   how to print math in HTML
---@field html_q_tags?        boolean                          whether to use `<q>` tags for quotes in HTML
---@field identifier_prefix?  string                           prefix for section and note ids in HTML and for footnote marks in markdown
---@field incremental?        boolean                          whether lists in slide shows should be displayed incrementally
---@field listings?           boolean                          whether to use listings package for code
---@field number_offset?      (List<integer> | integer[])      starting numbers for section, subsection, ...
---@field number_sections?    boolean                          whether to number sections in LaTeX
---@field prefer_ascii?       boolean                          whether to prefer ASCII representations of characters when possible
---@field reference_doc?      (string | nil)                   path to reference document if specified
---@field reference_links?    boolean                          whether to use reference links in writing markdown, rst
---@field reference_location? ReferenceLocation                location of footnotes and references for writing markdown
---@field section_divs?       boolean                          whether to put sections in div tags in HTML
---@field setext_headers?     boolean                          whether to use setext headers for levels 1-2 in markdown
---@field slide_level?        (integer | nil)                  force header level of slides
---@field tab_stop?           integer                          number of spaces per tab for conversion between spaces and tabs
---@field table_of_contents?  boolean                          whether to include table of contents
---@field template?           (Template | nil)                 template to use
---@field toc_depth?          integer                          number of levels to include in TOC
---@field top_level_division? TopLevelDivision                 type of top-level divisions
---@field variables?          table<string, any>               variables to set in template
---@field wrap_text?          TextWrapMethod                   option for wrapping text

---@alias CiteMethod             ('citeproc' | 'natbib' | 'biblatex')
---@alias EmailObfuscationMethod ('none' | 'references' | 'javascript')
---@alias ReferenceLocation      ('end-of-block' | 'block' | 'end-of-section' | 'section' | 'end-of-document' | 'document')
---@alias TopLevelDivision       ('top-level-part' | 'part' | 'top-level-chapter' | 'chapter' | 'top-level-section' | 'section' | 'top-level-default' | 'default')
---@alias TextWrapMethod         ('wrap-auto' | 'auto' | 'wrap-none' | 'none' | 'wrap-preserve' | 'preserve')

---@alias HTMLMathMethod
---| 'plain'
---| 'mathjax'
---| 'mathml'
---| 'webtex'
---| 'katex'
---| 'gladtex'
---| { method: ('plain' | 'mathjax' | 'mathml' | 'webtex' | 'katex' | 'gladtex'), url: string }

---@class (exact) CommonState
---@field input_files     List<string>        list of input files from command line
---@field output_file     (string | nil)      output file from command line
---@field log             List<LogMessage>    list of log messages in reverse order
---@field request_headers {[string]: string}  headers to add for HTTP requests; table with header names as keys and header contents as values
---@field resource_path   List<string>        path to search for resources like included images
---@field source_url      (string | nil)      absolute URL or directory of first source file
---@field user_data_dir   (string | nil)      directory to search for data files
---@field trace           boolean             whether tracing messages are issued
---@field verbosity       Verbosity           verbosity level

---@alias Verbosity ('INFO' | 'WARNING' | 'ERROR')

---@class Doc: userdata  Reflowable plain-text document. A Doc value can be rendered and reflown to fit a given column width.
---@operator concat(Doc): Doc 
---@operator add(Doc): Doc
---@operator div(Doc): Doc
---@operator idiv(Doc): Doc

---@class LogMessage A pandoc log message. It has no fields, but can be converted to a string via `tostring`.

---@class (exact) SimpleTable
---@field caption Inlines          table caption
---@field aligns  List<Alignment>  column alignments
---@field widths  List<number>     column widths
---@field headers Blocks           table header row
---@field rows    Blocks           table rows

---@class Template: userdata  Opaque type holding a compiled template

---@class Version: {[integer]: integer}
Version = {}
--
---Raise an error message if the actual version is older than the expected version;
---does nothing if actual is equal to or newer than the expected version.
---@param actual         Version  actual version specifier
---@param expected       Version  minimum expected version
---@param error_message? string   optional error message template --- the string is used as format string, with the expected and actual versions as arguments; defaults to ``"expected version %s or newer, got %s"`
Version.must_be_at_least = function(actual, expected, error_message) end

---@class (exact) Chunk
---@field heading        Inlines        heading text
---@field id             string         identifier
---@field level          integer        level of topmost heading in chunk
---@field number         integer        chunk number
---@field section_number string         hierarchical section number
---@field path           string         target filepath for this chunk
---@field up             (Chunk | nil)  link to the enclosing section, if any
---@field prev           (Chunk | nil)  link to the previous section, if any
---@field next           (Chunk | nil)  link to the next section, if any
---@field unlisted       boolean        whether the section in this chunk should be listed in the TOC even if the chunk has no section number
---@field contents       Blocks         the chunk's block contents

---@class (exact) ChunkedDoc
---@field chunks List<Chunk>    List of chunks that makes up the document
---@field meta   Meta           the document's metadata
---@field toc    List<SecInfo>  table of contents information

---@class (exact) SecInfo
---@field title    Inlines
---@field number   (string | nil)
---@field id       string
---@field path     string
---@field level    integer

---@class Sources: userdata  Opaque type used in custom Readers

-- Filters -----------------------------------------------------------------------------------------

-- I wasn't sure if this recursive definition would work, but there seem to be no complaints from lua-language-server!
---@alias Filter (FilterTable | Filter)[]

---@class (exact) FilterTable
---@field traverse?       ('topdown' | 'typewise')
---@field Pandoc?         fun(doc: Pandoc):                     Pandoc | nil
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

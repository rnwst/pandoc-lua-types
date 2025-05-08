-- Access to the higher-level document structure, including hierarchical
-- sections and the table of contents.
---@meta

structure = {}

---Puts [Blocks](lua://Blocks) into a hierarchical structure: a list of
---sections (each a [Div](lua://Div) with class “section” and first element a
---[Header](lua://Header)).
---
---The optional opts argument can be a table; two settings are recognized:
---If `number_sections` is true, a `number` attribute containing the section
---number will be added to each Header. If `base_level` is an integer, then
---[Header](lua://Header) levels will be reorganized so that there are no
---gaps, with numbering levels shifted by the given value. Finally, an integer
---`slide_level` value triggers the creation of slides at that heading level.
---
---Note that a WriterOptions object can be passed as the opts table; this will
---set the number_section and slide_level values to those defined on the command
---line.
---
---Usage:
--- ```lua
--- local blocks = {
---   pandoc.Header(2, pandoc.Str 'first'),
---   pandoc.Header(2, pandoc.Str 'second'),
--- }
--- local opts = PANDOC_WRITER_OPTIONS
--- local newblocks = pandoc.structure.make_sections(blocks, opts)
--- ```
---@param blocks (Blocks | Block[] | Pandoc)              document blocks to process
---@param opts?  (WriterOptions | {base_level: integer})  options
---@return Blocks # processed blocks
structure.make_sections = function(blocks, opts) end

---Find level of header that starts slides (defined as the least header level
---that occurs before a non-header/non-hrule in the blocks).
---@param blocks (Blocks | Block[] | Pandoc)  document body
---@return integer # slide level
structure.slide_level = function(blocks) end

---Converts a [Pandoc](lua://Pandoc) document into a
---[ChunkedDoc](lua://ChunkedDoc).
---
---The `opts` argument is a table, with the following options recognized:
---
---`path_template`:
-- template used to generate the chunks' filepaths `%n` will be replaced
---with the chunk number (padded with leading 0s to 3 digits), `%s` with the
---section number of the heading, `%h` with the (stringified) heading text,
---`%i` with the section identifier. For example, `"section-%s-%i.html"`
---might be resolved to `"section-1.2-introduction.html"`.
---
---`number_sections`:
---whether sections should be numbered; default is `false`.
---
---`chunk_level`:
---The heading level the document should be split into chunks. The default is to
---split at the top-level, i.e., `1`.
---
---`base_heading_level`
---The base level to be used for numbering. Default is `nil`.
---@param doc    Pandoc  document to split
---@param opts?  {path_template: string, number_sections: boolean, chunk_level: integer, base_heading_level: integer}  splitting options
---@return ChunkedDoc
structure.split_into_chunks = function(doc, opts) end

---Generates a table of contents for the given object.
---@param toc_source (Blocks | Block[] | Pandoc | ChunkedDoc)  document content to use for generating table of contents
---@param opts? WriterOptions  options
---@return BulletList # table of contents
structure.table_of_contents = function(toc_source, opts) end

return structure

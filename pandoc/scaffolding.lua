-- Scaffolding for custom writers. See https://pandoc.org/custom-writers.html#reducing-boilerplate-with-pandoc.scaffolding.writer.
---@meta

scaffolding = {}

---@overload fun(doc: Pandoc, opts: WriterOptions): string
scaffolding.Writer = {}

---@type fun(blocks: (Blocks | Block[]), sep?: (Doc | string)): string
scaffolding.Writer.Blocks = function() end

---@type fun(inlines: (Inlines | Inline[])): string
scaffolding.Writer.Inlines = function() end

---@overload fun(block: Block): string
scaffolding.Writer.Block = {
   ---@type fun(elt: BlockQuote): string
   BlockQuote = function(elt) end,
   ---@type fun(elt: BulletList): string
   BulletList = function(elt) end,
   ---@type fun(elt: CodeBlock): string
   CodeBlock = function(elt) end,
   ---@type fun(elt: DefinitionList): string
   DefinitionList = function(elt) end,
   ---@type fun(elt: Div): string
   Div = function(elt) end,
   ---@type fun(elt: Figure): string
   Figure = function(elt) end,
   ---@type fun(elt: Header): string
   Header = function(elt) end,
   ---@type fun(elt: HorizontalRule): string
   HorizontalRule = function(elt) end,
   ---@type fun(elt: LineBlock): string
   LineBlock = function(elt) end,
   ---@type fun(elt: OrderedList): string
   OrderedList = function(elt) end,
   ---@type fun(elt: Para): string
   Para = function(elt) end,
   ---@type fun(elt: Plain): string
   Plain = function(elt) end,
   ---@type fun(elt: RawBlock): string
   RawBlock = function(elt) end,
   ---@type fun(elt: Table): string
   Table = function(elt) end,
}

---@overload fun(block: Inline): string
scaffolding.Writer.Inline = {
   ---@type fun(elt: Cite): string
   Cite = function(elt) end,
   ---@type fun(elt: Code): string
   Code = function(elt) end,
   ---@type fun(elt: Emph): string
   Emph = function(elt) end,
   ---@type fun(elt: Image): string
   Image = function(elt) end,
   ---@type fun(elt: LineBreak): string
   LineBreak = function(elt) end,
   ---@type fun(elt: Link): string
   Link = function(elt) end,
   ---@type fun(elt: Math): string
   Math = function(elt) end,
   ---@type fun(elt: Note): string
   Note = function(elt) end,
   ---@type fun(elt: Quoted): string
   Quoted = function(elt) end,
   ---@type fun(elt: RawInline): string
   RawInline = function(elt) end,
   ---@type fun(elt: SmallCaps): string
   SmallCaps = function(elt) end,
   ---@type fun(elt: SoftBreak): string
   SoftBreak = function(elt) end,
   ---@type fun(elt: Space): string
   Space = function(elt) end,
   ---@type fun(elt: Span): string
   Span = function(elt) end,
   ---@type fun(elt: Str): string
   Str = function(elt) end,
   ---@type fun(elt: Strikeout): string
   Strikeout = function(elt) end,
   ---@type fun(elt: Strong): string
   Strong = function(elt) end,
   ---@type fun(elt: Subscript): string
   Subscript = function(elt) end,
   ---@type fun(elt: Superscript): string
   Superscript = function(elt) end,
   ---@type fun(elt: Underline): string
   Underline = function(elt) end,
}

return scaffolding

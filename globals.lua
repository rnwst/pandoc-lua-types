---@meta


---@type string
FORMAT = ''

---@type WriterOptions
PANDOC_WRITER_OPTIONS = {}

---@type ReaderOptions
PANDOC_READER_OPTIONS = {}

---@type Version
PANDOC_VERSION = {}

---@type Version
PANDOC_API_VERSION = {}

---@type string
PANDOC_SCRIPT_FILE = ''

---@type CommonState
PANDOC_STATE = {}

-- lpeg type definitions have been added as a submodule.
lpeg = require('lpeg.library.lpeg')

-- Sadly, I wasn't able to find type definitions for the LPeg.re module.
re = {}

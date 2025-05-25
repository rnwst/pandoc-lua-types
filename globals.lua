---@meta


---@type string
---Set to the format of the pandoc writer being used (`html5`, `latex`, etc.),
---so the behavior of a filter can be made conditional on the eventual output
---format.
FORMAT = ''

---@type ReaderOptions  Table of the options which were provided to the parser.
PANDOC_READER_OPTIONS = {}

---@type WriterOptions
---Table of the options that will be passed to the writer. While the object can
---be modified, the changes will **not** be picked up by pandoc.
---
---Accessing this variable in **custom writers** is **deprecated**. Starting
---with pandoc 3.0, it is set to a placeholder value (the default options)
---in custom writers. Access to the actual writer options is provided via the
---`Writer` or `ByteStringWriter` function, to which the options are passed as
---the second function argument.
PANDOC_WRITER_OPTIONS = {}

---@type Version
---Contains the pandoc version as a [Version](lua://Version) object which
---behaves like a numerically indexed table, most significant number first.
---E.g., for pandoc 2.7.3, the value of the variable is equivalent to a table
---`{2, 7, 3}`. Use `tostring(PANDOC_VERSION)` to produce a version string. This
---variable is also set in custom writers.
PANDOC_VERSION = {}

---@type Version
---Contains the version of the pandoc-types API against which pandoc was
---compiled. It is given as a numerically indexed table, most significant
---number first. E.g., if pandoc was compiled against pandoc-types 1.17.3,
---then the value of the variable will behave like the table `{1, 17, 3}`. Use
---`tostring(PANDOC_API_VERSION)` to produce a version string. This variable is
---also set in custom writers.
PANDOC_API_VERSION = {}

---@type string
---The name used to involve the filter. This value can be used to find files
---relative to the script file. This variable is also set in custom writers.
PANDOC_SCRIPT_FILE = ''

---@type CommonState
---The state shared by all readers and writers. It is used by pandoc to
---collect and pass information. The value of this variable is of type
---[CommonState](lua://CommonState) and is read-only.
---@diagnostic disable-next-line: missing-fields
PANDOC_STATE = {}

---This variable holds the lpeg module, a package based on Parsing Expression
---Grammars (PEG). It provides excellent parsing utilities and is documented on
---the official LPeg homepage. Pandoc uses a built-in version of the library,
---unless it has been configured by the package maintainer to rely on a
---system-wide installation.
---
---Note that the result of require 'lpeg' is not necessarily equal to this
---value; the require mechanism prefers the system’s lpeg library over the
---built-in version.
lpeg = require('lpeg.library.lpeg')
-- (lpeg type definitions have been added as a submodule)

---Contains the LPeg.re module, which is built on top
---of LPeg and offers an implementation of a [regex
---engine](https://www.inf.puc-rio.br/~roberto/lpeg/re.html). Pandoc uses a
---built-in version of the library, unless it has been configured by the package
---maintainer to rely on a system-wide installation.
---
---Note that the result of `require 're'` is not necessarily equal to this
---value; the `require` mechanism prefers the system’s lpeg library over the
---built-in version.
re = {}
-- (sadly, I wasn't able to find type definitions for the LPeg.re module)

-- UTF-8 aware text manipulation functions, implemented in Haskell.
-- 
-- The text module can also be loaded under the name `text`, although this is discouraged and deprecated.
-- 
-- ```lua
-- -- uppercase all regular text in a document:
-- function Str (s)
--    s.text = pandoc.text.upper(s.text)
--    return s
-- end
-- ```
---@meta

text = {}

---@alias Encoding ('UTF-8' | 'UTF-16BE' | 'UTF-16LE' | 'UTF-32BE' | 'UTF-32LE' | 'CP0')

---Converts a string to UTF-8. The encoding parameter specifies the encoding
---of the input string. On Windows, that parameter defaults to the current ANSI
---code page; on other platforms the function will try to use the file system’s
---encoding.
---
---The set of known encodings is system dependent, but includes at least
---`UTF-8`, `UTF-16BE`, `UTF-16LE`, `UTF-32BE`, and `UTF-32LE`. Note that the
---default code page on Windows is available through `CP0`.
---@param s         string    string to be converted
---@param encoding? Encoding  target encoding
---@return string  UTF-8 string
text.fromencoding = function(s, encoding) end

---Returns the length of a UTF-8 string, i.e., the number of characters.
---@param s string  UTF-8 encoded string
---@return integer  length
text.len = function(s) end

---Returns a copy of a UTF-8 string, converted to lowercase.
---@param s string  UTF-8 string to convert to lowercase
---@return string  lowercase copy of `s`
text.lower = function(s) end

---Returns a copy of a UTF-8 string, with characters reversed.
---@param s string  UTF-8 string to revert
---@return string  reversed `s`
text.reverse = function(s) end

---Returns a substring of a UTF-8 string, using Lua’s string indexing rules.
---@param s  string   UTF-8 string
---@param i  integer  substring start position
---@param j? integer  substring end position
---@return string  text substring
text.sub = function(s, i, j) end

---Converts a UTF-8 string to a different encoding. The encoding parameter
---defaults to the current ANSI code page on Windows; on other platforms it will
---try to guess the file system’s encoding.
---
---The set of known encodings is system dependent, but includes at least
---`UTF-8`, `UTF-16BE`, `UTF-16LE`, `UTF-32BE`, and `UTF-32LE`. Note that the
---default code page on Windows is available through `CP0`.
---@param s    string    UTF-8 string
---@param enc? Encoding  target encoding
---@return string  re-encoded string
text.toencoding = function(s, enc) end

---Returns a copy of a UTF-8 string, converted to uppercase.
---@param s string  UTF-8 encoded string
---@return string  uppercase copy of `s`
text.upper = function(s) end

return text

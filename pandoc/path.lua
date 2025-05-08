---@meta

---@class Path  Path to file
---@field separator             string  the character that separates directories
---@field search_path_separator string  the character that is used to separate the entries in the `PATH` environment variable
path = {}

---Gets the directory name, i.e. removes the last directory separator and
---everything after from the given path.
---@param filepath string  path
---@return string # the filepath up to the last directory separator
path.directory = function(filepath) end

---Get the file name.
---@param filepath string  path
---@return string # file name part of the input path
path.filename = function(filepath) end

---Checks whether a path is absolute, i.e. not fixed to a root.
---@param filepath string  path
---@return boolean # whether path is absolute
path.is_absolute = function(filepath) end

---Checks whether a path is relative or fixed to a root.
---@param filepath string  path
---@return boolean # whether path is relative
path.is_relative = function(filepath) end

---Join path elements by the directory separator.
---@param filepaths string[]  path components
---@return string # the joined path
path.join = function(filepaths) end

---Contract a filename, based on a relative path. Note that the resulting path
---will never introduce `..` paths, as the presence of symlinks means `../b` may
---not reach `a/b` if it starts from `a/c`. For a worked example see this blog
---post:
-- http://neilmitchell.blogspot.com/2015/10/filepaths-are-subtle-symlinks-are-hard.html
---@param path    string   path to be made relative
---@param root    string   root path
---@param unsafe? boolean  whether to allow `..` in the result
---@return string # contracted filename
path.make_relative = function(path, root, unsafe) end

---Normalizes a path.
--- - `//` makes sense only as part of a (Windows) network drive; elsewhere
--    multiple slashes are reduced to a single `path.separator` (platform
--    dependent).
--  - `/` becomes `path.separator` (platform dependent).
--  - `./` is removed.
--  - an empty path becomes `.`.
---@param filepath string  path
---@return string # the normalized path
path.normalize = function(filepath) end

---Splits a path by the directory separator.
---@param filepath string  path
---@return List<string> # `List` of all path components
path.split = function(filepath) end

---Splits the last extension from a file path and returns the parts. The
---extension, if present, includes the leading separator; if the path has no
---extension the empty string is returned as the extension.
---@param filepath string  path
---@return string, string # filepath without extension, extension or empty string
path.split_extension = function(filepath) end

---Takes a string and splits it on the `search_path_separator` character. Blank
---items are ignored on Windows, and converetd to `.` on Posix. On Windows path
---elements are stripped of quotes.
---@param search_path string  platform-specific search path
---@return List<string> # List of directories in search path
path.split_search_path = function(search_path) end

---Augment the string module such that strings can be used as path objects. This
---makes all the functions of the `path` module available on strings. Example:
---`filepath:is_absolute()`
path.treat_strings_as_paths = function() end

return path

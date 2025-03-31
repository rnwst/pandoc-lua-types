---@meta

local zip = {}


-- Functions -----------------------------------------------------------------------------------------------------------

---Creates an Archive structure from a raw zip archive or a list of Entry items;
---throws an error if the given string cannot be decoded into an archive.
---@param bytestring_or_entries (string | ZipEntry[])  binary archive data or list of entries; defaults to an empty list
---@return ZipArchive
zip.Archive = function(bytestring_or_entries) end

---Generates a `ZipEntry` from a filepath, uncompressed contents, and the file's
---modification time.
---@param path     string   file path in archive
---@param contents string   uncompressed contents
---@param modtime? integer  modification time
---@return ZipEntry
zip.Entry = function(path, contents, modtime) end

---Generates a `ZipEntry` from a file or directory.
---@param filepath string  path to file
---@param opts?    table   zip options
---@return ZipEntry
zip.read_entry = function(filepath, opts) end

---Package and compress the given files into a new Archive.
---@param filepaths string[]  list of files from which the archive is created
---@param opts?     table     zip options
---@return ZipArchive
zip.zip = function(filepaths, opts) end


-- Types ---------------------------------------------------------------------------------------------------------------

---@class ZipArchive
---@field entries List<ZipEntry>  files in this zip archive
local ZipArchive = {}

---Returns the raw binary string representation of the archive.
---@return string  bytes of the archive
function ZipArchive:bytestring() end

---Extract all files from this archive, creating directories as needed. Note
---that the last-modified time is set correctly only in POSIX, not in Windows.
---This function fails if encrypted entries are present.
---@param opts? table  zip options
function ZipArchive:extract(opts) end


---@class ZipEntry
---@field modtime integer  modification time (seconds since Unix epoch)
---@field path    string   relative path, using '/' as separator
local ZipEntry = {}

---Get the uncompressed contents of a zip entry. If `password` is given,
---then that password is used to decrypt the contents. An error is thrown if
---decrypting fails.
---@param password? string  password for entry
---@return string  binary contents
function ZipEntry:contents(password) end

---Returns the target if the `Entry` represents a symbolic link, and `nil`
---otherwise. Always returns `nil` on Windows.
---@return (string | nil)  link target if entry represents a symbolic link
function ZipEntry:symlink() end


return zip

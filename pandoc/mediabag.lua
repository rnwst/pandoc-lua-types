---@meta

---The `pandoc.mediabag` module allows accessing pandoc’s media storage. The
---“media bag” is used when pandoc is called with the `--extract-media` or (for
---HTML only) `--embed-resources` option.
mediabag = {}

---Removes a single entry from the media bag.
---@param filepath string  filename of the item to deleted; the media bag will be left unchanged if no entry with the given filename exists
mediabag.delete = function(filepath) end

---Clear-out the media bag, deleting all items.
mediabag.empty = function() end

---Fetches the given source from a URL or local file. Returns two values: the
---contents of the file and the MIME type (or an empty string).
---
---The function will first try to retrieve source from the mediabag; if that
---fails, it will try to download it or read it from the local file system while
---respecting pandoc’s “resource path” setting.
---
---Usage:
--- ```lua
--- local diagram_url = 'https://pandoc.org/diagram.jpg'
--- local mt, contents = pandoc.mediabag.fetch(diagram_url)
--- ```
---@param source string  path to a resource; either a local file path or URI
---@return (string | nil), (string | nil) # the entry's MIME type, or `nil` if the file was not found; contents of the file, or `nil` if the file was not found
mediabag.fetch = function(source) end

---Fills the mediabag with the images in the given document. An image that
---cannot be retrieved will be replaced with a Span of class “image” that
---contains the image description.
---
---Images for which the mediabag already contains an item will not be processed
---again.
---@param doc Pandoc  document from which to fill the mediabag
---@return Pandoc # modified document
mediabag.fill = function(doc) end

---Adds a new entry to pandoc’s media bag. Replaces any existing media bag entry
---the same filepath.
---Usage:
--- ```lua
--- local fp = 'media/hello.txt'
--- local mt = 'text/plain'
--- local contents = 'Hello, World!'
--- pandoc.mediabag.insert(fp, mt, contents)
--- ```
---@param filepath  string  filename and path relative to the output folder
---@param mimetype? string  the item's MIME type; omit if unknown or unavailable
---@param contents  string  the binary contents of the file
mediabag.insert = function(filepath, mimetype, contents) end

---Returns an iterator triple to be used with Lua’s generic `for` statement. The
---iterator returns the filepath, MIME type, and content of a media bag item
---on each invocation. Items are processed one-by-one to avoid excessive memory
---use.
---
---This function should be used only when full access to all items, including
---their contents, is required. For all other cases, [list](lua://pandoc.mediabag.list)
---should be preferred.
---
---Usage:
--- ```lua
--- for fp, mt, contents in pandoc.mediabag.items() do
---   -- print(fp, mt, contents)
--- end
--- ```
---@return fun(): string, string, string # iterator which returns the filepath, MIME type, and content of a media bag item 
mediabag.items = function() end

---Get a summary of the current media bag contents.
---
---Usage:
--- ```lua
--- -- calculate the size of the media bag.
--- local mb_items = pandoc.mediabag.list()
--- local sum = 0
--- for i = 1, #mb_items do
---     sum = sum + mb_items[i].length
--- end
--- print(sum)
--- ```
---@return List<{path: string, type: string, length: integer}> # A [List](lua://List) of elements summarizing each entry in the media bag. The summary item contains the keys `path`, `type`, and `length`, giving the filepath, MIME type, and length of contents in bytes, respectively.
mediabag.list = function() end

---Lookup a media item in the media bag, and return its MIME type and contents.
---
---Usage:
--- ```lua
--- local filename = 'media/diagram.png'
--- local mt, contents = pandoc.mediabag.lookup(filename)
--- ```
---@param filepath string  name of the file to look up
---@return string, string # the entry's MIME type, or `nil` if the file was not found; contents of the file, or `nil` if the file was not found
mediabag.lookup = function(filepath) end

---Writes the contents of mediabag to the given target directory. If `fp` is
---given, then only the resource with the given name will be extracted. Omitting
---that parameter means that the whole mediabag gets extracted. An error is
---thrown if `fp` is given but cannot be found in the mediabag.
---@param dir string  path of the target directory
---@param fp  string  canonical name (relative path) of resource
mediabag.write = function(dir, fp) end

return mediabag

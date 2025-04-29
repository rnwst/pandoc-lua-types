-- Basic image querying functions.
---@meta

image = {}

---Returns a table containing the size and resolution of an image; throws an
---error if the given string is not an image, or if the size of the image cannot
---be determined.
---
---The resulting table has four entries: `width`, `height`, `dpi_horz`, and `dpi_vert`.
---
---The opts parameter, when given, should be either a
---[WriterOptions](lua://WriterOptions) object such as
---[PANDOC_WRITER_OPTIONS](lua://PANDOC_WRITER_OPTIONS), or a table with a dpi
---entry. It affects the calculation for vector image formats such as SVG.
---@param image string         binary image data
---@param opts? {dpi: number}  table with `dpi` entry, such as [WriterOptions](lua://WriterOptions)
---@return ({width: number, height: number, dpi_horz: number, dpi_vert: number} | string)  image size information or error message
image.size = function(image, opts) end

---Returns the format of an image as a lowercase string.
---
---Formats recognized by pandoc include `png`, `gif`, `tiff`, `jpeg`, `pdf`,
---`svg`, `eps`, and `emf`.
---@param image string  binary image data
---@return (string | nil)  image format, or `nil` if the format cannot be determined
image.format = function(image) end

return image

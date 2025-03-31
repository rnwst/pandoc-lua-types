-- Access to pandoc's logging system.
---@meta

log = {}

---Reports a `ScriptingInfo` message to pandoc's logging system.
---@param message string  the info message
log.info = function(message) end

---Reports a ScriptingWarning to pandoc’s logging system. The warning will be
---printed to stderr unless logging verbosity has been set to `ERROR`.
---@param message string
log.warn = function(message) end

---Applies the function to the given arguments while preventing log messages
---from being added to the log. The warnings and info messages reported during
---the function call are returned as the first return value, with the results of
---the function call following thereafter.
---@param message function  function to be silenced
---@return List<string>, any  list of log messages triggered during the function call, and any value returned by the function
log.silence = function(message) end

return log

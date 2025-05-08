-- Command line options and argument passing.
---@meta

cli = {}

---@type {[string]: string}
cli.default_options = {}

---Parses command line arguments into pandoc options. Typically, this function
---will be used in standalone pandoc Lua scripts, taking the list of arguments
---from the global `arg`. Standalone pandoc Lua scripts may be run as follows:
---```lua
-- pandoc lua script.lua
---```
---or
---```lua
---pandoc-lua script.lua
---```
-- For more information, see
---https://pandoc.org/MANUAL.html#running-pandoc-as-a-lua-interpreter.
---
---@param args string[]  list of command line arguments
---@return {[string]: any} # parsed pandoc options, using their JSON-like representation
cli.parse_options = function(args) end

---Starts a read-eval-print loop (REPL). The function returns all values of the
---last evaluated input. Exit the REPL by pressing ctrl-d or ctrl-c; press F1 to
---get a list of all key bindings.
---
---The REPL is started in the global namespace, unless the env parameter is
---specified. In that case, the global namespace is merged into the given table
---and the result is used as _ENV value for the repl.
---
---Specifically, local variables cannot be accessed, unless they are explicitly
---passed via the env parameter; e.g.
---
---```lua
---function Pandoc (doc)
---  -- start repl, allow to access the `doc` parameter
---  -- in the repl
---  return pandoc.cli.repl{ doc = doc }
---end
---```
---
---**Note**: It seems that the function exits immediately on Windows, without
---prompting for user input.
---
---@param env table  extra environment; the global environment is merged into this table
---@return any # the result(s) of the last evaluated input, or nothing if the last input resulted in an error
cli.repl = function(env) end

return cli

---@meta

---Access to the system’s information and file functionality.
system = {}

---@type ('x86_64' | 'arm64')
system.arch = '' ---@diagnostic disable-line: assign-type-mismatch

---@type ('freebsd' | 'linux' | 'linux-android' | 'mingw32' | 'netbsd' | 'openbsd')
system.os = '' ---@diagnostic disable-line: assign-type-mismatch

---Returns the number of picoseconds CPU time used by the current program. The
---precision of this result may vary in different versions and on different
---platforms.
---@return integer # CPU time in picoseconds
system.cputime = function() end

---Retrieves the entire environment as a string-indexed table.
---@return table<string, string>
system.environment = function() end

---Obtain the current working directory as an absolute path.
---@return string
system.get_working_directory = function() end

---List the contents of a directory.
---@param directory string  path of the directory whose contents should be listed; defaults to `..`
---@return string[] # a table of all entries in `directory`, except for the special entries `.` and `..`
system.list_directory = function(directory) end

---Create a new directory which is initially empty, or as near to empty as the
---operating system allows. The function throws an error if the directory cannot
---be created, e.g., if the parent directory does not exist or if a directory of
---the same name is already present.
---
---If the optional second parameter is provided and truthy, then all
---directories, including parent directories, are created as necessary.
---@param dirname        string   name of the new directory
---@param create_parent? boolean  create parent directory if necessary
system.make_directory = function(dirname, create_parent) end

---Remove an existing, empty directory. If recursive is given, then delete the
---directory and its contents recursively.
---@param dirname    string   name of the directory to delete
---@param recursive? boolean  delete content recursively
system.remove_directory = function(dirname, recursive) end

---Run an action within a custom environment. Only the environment variables
---given by environment will be set, when `callback` is called. The original
---environment is restored after this function finishes, even if an error occurs
---while running the callback action.
---@param environment table<string, string>  environment variables and their values to be set before running `callback`
---@param callback    function               action to execute in the custom environment
system.with_environment = function(environment, callback) end

---Create and use a temporary directory inside the given directory. The
---directory is deleted after the callback returns.
---@param parent_dir string           parent directory to create the directory in; if this parameter is omitted, the system's canonical temporary directory is used
---@param templ      string           directory name template
---@param callback   fun(string):...  function which takes the name of the temporary directory as its first argument
---@return ... # the results of the call to callback
system.with_temporary_directory = function(parent_dir, templ, callback) end

---Create and use a temporary directory inside the given directory. The
---directory is deleted after the callback returns.
---@param templ       string           directory name template
---@param callback    fun(string):...  function which takes the name of the temporary directory as its first argument
---@return ... # the results of the call to callback
system.with_temporary_directory = function(templ, callback) end

---Run an action within a different directory. This function will change the
---working directory to `directory`, execute `callback`, then switch back to
---the original working directory, even if an error occurs while running the
---callback action.
---@param directory string     directory in which the given callback should be executed
---@param callback  fun():...  action to execute in the given directory
---@return ... # the result of the call to `callback`
system.with_working_directory = function(directory, callback) end

return system

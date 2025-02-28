# pandoc-lua-types

Make writing [Pandoc](https://pandoc.org/) [Lua filters](https://pandoc.org/lua-filters.html) a pleasure by using these language server definitions for use with [`lua-language-server`](https://github.com/LuaLS/lua-language-server).


## Installation

The `pandoc-types.lua` definition file can be added to your pandoc filter git repository by adding this project as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules):
```console
git submodule add https://github.com/rnwst/pandoc-lua-types types
```
To enable `lua-language-server` to find out definition file in `./types/`, we need to create a `.luarc.json` file in the root of the project with the following contents:
```json
{
  "workspace": {
    "library": ["types"]
  }
}
```

# pandoc-lua-types

Make writing [Pandoc](https://pandoc.org/) [Lua filters](https://pandoc.org/lua-filters.html) a pleasure by using these language server definitions for use with [`lua-language-server`](https://github.com/LuaLS/lua-language-server).
The definitions include Pandoc's element types as well as function definitions for the [`pandoc`](https://pandoc.org/lua-filters.html#module-pandoc) module, enabling **static type checking, autocompletion, and automatic display of documentation**.

## Installation

The `pandoc-types.lua` definition file can be added to your pandoc filter git repository by adding this project as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules):
```console
git submodule add https://github.com/rnwst/pandoc-lua-types types
```
To enable LuaLS to find the definition file in `./types/`, a `.luarc.json` file needs to be created in the root of the project with the following contents:
```json
{
  "workspace": {
    "library": ["types"]
  }
}
```

## Type annotations and static type checking

LuaLS' type checking is [not currently as capable as it could be](https://github.com/LuaLS/lua-language-server/issues/3101), however it still seems to catch at least 90% of my errors that could be caught by static type checking, making it well worth the effort!

A basic understanding of LuaLS' [type annotation syntax](https://luals.github.io/wiki/annotations/) is presumed in this section.

All of Pandoc's [Block](https://pandoc.org/lua-filters.html#type-block) and [Inline](https://pandoc.org/lua-filters.html#type-inline) elements are available for type annotations. Furthermore, the [`Pandoc`](https://pandoc.org/lua-filters.html#type-pandoc) and [`Meta`](https://pandoc.org/lua-filters.html#type-meta) types are available as well, and so are the various [Element component](https://pandoc.org/lua-filters.html#element-components) types. This enables static type checking when writing filter functions. For example:
```Lua
---Filter function for Spans
---@param span Span
---@return Span | nil
function Span(span)
   -- This triggers a type error from LuaLS since the `content` field
   -- is a sequence of Inlines and does not match a string!
   span.content = 'foobar'
end
```
Apart from individual Block and Inline element types, the types `Block` and `Inline` have also been defined, which act as an alias for any Block or Inline element, respectively.

For sequences of Blocks and Inlines, the `Blocks` and `Inlines` types are available. They differ from `Block[]` and `Inline[]` by having the [`walk`](https://pandoc.org/lua-filters.html#type-blocks:walk) and [`clone`](https://pandoc.org/lua-filters.html#clone) methods available on them, as well as all the [`List`](https://pandoc.org/lua-filters.html#module-pandoc.list)-methods (such as metamethods [`__concat`](https://pandoc.org/lua-filters.html#pandoc.list:__concat) and [`__eq`](https://pandoc.org/lua-filters.html#pandoc.list:__eq), and methods [`extend`](https://pandoc.org/lua-filters.html#pandoc.list:extend), [`filter`](https://pandoc.org/lua-filters.html#pandoc.list:filter), [`includes`](https://pandoc.org/lua-filters.html#pandoc.list:includes), ...). When a filter function is receiving Inlines, they are of type `Inlines`, but if you are returning a table of Inline elements as in the following example, they are of type `Inline[]`:
```Lua
---Filter function for Inlines
---@param inlines Inlines
---@param return Inline[]
function Inlines(inlines)
   return {pandoc.Str('Hello!')}
end
```
If you are unsure if your return value is of type `Inline[]` or `Inlines`, you can annotate it as `Inlines | Inline[]`, which covers both types.

There is currently a bug in LuaLS preventing it from doing proper type-checking on the contents of a variable of type `Inlines` or `Blocks`. As a workaround, such variables can be assigned the type `(Inlines | Inline[])` (and equivalently for `Blocks`), as in the following example. When assigning a `Block` or `Inline` type to a more specific type (such as a Span, as in the following example), the [`@cast` annotation](https://luals.github.io/wiki/annotations/#cast) can be used to cast the variable to the required type:
```Lua
---Inlines filter function
---@param inlines (Inlines | Inline[])
function Inlines(inlines)
   if inlines[1].tag == 'Span' then
      local span = inlines[1]
      ---@cast span Span
      ...
   end
   ...
end
```

Type definitions are also available for filters and filter functions. The `Filter` type can be used to annotate a Lua filter's return value:
```Lua
---@type Filter
return {
   traverse = 'topdown',
   Str = filter_fn1,
   Para = filter_fn2,
}
```
The `Filter` type is either a `FilterTable`, or an array of `FilterTable`s, or an array of an array of `FilterTable`s, and so on. A `FilterTable` is a table of filter functions (the return value above is an example). Therefore, in the above example, the `---@type FilterTable` annotation could have been used as well (though if a nested table was returned, the `Filter` type would have to be used).

local mytable = {} -- my "table" stdlib

--- Merge all the given tables into a single one and return it.
---@param ... table
---@return table
function mytable.merge_all(...)
  local ret = {}
  for _, tbl in ipairs({ ... }) do
    for k, v in pairs(tbl) do
      if type(ret[k]) == "table" and k == "keys" then
        for _, ov in ipairs(v) do
          table.insert(ret[k], ov)
        end
      else
        ret[k] = v
      end
    end
  end
  return ret
end

--- Test if a module is available.
---@param string name
---@return boolean
function mytable.isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

return {
  mytable = mytable,
}

---@diagnostic disable: trailing-space
---Split a string by character sequence.
---@param str string a string that may have multiple lines in it
---@param chars string a character string to split on
---@return table parts a table with one entry per part in the string (squished)
local function split(str, chars)
  parts = {}
  for line in str:gmatch("[^" .. chars .. "]+") do
    table.insert(parts, line)
  end
  return parts
end

---Read an entire file.
---@param path string the file to read
---@return string contents the contents of the file
---@source http://lua-users.org/wiki/FileInputOutput
local function read(path)
  local fh = assert(io.open(path, "rb"))
  local contents = assert(fh:read(_VERSION <= "Lua 5.2" and "*a" or "a"))
  fh:close()
  return contents
end

---Because Lua doesn't have a built-in table size function.
function table_size(tbl)
  local count = 0
  for i in pairs(tbl) do 
    count = count + 1 
  end
  return count
end

local uids = {}
---Read an SVG file to string, discarding the XML header tag.
---And wrap all the content in two groups (<g> tags)
---  the outer one, with a class svg-zoom, will be what our javascript applies a zooming transformation to
---  the inner one, with a unique id, will be used (<use> tag) to avoid duplicating the svg's text if it's shown multiple times in the document
---@param path string the path to the SVG file
---@return string contents the contents of the file (less the <xml> header tag)
local function read_svg(path)
  local svg_content = read(path)
  local svg_lines = split(svg_content, "\r\n")
  --- remove the XML header
  table.remove(svg_lines, 1) 
  --- remove the 'pt' units from the width and height. It should use the default 'px' units this way.
  svg_lines[1] = string.gsub(svg_lines[1], '(%d+[.]?%d*)pt', '%1')
  
  if uids[svg_content] then
    local use_tag = string.gsub('<g class="svg-zoom"> \n<use href="#$uid"/> \n</g>', 
                                "%$(%w+)", {uid=uids[svg_content]})
    return table.concat({svg_lines[1], use_tag, svg_lines[#svg_lines]}, " \n")
  else
    uids[svg_content] = 'unique-content-' .. (table_size(uids) + 1)
    local group_open = string.gsub('<g class="svg-zoom"> \n<g id="$uid">', 
                                   "%$(%w+)", {uid=uids[svg_content]})
    local group_close = "</g></g>"
    table.insert(svg_lines, 2, group_open)
    table.insert(svg_lines, #svg_lines, group_close)
    return table.concat(svg_lines, " \n")
  end
end

function Image (elem)
  if elem.src:match('%.svg$') then 
    svg_str = read_svg(elem.src)
    return pandoc.RawInline('html', svg_str)
  end
end

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

---Read an SVG file to string, discarding the XML header tag.
---@param path string the path to the SVG file
---@return string contents the contents of the file (less the <xml> header tag)
local function read_svg(path)
  local svg_content = read(path)
  local svg_lines = split(svg_content, "\r\n")
  table.remove(svg_lines, 1)
  return table.concat(svg_lines, "")
end

function Image (elem)
  if elem.src:match('%.svg$') then 
    svg_str = read_svg(elem.src)
    svg_data = "data:image/svg+xml;base64," .. quarto.base64.encode(svg_str)
    return pandoc.RawInline('html', string.format('<object type="image/svg+xml" class="img" data="%s"></object>', svg_data))
  end
end

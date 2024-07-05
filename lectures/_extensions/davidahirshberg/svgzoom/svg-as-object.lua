function Image (elem)
  if elem.src:match('%.svg$') or elem.src:match('data:image/svg%+xml;') then
    return pandoc.RawInline('html', string.format('<object type="image/svg+xml" data="%s" class="img"></object>', elem.src))
  end
end
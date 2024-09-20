function Div(div)
  if div.classes:includes("callout-exercise") then
    local title = ""
    if div.content[1] ~= nil and div.content[1].t == "Header" then
      title = div.content[1]
      div.content:remove(1)
    end
    return quarto.Callout({
      type = "exercise",
      content = div,
      title = title,
    })
  end
  if div.classes:includes("callout-solution") then
    local title = "Solution"
    if div.content[1] ~= nil and div.content[1].t == "Header" then
      title = div.content[1]
      div.content:remove(1)
    end
    return quarto.Callout({
      type = "solution",
      content = div,
      title = title,
      collapse = true
    })
  end
end
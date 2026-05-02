function leftClick()
  mouseEvent("leftClick")
end

function leftDoubleClick()
  mouseEvent("leftDoubleClick")
end

function mouseEvent(event)
  local x, y = mp.get_mouse_pos()
  local window_width = mp.get_property("osd-width")
  local window_height = mp.get_property("osd-height")
  local dragArea = window_height * .05
  local bottomArea = window_height * .8
  local leftArea = window_width * .2
  local rightArea = window_width * .8
  local seek_perc = (x / window_width) * 100

  if (y > bottomArea) then
  elseif (x < leftArea and y < bottomArea and y > dragArea) then
    mp.commandv('playlist-prev')
  elseif (x > rightArea and y < bottomArea and y > dragArea) then
    mp.commandv('playlist-next')
  elseif (y > dragArea) then
    if (event == "leftClick") then
      mp.commandv('cycle', 'pause')
    elseif (event == "leftDoubleClick") then
      mp.commandv('cycle', 'fullscreen')
    end
  end
end

mp.register_script_message("custom-osc-left-click", leftClick)
mp.register_script_message("custom-osc-left-double-click", leftDoubleClick)

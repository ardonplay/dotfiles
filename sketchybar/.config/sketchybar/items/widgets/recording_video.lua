local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
  icon = {
   drawing=false
  },
  label = {
    color = colors.white,
    padding_right =5,
    padding_left = 6,
    align = "center",
    font = { family = settings.font.text},
    string = ""
  },
  position = "right",
  padding_left = 2,
  padding_right = 2,
  background = {
    height = 4,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = false,
  }
})

-- Double border for calendar using a single item bracket
sbar.add("bracket", { cal.name }, {
  background = { color = colors.bg1 }
})

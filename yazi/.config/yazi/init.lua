Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)

function Current:render(area)
	self.area = area

	local markers = {}
	local items = {}

	local cursor = cx.active.current.cursor
	local offset = cx.active.current.offset

	for i, f in ipairs(Folder:by_kind(Folder.CURRENT).window) do
		local name = Folder:highlighted_name(f)

		local idx = i - 1 - cursor + offset
		if idx == 0 then idx = cursor end

		local item = ui.ListItem(ui.Line { ui.Span(string.format("%3d", idx)), Folder:icon(f), table.unpack(name) })
		-- Highlight hovered file
		if f:is_hovered() then
			item = item:style(THEME.manager.hovered)
		else
			item = item:style(f:style())
		end
		items[#items + 1] = item

		-- Mark yanked/selected files
		local yanked = f:is_yanked()
		if yanked ~= 0 then
			markers[#markers + 1] = { i, yanked }
		elseif f:is_selected() then
			markers[#markers + 1] = { i, 3 }
		end
	end
	return ya.flat { ui.List(area, items), Folder:linemode(area), Folder:markers(area, markers) }
end

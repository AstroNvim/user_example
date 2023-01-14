-- Customize colors for each element each element has a `_fg` and a `_bg`
return function(colors)
  colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
  return colors
end

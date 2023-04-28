return {
  {
      "scalameta/nvim-metals",
      config = function()
        require("user.metals2").config()
      end,
  },
}

return {
    -- dir="~/Documents/Code/Projects/semicolonify",
    "JamieByers/semicolonify.nvim",
    name = "semicolonify",
    lazy=false,

    config = function()
       require("semicolonify").setup({
            filetypes = {"*"}
        })
    end
}

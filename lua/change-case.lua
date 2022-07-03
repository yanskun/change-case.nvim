local M = {}

local function setup_commands()
  local cmds = {
    name = "ChangeCaseCamel",
    cmd = function()
      require("cahnge-case.change_case")("camel")
    end,
    opt = {
      range = true,
    },
  }

  for _, cmd in ipairs(cmds) do
    vim.api.nvim_create_user_command(cmd.name, cmd.cmd, cmd.opt)
  end
end

function M.setup()
  setup_commands()
end

return M

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  config = function()
    -- load mason-nvim-dap if available
    local has_mason_nvim_dap, mason_nvim_dap = pcall(require, "mason-nvim-dap")
    if has_mason_nvim_dap then
      mason_nvim_dap.setup({
        automatic_installation = true,
        ensure_installed = { "python", "delve" }, -- Adjust debuggers as needed
      })
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Define debug signs
    local dap_signs = {
      Breakpoint = { "🔴", "DapBreakpoint" },
      BreakpointCondition = { "🟡", "DapBreakpointCondition" },
      LogPoint = { "🔵", "DapLogPoint" },
      Stopped = { "→", "DapStopped" },
      Rejected = { "❌", "DapRejected" },
    }

    for name, sign in pairs(dap_signs) do
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}

return {
  "David-Kunz/gen.nvim",
  opts = {
    model = "mistral",
    host = "localhost",
    port = "11434",
    quit_map = "<leader>sd",
    retry_map = "<c-r>",
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    command = function(options)
      local body = { model = options.model, stream = true }
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    display_mode = "split", -- The display mode. Can be "float" or "split".
    show_prompt = false,
    show_model = false,
    no_auto_close = false,
    debug = false,
  },
}

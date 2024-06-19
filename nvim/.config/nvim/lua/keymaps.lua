local map = require("utils").map

-- Escapes
map({ "i", "c" }, "jk", "<esc>")
map({ "n", "v" }, "<leader>jk", "<esc>")

-- Clear highlights
map({ "n" }, "<leader>jk", "<cmd> noh <cr>")
map({ "n" }, "<esc>", "<cmd> noh <cr>")

-- Buffers
map("n", "<leader>q", ":q<cr>")
map("n", "<leader>w", ":w<cr>")
map("n", "<leader>qwe", ":qa!<cr>")
map("n", "<leader>d", ":bdelete<cr> :bnext<cr>")

-- Move line/block
map("i", "<a-j>", "<esc>:m .+<cr>==gi")
map("i", "<a-k>", "<esc>:m .-2<cr>==gi")
map("i", "∆", "<esc>:m .+<cr>==gi")
map("i", "˚", "<esc>:m .-2<cr>==gi")
map("n", "<a-j>", ":m .+<cr>==")
map("n", "<a-k>", ":m .-2<cr>==")
map("n", "∆", ":m .+<cr>==")
map("n", "˚", ":m .-2<cr>==")
map("v", "<a-j>", ":m '>+1<cr>gv=gv")
map("v", "<a-k>", ":m '<-2<cr>gv=gv")
map("v", "∆", ":m '>+1<cr>gv=gv")
map("v", "˚", ":m '<-2<cr>gv=gv")

-- Duplicate line/block
map("i", "<a-s-j>", "<esc>Vyp")
map("i", "<a-s-k>", "<esc>VyP")
map("i", "Ô", "<esc>Vyp")
map("i", "", "<esc>VyP")
map("n", "<a-s-j>", "Vyp")
map("n", "<a-s-k>", "VyP")
map("n", "Ô", "Vyp")
map("n", "", "VyP")
map("v", "<a-s-j>", "yp")
map("v", "<a-s-k>", "yP")
map("v", "Ô", "yp")
map("v", "", "yP")

-- Splits
map("n", "<leader>ss", ":vsplit<cr>")
map("n", "<leader>sh", ":split<cr>")
map("n", "<leader>sd", ":close<cr>")

map("n", "vv", "ve")
map("n", "dq", "db")
map("n", "cq", "cb")

map("n", "<s-u>", "<C-r>")
map("i", "<a-bs>", "<del>")

-- Indent
map("i", "<tab>", "<C-t>")
map("i", "<s-tab>", "<C-d>")
map("v", "<tab>", ">gv")
map("v", "<s-tab>", "<gv")

-- Movements
map("i", "<a-l>", "<esc>ea")
map("i", "<a-h>", "<esc>bi")
map("i", "¬", "<Esc>ea")
map("i", "˙", "<Esc>bi")
map("i", "<a-s-l>", "<esc>A")
map("i", "<a-s-h>", "<esc>I")
map("i", "Ò", "<esc>A")
map("i", "Ó", "<esc>I")
map("i", "<c-h>", "<left>")
map("i", "<c-j>", "<down>")
map("i", "<c-k>", "<up>")
map("i", "<c-l>", "<right>")

map("n", "<s-x>", "<c-v>")
map({ "i", "n" }, "<c-f>", ":%s/", { silent = false })

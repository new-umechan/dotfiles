local opt = vim.opt

-- 「※」等の記号を打つと、半角文字と重なる問題がある。「※」などを全角文字の幅で表示するために設定する
-- これやるとtelescopeがバグる
-- opt.ambiwidth = 'double'

-- 新しい行を改行で追加した時に、ひとつ上の行のインデントを引き継がせます。
opt.autoindent = true
opt.smartindent = true
-- smartindent と cindent を両方 true にしたときは、cindent のみ true になるようです。
-- opt.cindent = true
-- カーソルが存在する行にハイライトを当ててくれます。
opt.cursorline = true

opt.signcolumn = 'yes'

-- カーソルが存在する列にハイライトを当てたい場合、下記をtrueにする。
-- opt.cursorculumn = true

-- TABキーを押した時に、4文字分の幅を持ったTABが表示されます。
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- tabstop で設定した数の分の半角スペースが入力されます。
opt.expandtab = false
-- 普段は相対行表示と絶対行表示を両方表示
vim.o.number = true
vim.o.relativenumber = true
-- 幅を設定
vim.o.numberwidth = 4

-- コピペを簡単に
opt.clipboard:append({"unnamedplus"})
-- xは"_（ブラックホールレジスタ）へ保存
vim.keymap.set('n', 'x', '"_x')

-- ignorecaseはデフォルトで大文字と小文字を区別しない検索を行います。
-- smartcaseは検索に大文字が含まれている場合に限り、大文字小文字を区別します。
vim.o.ignorecase = true
vim.o.smartcase = true

-- 特殊なファイルもやる
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 入力してるコマンドが見れる
vim.opt.showcmd = true
vim.opt.termguicolors = true

-- インデント後にVisual modeを保持する設定
vim.cmd([[
    vnoremap < <gv
    vnoremap > >gv
]])

opt.termguicolors = true

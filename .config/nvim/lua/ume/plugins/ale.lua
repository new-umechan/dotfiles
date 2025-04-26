-- この設定ないとエラーがgit表示とかぶるよ
vim.g.ale_sign_column_always = 0
vim.g.ale_set_signs = 0

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.b.ale_linters = { 'gcc' }
    vim.b.ale_cpp_cc_executable = 'g++-14'
    vim.b.ale_cpp_cc_options = table.concat({
      '-std=c++17 -Wall',
      '-I/opt/homebrew/Cellar/gcc/14.2.0_1/include/c++/14',
      '-I/opt/homebrew/Cellar/gcc/14.2.0_1/include/c++/14/aarch64-apple-darwin23',
      '-I/opt/homebrew/Cellar/gcc/14.2.0_1/include/c++/14/backward',
      '-I/opt/homebrew/Cellar/gcc/14.2.0_1/lib/gcc/current/gcc/aarch64-apple-darwin23/14/include',
      '-I/opt/homebrew/Cellar/gcc/14.2.0_1/lib/gcc/current/gcc/aarch64-apple-darwin23/14/include-fixed',
    }, ' ')
  end,
})


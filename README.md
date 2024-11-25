# DOTFILES
my neovim, zsh,and wezterm setting

### ENVIRONMENT
macOS m1

### HOW TO

1. Install

   ```zsh
   cd dotfiles
   ./.bin/install.sh
   ```


1. zsh plugin install

   ```zsh
   exec zsh
   ```

1. neovim plugin install

   ```zsh
   vi --headless -c 'Lazy! sync' -c 'qall'
   ```

Enjoy!

### TODO
- [ ] zsh plugin


### キー配列について(japanese)
- [ ] キー配列をいじる過程Ctrl+h,Ctrl+m,Ctrl+[に目覚める
- [ ] 親指で、かなのところでEnter打てて、英数のところでBackSpace打てたら強くない？
- [ ] 英数をレイヤー1、かなをレイヤー2とする
- [ ] かなと英数はどうしよう

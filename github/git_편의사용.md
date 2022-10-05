git 명령어
==========

#### git log alias 설정!

```
$ git config --global alias.lg "log --oneline --graph --pretty=format:'%C(auto)%h%d%Creset %C(cyan)(%cr)%Creset %s - %an%C(reset)'"
```

#### git 자동완성

1. 플러그인 다운로드
```
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
2. zshrc 설정
```
$ vi ~/.zshrc

####
plugins=(
    # other plugins...
    zsh-autosuggestions
)
####

$ source ~/.zshrc
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
```

#### github 멀티 계정 사용
```shell
# Personal account-userA
Host github.com-lyjguy
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_rsa_lyjguy

# Personal account-userB
Host github.com-mrLeeYoungJin
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_rsa
```
- github remote 연결 예제
```shell
git remote set-url origin git@github.com-ace:lyjguy/lyjguy.git
```
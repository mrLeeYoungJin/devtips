git 명령어
==========

#### git 저장소 복제

```
$ git clone <저장소url>
```

#### git 변경 사항 확인

```
$ git diff
```

#### git branch 생성

```
$ git branch <생성할 브랜치명>
```

#### git branch 변경

```
$ git checkout <변경할 브랜치명>
```

#### branch 삭제

> remotes

```
$ git branch -D branchname
$ git push origin :branchname
```

> local

```
$ git branch -D branchname
```

> 옵션 -b 신규 브랜치 생성하면서 변경

#### git add + commit

```
git commit -am 'messages'
```

#### git init & push

> github 사이트에서 신규 프로젝트 생성 주의사항 : 프로젝트 생성시 README 파일 생성 후 git init 하고 push 할 경우 git pull origin master 하여 git merge 후 push

```
$ git init
$ git add *
$ git commit -m "Initial commit"
$ git remote add origin example.com:my_project.git
$ git push -u origin master
```

#### git config 설정

> global

```
git config --global user.name "이름"
git config --global user.email "이메일"
```

> local

```
git config --local user.name "이름"
git config --local user.email "이메일"
```

#### git config 확인

> global

```
$ git config --global --list
```

> local

```
$ git config --list
```

#### git log

```
$ git log
```

#### git commit 취소

```
// [방법 1] commit을 취소하고 해당 파일들은 staged 상태로 워킹 디렉터리에 보존
$ git reset --soft HEAD^
// [방법 2] commit을 취소하고 해당 파일들은 unstaged 상태로 워킹 디렉터리에 보존
$ git reset --mixed HEAD^ // 기본 옵션
$ git reset HEAD^ // 위와 동일
$ git reset HEAD~2 // 마지막 2개의 commit을 취소
// [방법 3] commit을 취소하고 해당 파일들은 unstaged 상태로 워킹 디렉터리에서 삭제
$ git reset --hard HEAD^
```

#### 마지막 commit 상태로 변경

```
$ git reset --hard HEAD
```

#### git remote url 설정

```
git remote add origin http://giturl
```

#### git remote url 변경

```
git remote set-url origin http://giturl
```

### git cache clear

```
git rm -r --cached .
git add .
git commit -am 'git cache cleared'
git push
```


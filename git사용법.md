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

> 옵션 -b 신규 브랜치 생성하면서 변경

#### git init & push

> github 사이트에서 신규 프로젝트 생성 주의사항 : 프로젝트 생성시 README 파일 생성 후 git init 하고 push 할 경우 git pull origin master 하여 git merge 후 push

```
$ git init
$ git add *
$ git commit -m "Initial commit"
$ git remote add origin example.com:my_project.git
$ git push -u origin master
```

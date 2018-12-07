Ubuntu svn to gitlab
====================

> 참고 사이트 : https://www.lesstif.com/pages/viewpage.action?pageId=23757066
>
> https://github.com/nirvdrum/svn2git

```
git 사전 설치

```

-	ruby 설치 확인 및 설치

```
$ dpkg -l | grep ruby
$ apt-get install ruby-full

> centos7
$ yum install -y git-core git-svn ruby
```

-	svn2git 설치

```
gem install svn2git
```

-	git global 설정

```
$ git config --global user.name "lyjguy"
$ git config --global user.email "lyjguy@gridwiz.com"
```

-	gitlab 으로 copy

> .gitignore 작성필요

```
$ svn2git --username='lyjguy' svn://192.168.101.101/ems --trunk trunk/ems_sk --authors .svn2git/authors

$ git remote add origin http://192.168.1.161/ESS/EMS/ems_web.git
```

-	gitlab push

> branch push 할때 필요한 branch 만 push

```
$ git remote add origin http://192.168.1.161/ESS/EMS/ems_web.git
$ git push --all origin
$ git push --tags origin
```

#### git to gitlaba

```
## 가져올 git clone
$ glt clone old-git-url
$ cd projectname

## git 주소 변경
$ git remote set-url origin new-git-url
$ git push origin master
```

> 모든 branch push

```
$ git checkout branchname
$ git push origin brnachname
```

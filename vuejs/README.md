vuejs 설치
==========

-	https://kr.vuejs.org
-	https://cli.vuejs.org/config
-	https://router.vuejs.org/kr/guide/#html

#### npm 기반 설치

-	npm, node.js은 이미 설치 되었다고 가정
-	node.js 8.7이상(8.11.0 권장)

#### vue 설치

```
$npm install -g @vue/cli
```

> version 확인

```
$ vue --version
```

> vue 프로젝트 생성 방법

1.	vue create 로 생성
2.	vue ui 로 프로젝트 생성

> vue ui로 생성 시 ui에서 vue 의 상세한 설정 변경이 가능하다.

```
# 1.
$ vue create hello-world
```

```
# 2.
$ vue ui
```

> 전역 config 확인

```
$ vue config
```

#### 이슈

> Expected linebreaks to be 'LF' but found 'CRLF' 오류시

-	eslint core 설정 변경

```
$ npm run lint --fix
```

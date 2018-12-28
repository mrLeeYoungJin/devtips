Nodejs
======

-	site : https://nodejs.org/ko/

> node version 확인

```
$ node -v
```

> npm version 확인

```
$ npm -v
```

> npm version update

```
$ npm install npm@latest -g
```

> npm 초기화

```
$ npm init

## etc
$npm init --force or npm init --yes or npm init -y
```

webpack 설치
------------

-	site : https://webpack.js.org

> 설치

-	전역 설치

```
npm install -g webpack
```

-	로컬 설치

```
$ npm install --no-optional --save-dev webpack

# install
$ npm install -save-dev clean-webpack-plugin

# uninstall
$ npm uninstall -save-dev clean-webpack-plugin
```

> fsevents@1.x.x warn 문제

```
fsvents는 maxos 전용 라이브러리라 windows 에서는 사용안하기 때문에 무시해도 되는 경고
```

### rebuild

```
npm rebuild
```

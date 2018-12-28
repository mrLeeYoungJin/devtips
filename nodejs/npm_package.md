NPM package
===========

————————————————————————————————————

### Auto Watch

#### 1. webpack-dev-middleware

> WebpackDevMiddleware는 nodejs express에서 Webpack Build를 자동화 해주는 middleware이다. npm을 이용해서 간단하게 설치할 수 있다.

```
$ npm install --save-dev webpack-dev-middleware
```

#### 2. webpack-dev-server

> 간단한 live reloading을위한 웹서버를 제공

```
$ npm install --save-dev webpack-dev-server

# script
$ webpack-dev-server --open

-------------------------
devServer: {
 contentBase: './dist'
}
------------------------
```

#### 3. weppack watch

> webpack 기본 내장

```
# script
$ webpack --watch
```

### extract-text-webpack-plugin

-	site : https://github.com/webpack-contrib/mini-css-extract-plugin

```
$ npm install --save-dev extract-text-webpack-plugin
```

### html-webpack-plugin

-	site : https://github.com/jantimon/html-webpack-plugin

> html 파일 자동 생성 / loader

```
$ npm install --save-dev html-webpack-plugin
```

#### clean-webpack-plugin'

-	site : https://github.com/johnagan/clean-webpack-plugin

> output 디렉토리를 build를 할때마다 삭제

```
$ npm install --save-dev clean-webpack-plugin
```

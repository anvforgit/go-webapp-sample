# go-webapp-sample

[![license](https://img.shields.io/github/license/ybkuroki/go-webapp-sample?style=for-the-badge)](https://github.com/ybkuroki/go-webapp-sample/blob/master/LICENSE)
[![report](https://goreportcard.com/badge/github.com/ybkuroki/go-webapp-sample?style=for-the-badge)](https://goreportcard.com/report/github.com/ybkuroki/go-webapp-sample)
[![workflow](https://img.shields.io/github/workflow/status/ybkuroki/go-webapp-sample/check?label=check&style=for-the-badge&logo=github)](https://github.com/ybkuroki/go-webapp-sample/actions?query=workflow%3Acheck)
[![release](https://img.shields.io/github/release/ybkuroki/go-webapp-sample?style=for-the-badge&logo=github)](https://github.com/ybkuroki/go-webapp-sample/releases)

## Preface
This repository is the sample of web application using golang.
This sample uses [Echo](https://echo.labstack.com/) as web application framework, [Gorm](https://gorm.io/) as OR mapper and [Zap logger](https://pkg.go.dev/go.uber.org/zap) as logger.
This sample application provides only several functions as Web APIs.
Please refer to the 'Service' section about the detail of those functions.

Also, this application contains the static contents such as html file, css file and javascript file which built [vuejs-webapp-sample](https://github.com/ybkuroki/vuejs-webapp-sample) project to easily check the behavior of those functions.
So, you can check this application without starting a web server for front end.
Please refer to the 'Starting Server' section about checking the behavior of this application.

If you would like to develop a web application using golang, please feel free to use this sample.

## Install
Perform the following steps:
1. Download and install [MinGW(gcc)](https://sourceforge.net/projects/mingw-w64/files/?source=navbar).
1. Download and install [Visual Studio Code(VS Code)](https://code.visualstudio.com/).
1. Download and install [Golang](https://golang.org/).
1. Get the source code of this repository by the following command.
    ```bash
    go get -u github.com/ybkuroki/go-webapp-sample
    ```

## Starting Server
There are 2 methods for starting server.

### Without Web Server
1. Starting this web application by the following command.
    ```bash
    go run main.go
    ```
1. When startup is complete, the console shows the following message:
    ```
    http server started on [::]:8080
    ```
1. Access [http://localhost:8080](http://localhost:8080) in your browser.
1. Login with the following username and password.
    - username : ``test``
    - password : ``test``

### With Web Server
#### Starting Application Server
1. Starting this web application by the following command.
    ```bash
    go run main.go
    ```
1. When startup is complete, the console shows the following message:
    ```
    http server started on [::]:8080
    ```
1. Access [http://localhost:8080/api/health](http://localhost:8080/api/health) in your browser and confirm that this application has started.
    ```
    healthy
    ```
#### Starting Web Server
1. Clone [vuejs-webapp-sample](https://github.com/ybkuroki/vuejs-webapp-sample) project and install some tools.
1. Start by the following command.
    ```bash
    npm run serve
    ```
1. When startup is complete, the console shows the following message:
    ```
    DONE Compiled successfully in *****ms
    
    App running at:
    - Local:   http://localhost:3000/
    - Network: http://192.168.***.***:3000/
    
    Note that the development build is not optimized.
    To create a production build, run npm run build.
    ```
1. Access [http://localhost:3000](http://localhost:3000) in your browser.
1. Login with the following username and password.
    - username : ``test``
    - password : ``test``

## Build executable file
Build this source code by the following command.
```bash
go build main.go
```

## Project Map
The follwing figure is the map of this sample project.

```
- go-webapp-sample
  + config                  … Define configurations of this system.
  + logger                  … Provide loggers.
  + middleware              … Define custom middleware.
  + migration               … Provide database migration service for development.
  + router                  … Define routing.
  + controller              … Define controllers.
  + model                   … Define models.
  + repository              … Provide a service of database access.
  + service                 … Provide a service of book management.
  + session                 … Provide session management.
  + test                    … for unit test
  - main.go                 … Entry Point.
```

## Services
This sample provides 3 services: book management, account management, and master management.

### Book Management
There are the following services in the book management.

|Service Name|HTTP Method|URL|Parameter|Summary|
|:---|:---:|:---|:---|:---|
|Get Service|GET|``/api/book?id=[BOOK_ID]``|Book ID|Get a book data.|
|List Service|GET|``/api/book/list?page=[PAGE_NUMBER]&size=[PAGE_SIZE]``|Page|Get a list of books.|
|Regist Service|POST|``/api/book/new``|Book|Regist a book data.|
|Edit Service|POST|``/api/book/edit``|Book|Edit a book data.|
|Delete Service|POST|``/api/book/delete``|Book|Delete a book data.|
|Search Title Service|GET|``/api/book/search?query=[KEYWORD]&page=[PAGE_NUMBER]&size=[PAGE_SIZE]``|Keyword, Page|Search a title with  the specified keyword.|

### Account Management
There are the following services in the Account management.

|Service Name|HTTP Method|URL|Parameter|Summary|
|:---|:---:|:---|:---|:---|
|Login Service|POST|``/api/account/login``|Session ID, User Name, Password|Session authentication with username and password.|
|Logout Service|POST|``/api/account/logout``|Session ID|Logout a user.|
|Login Status Check Service|GET|``/api/account/loginStatus``|Session ID|Check if the user is logged in.|
|Login Username Service|GET|``/api/account/loginAccount``|Session ID|Get the login user's username.|

### Master Management
There are the following services in the Master management.

|Service Name|HTTP Method|URL|Parameter|Summary|
|:---|:---:|:---|:---|:---|
|Category List Service|GET|``/api/master/category``|Nothing|Get a list of categories.|
|Format List Service|GET|``/api/master/format``|Nothing|Get a list of formats.|

## Libraries
This sample uses the following libraries.

|Library Name|Version|
|:---|:---:|
|Echo|4.3.0|
|Gorm|1.9.16|
|go-playground/validator.v9|9.31.0|
|Zap/logger|1.17.0|

## Contribution
Please read [CONTRIBUTING.md](https://github.com/ybkuroki/go-webapp-sample/blob/master/CONTRIBUTING.md) for proposing new functions, reporting bugs and submitting pull requests before contributing to this repository.

## License
The License of this sample is *MIT License*.

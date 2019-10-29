# Go学习demo

https://github.com/EDDYCJY/go-gin-example/blob/master/README.md

# 文章：
https://github.com/EDDYCJY/go-gin-example/blob/master/README_ZH.md

## 搭建blog api

https://github.com/EDDYCJY/blog/blob/master/golang/gin/2018-02-16-Gin%E5%AE%9E%E8%B7%B5-%E8%BF%9E%E8%BD%BD%E4%BA%8C-%E6%90%AD%E5%BB%BABlogAPIs-01.md

## 安装依赖

go get -u github.com/go-ini/ini

go get -u github.com/Unknwon/com

go get -u github.com/jinzhu/gorm

go get -u github.com/go-sql-driver/mysql

go get -u github.com/swaggo/swag/cmd/swag


## Gin中集成swagger

### 参考地址 

https://github.com/EDDYCJY/blog/blob/master/golang/gin/2018-03-18-Gin%E5%AE%9E%E8%B7%B5-%E8%BF%9E%E8%BD%BD%E5%85%AB-%E4%B8%BA%E5%AE%83%E5%8A%A0%E4%B8%8ASwagger.md

### 安装 swap
 go get -u github.com/swaggo/swag/cmd/swag

#### 验证是否安装成功
swag -v

### 项目中安装 gin-swagger
go get -u github.com/swaggo/gin-swagger

Swagger 中需要将相应的注释或注解编写到方法上，再利用生成器自动生成说明文件

### swager范例
gin-swagger 给出的范例：

// @Summary Add a new pet to the store
// @Description get string by ID
// @Accept  json
// @Produce  json
// @Param   some_id     path    int     true        "Some ID"
// @Success 200 {string} string	"ok"
// @Failure 400 {object} web.APIError "We need ID!!"
// @Failure 404 {object} web.APIError "Can not find ID"
// @Router /testapi/get-string-by-int/{some_id} [get]

### 启动
入到gin-blog的项目根目录中，执行初始化命令
Swag init

### 访问
访问一下 http://127.0.0.1:8000/swagger/index.html， 查看 API 文档生成是否正确
## Vapor use Vue 

This is demo Vapor use Vue

- add Leaf

```
.package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
```
- config

```
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

```
- render html

```
    app.get { req in
        return req.view.render("index.html", ["title": "Hello Vapor!"])
    }
```

### `build scf`

- 构建

```
bash Serverless/scf.sh
```
- 测试

```
cd .build/install
docker run -v "$PWD:/app" -w /app swift:5.5.1-centos7-slim ./Run routes
```
- 压缩

```
tar cvzf todolist-0.0.1.tar.gz -C .build/install .
```

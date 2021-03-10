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

- use Vue

```
<!DOCTYPE html>
<html lang="en">

<head>
    <script src="https://unpkg.com/vue@next"></script>

    <!-- Can receive parameters  -->
    <title>#(title)</title>
</head>

<body>

    <h3> Declarative Rendering</h3>
    <div id="app">
        {{ message }}
    </div>

    <!-- END -->
    <!-- This should bottom -->
    <script src="static/js/app.js"></script>
</body>

</html>

```
- static js

```
const App = {
    data() {
        return {
            message: 'Hello Vue!'
        }
    }
}
Vue.createApp(App).mount('#app')
```

### `build lambda`

```
bash build_lambda.sh
```
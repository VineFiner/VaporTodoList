// 声明式渲染
const App = {
    data() {
        return {
            message: 'Hello Vue!'
        }
    }
}
Vue.createApp(App).mount('#app')

// 响应式关联
const CounterApp = {
    data() {
        return {
            counter: 0
        }
    },
    mounted() {
        setInterval(() => {
            this.counter++
        }, 1000)
    }
}
Vue.createApp(CounterApp).mount('#counter')

// 绑定元素的 attribute：
const AttributeBinding = {
    data() {
        return {
            message: 'You loaded this page on ' + new Date().toLocaleString()
        }
    }
}
Vue.createApp(AttributeBinding).mount('#bind-attribute')

// 处理用户输入
const EventHandling = {
    data() {
        return {
            message: 'Hello Vue.js!'
        }
    },
    methods: {
        reverseMessage() {
            this.message = this.message
                .split('')
                .reverse()
                .join('')
        }
    }
}
Vue.createApp(EventHandling).mount('#event-handling')

// 双向绑定
const TwoWayBinding = {
    data() {
        return {
            message: 'Hello Vue!'
        }
    }
}
Vue.createApp(TwoWayBinding).mount('#two-way-binding')

// 条件
const ConditionalRendering = {
    data() {
        return {
            seen: true
        }
    }
}
Vue.createApp(ConditionalRendering).mount('#conditional-rendering')

// 循环
const ListRendering = {
    data() {
        return {
            todos: [
                { text: 'Learn JavaScript' },
                { text: 'Learn Vue' },
                { text: 'Build something awesome' }
            ]
        }
    }
}
Vue.createApp(ListRendering).mount('#list-rendering')

const TodoList = {
    data() {
        return {
            groceryList: [
                { id: 0, text: 'Vegetables' },
                { id: 1, text: 'Cheese' },
                { id: 2, text: 'Whatever else humans are supposed to eat' }
            ]
        }
    }
}
// 创建 Vue 应用
const app = Vue.createApp(TodoList)
// 定义名为 todo-item 的新组件
app.component('todo-item', {
    props: ['todo'],
    template: `<li>{{ todo.text }}</li>`
})
// 挂载 Vue 应用
app.mount('#todo-list-app')

// axios 网络请求
Vue.createApp({
    data() {
        return {
            message: "",
            datalist: []
        }
    },
    methods: {
        handleClick() {
            axios.get("api/todos").then(res => {
                this.datalist = res.data
            }).catch(err => {
                console.log(err);
            })
        },
        createTodo() {
            axios.post('api/todos', {
                title: this.message
            }).then(res => {
                console.log(res);
                this.datalist.push(res.data);
                this.message = ""
            }).catch(err => {
                console.log(error);
                this.message = ""
            });
        },
        removeTodo: function (data) {
            console.log(data.id)
            axios.delete("api/todos/" + data.id, {
                todoID: data.id
            }).then(res => {
                this.datalist.splice(this.datalist.indexOf(data), 1);
            }).catch(err => {
                console.log(err);
            })
        }
    }
}).mount("#todo-axios");


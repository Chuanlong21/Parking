const express = require('express')
const app = express()
const port = 3000

// 处理静态资源请求
app.use(express.static('src/page'))

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/page/index.html');
});

// 启动服务器
app.listen(port, () => {
    console.log(`listening at http://localhost:${port}`)
})

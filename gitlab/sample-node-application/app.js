const express = require('express')
const app = express()
const port = 8080

app.get('/', (req, res) => {
  res.send('This is my Node application for CICD!!')
})

app.listen(port, () => {
  console.log(`Application is listening at http://localhost:${port}`)
})

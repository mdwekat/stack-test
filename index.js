const express = require('express')
const fs = require('fs')

const app = express()

app.get('/', (req, res) => {
  const path = './data/message.txt';
  let message = "Hello, New change!";

  try {
    if (fs.existsSync(path)) {
      message = fs.readFileSync(path, 'utf8');
    }
    res.send(message);
  } catch (err) {
    console.error(err)
    res.send(err.message)
  }

})

app.listen(3000, () => {
  console.log('server is running on port 3000')
})

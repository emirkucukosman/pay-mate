// Express Server
const express = require('express')
const config = require('./config')
const app = express()

// Mongoose
const mongoose = require('mongoose')

// Port
const port = process.env.PORT || 5000

// MongoDB Connection
mongoose.connect(config.mongoURI, config.mongoSettings, (err) => {
    if (err) console.log(err);
})

// JSON body parser
app.use(express.json())

// @route /
// @description Main route of the API
app.get('/', (req, res) => {
    return res.status(200).json({
        success: true,
        message: "API functioning normally"
    })
})

// Routes
app.use('/api/user', require('./routes/api/user'))
app.use('/api/account', require('./routes/api/account'))

// Listen on defined port
app.listen(port, () => console.log(`server listening on port ${port}`))
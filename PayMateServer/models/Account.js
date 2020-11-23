const mongoose = require('mongoose')

const accountSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true
    },
    balance: {
        type: Number,
        default: 0
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
})

module.exports = mongoose.model('Account', accountSchema)
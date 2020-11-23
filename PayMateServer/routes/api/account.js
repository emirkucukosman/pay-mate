// Express Router
const router = require('express').Router()
const config = require('../../config')

// Models
const Account = require('../../models/Account')

// Security
const jwt = require('jsonwebtoken')

// Misc
const { guardAuthHeader } = require('../../guards/guard')
const { unexpectedError } = require('../../utils/common')

router.get('/balance', guardAuthHeader, (req, res) => {

    jwt.verify(req.headers.authorization, config.jwtSecret, (err, decoded) => {
        if(err || !decoded) return res.status(401).json({ success: false, message: "Unauthorized" })

        const { username } = decoded
        Account.findOne({ username }, (err, account) => {
            if (err || !account) return unexpectedError(res)
            return res.status(200).json({
                success: true,
                message: "OK",
                account
            })
        })
    })

})

module.exports = router
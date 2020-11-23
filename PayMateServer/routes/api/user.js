// Express Router
const router = require('express').Router()
const config = require('../../config')

// Security
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

// Models
const User = require('../../models/User')
const Account = require('../../models/Account')

// Misc
const { guardContentType } = require('../../guards/guard')
const { registerSchema, loginSchema } = require('../../validation/schemas')
const { unexpectedError } = require('../../utils/common')

// @route /api/user/register
// @description Registers a new user
router.post('/register', guardContentType, (req, res) => {

    // Validate the register schema with request's body
    const validation = registerSchema.validate(req.body)

    // Check for validation error
    if (validation.error != null) {
        return res.status(400).json({
            success: false,
            message: validation.error.message
        })
    }

    // Deconstruct request's body
    const { username, email, password } = req.body

    // Generate salt for the password hash
    bcrypt.genSalt(10, (err, salt) => {
        if (err || !salt) return unexpectedError(res)
        
        // Create a new user and account model
        const newUser = new User({ username, email, password })
        const newAccount = new Account({ username })

        // Hash the password with generated salt
        bcrypt.hash(password, salt, async (err, hash) => {
            if (err || !hash) return unexpectedError(res)

            // Assign the generated hash to the plain text password
            newUser.password = hash

            // Save the user and account to MongoDB
            const savedUser = await newUser.save()
            const savedAccount = await newAccount.save()

            if (savedUser && savedAccount) {
                return res.status(200).json({
                    success: true,
                    message: "Registration Successful"
                })
            } else {
                return unexpectedError(res)
            }
        })
    })

})

// @route /api/user/login
// @description Logins the existing user
router.post('/login', guardContentType, (req, res) => {

    // Validate the register schema with request's body
    const validation = loginSchema.validate(req.body)

    // Check for validation error
    if (validation.error != null) {
        return res.status(400).json({
            success: false,
            message: validation.error.message
        })
    }

    // Deconstruct request's body
    const { username, password } = req.body

    // Find the user with the same username
    User.findOne({ username }, (err, user) => {
        if (err) return unexpectedError(res)
        if (!user) return res.status(401).json({ success: false, message: "Invalid credentials" })
        
        // Compare the passwords
        bcrypt.compare(password, user.password, (err, match) => {
            if (err) return unexpectedError(res)
            if (!match) return res.status(401).json({ success: false, message: "Invalid credentials" })

            // Create a payload for the JWT
            const payload = {
                username: user.username,
                email: user.email,
                createdAt: user.createdAt
            }

            // Sign the JWT
            const token = jwt.sign(payload, config.jwtSecret, {
                expiresIn: '3h'
            })

            return res.status(200).json({
                success: true,
                message: "Login Successful",
                token
            })
        })
    })

})

module.exports = router
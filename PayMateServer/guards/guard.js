const guardContentType = (req, res, next) => {
    if (!req.is('application/json')) {
        return res.status(400).json({
            success: false,
            message: "Bad request"
        })
    }
    next()
}

const guardAuthHeader = (req, res, next) => {
    if (!req.headers.authorization) {
        return res.status(401).json({
            success: false,
            message: "Unauthorized"
        })
    }
    next()
}

module.exports = {
    guardContentType,
    guardAuthHeader
}
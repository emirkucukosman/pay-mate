const unexpectedError = (res) => {
    return res.status(500).json({
        success: false,
        message: "Unexpected error has occured"
    })
}

module.exports = {
    unexpectedError
}
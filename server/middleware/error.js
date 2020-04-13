import ErrorResonse from "../utils/errorResponse.js"

export default (err, req, res, next) => {
  let error = { ...err }
  error.message = err.message

  console.log(err.stack.red)

  // Mongoose errors
  // Bad ID (not found)
  if (err.name === "CastError") {
    const message = `Resource '${err.value}' not found.`
    error = new ErrorResonse(message, 404)
  }

  // Duplicate field
  if (err.code === 11000) {
    const message = "Resource already exists."
    error = new ErrorResonse(message, 400)
  }

  // Validation error
  if (err.name === "ValidationError") {
    const message = Object.values(err.errors).map(val => val.message)
    error = new ErrorResonse(message, 400)
  }
  res
    .status(error.statusCode)
    .json({ success: false, error: error.message || "Server error" })
}

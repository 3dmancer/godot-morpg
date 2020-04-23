import ErrorResponse from "../utils/errorResponse.js"
import asyncHandler from "../middleware/async.js"
import User from "../models/User.js"

// @desc    Register User (signup)
// @route   POST /api/v1/auth/register
// @access  Public
export const register = asyncHandler(async (req, res, next) => {
  const { username, password, role } = req.body
  const user = await User.create({ username, password, role })

  // Send back token
  const token = user.getSignedJwtToken()
  res.status(201).json({ success: true, token })
})

// @desc    Login user
// @route   POST /api/v1/auth/login
// @access  Public
export const login = asyncHandler(async (req, res, next) => {
  const { username, password } = req.body

  // Validate entered fields
  if (!username || !password) {
    return next(new ErrorResponse("Username and password are required", 401))
  }

  // Check for user in db
  const user = await User.findOne({ username }).select("+password")
  if (!user) {
    return next(new ErrorResponse("Invalid credentials", 401))
  }

  // Check password
  const isMatch = await user.matchPassword(password)
  if (!isMatch) {
    return next(new ErrorResponse("Invalid credentials", 401))
  }

  // Send back token
  const token = user.getSignedJwtToken()
  res.status(201).json({ success: true, token })
})

import ErrorResponse from "../utils/errorResponse.js"
import asyncHandler from "../middleware/async.js"
import User from "../models/User.js"

export const getUsers = asyncHandler(async (req, res, next) => {
  const users = await User.find()
  res.status(200).json({ success: true, data: users })
})

export const getUser = asyncHandler(async (req, res, next) => {
  const user = await User.findById(req.params.id)

  if (!user) {
    return next(new ErrorResponse(`User '${req.params.id}' not found.`), 404)
  }
  res.status(200).json({ success: true, data: user })
})

// Create User
export const createUser = asyncHandler(async (req, res, next) => {
  const user = await User.create(req.body)

  res.status(201).json({
    sucess: true,
    data: user,
  })
})

export const updateUser = asyncHandler(async (req, res, next) => {
  const user = await User.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  })

  if (!user) {
    return next(new ErrorResponse(`User '${req.params.id}' not found.`), 404)
  }

  res.status(200).json({
    sucess: true,
    data: user,
  })
})

export const deleteUser = asyncHandler(async (req, res, next) => {
  const user = await User.findByIdAndDelete(req.params.id)

  if (!user) {
    return next(new ErrorResponse(`User '${req.params.id}' not found.`), 404)
  }

  res.status(200).json({
    sucess: true,
    data: {},
  })
})

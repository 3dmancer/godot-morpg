import ErrorResponse from "../utils/errorResponse.js"
import User from "../models/User.js"

export const getUsers = async (req, res, next) => {
  try {
    const users = await User.find()
    res.status(200).json({ success: true, data: users })
  } catch (error) {
    next(error)
  }
}

export const getUser = async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id)

    if (!user) {
      return next(new ErrorResponse(`User '${req.params.id}' not found.`), 404)
    }
    res.status(200).json({ success: true, data: user })
  } catch (error) {
    next(error)
  }
}

// Create User
export const createUser = async (req, res, next) => {
  try {
    const user = await User.create(req.body)

    res.status(201).json({
      sucess: true,
      data: user,
    })
  } catch (error) {
    next(error)
  }
}

export const updateUser = async (req, res, next) => {
  try {
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
  } catch (error) {
    next(error)
  }
}

export const deleteUser = async (req, res, next) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id)

    if (!user) {
      return next(new ErrorResponse(`User '${req.params.id}' not found.`), 404)
    }

    res.status(200).json({
      sucess: true,
      data: {},
    })
  } catch (error) {
    next(error)
  }
}

import express from "express"
import {
  getUsers,
  getUser,
  createUser,
  updateUser,
  deleteUser,
} from "../controllers/users.js"

const router = express.Router()

router.route("/").get(getUsers).post(createUser)
router.route("/:id").get(getUser).put(updateUser).delete(deleteUser)

export default router

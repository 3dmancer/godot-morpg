// IMPORTS
// ------------------------------
import express from "express"
import dotenv from "dotenv"
import connectDB from "./config/db.js"
import _colors from "colors"

//Middleware
import morgan from "morgan"
import errorHandler from "./middleware/error.js"

// Routes
import { userRoutes, authRoutes } from "./routes/index.js"
// ------------------------------

// Load env vars
dotenv.config({ path: "./config/config.env" })

connectDB()

const app = express()

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"))
} else if (process.env.NODE_ENV === "production") {
  app.use(morgan("common"))
}

app.use(express.json())

// Routes
app.use("/api/v1/users", userRoutes)
app.use("/api/v1/auth", authRoutes)

app.use(errorHandler)

const PORT = process.env.PORT || 5000
const server = app.listen(
  PORT,
  console.log(
    `Server is running in ${process.env.NODE_ENV} mode on port ${PORT} \\(• ◡ •)/`
      .yellow.bold
  )
)

// Handle unhandled promise rejections
process.on("unhandledRejection", (err, promise) => {
  console.log(`Error: ${err.message}`.red.bold)

  // Close server
  server.close(() => process.exit(-1))
})

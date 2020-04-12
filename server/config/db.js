import mongoose from "mongoose"

export default async () => {
  console.log("Connecting to MongoDB...".cyan)
  const c = await mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useUnifiedTopology: true,
  })

  console.log(`MongoDB connected: ${c.connection.host}`.cyan)
}

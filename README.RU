Username
0507040848ua_db_user

Password
g4Iv7te2wb2YfHkP

npm install mongoose




const mongoose = require('mongoose');
const uri = "mongodb+srv://0507040848ua_db_user:g4Iv7te2wb2YfHkP@cluster0.jloxejo.mongodb.net/?appName=Cluster0";

const clientOptions = { serverApi: { version: '1', strict: true, deprecationErrors: true } };

async function run() {
  try {
    // Create a Mongoose client with a MongoClientOptions object to set the Stable API version
    await mongoose.connect(uri, clientOptions);
    await mongoose.connection.db.admin().command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } finally {
    // Ensures that the client will close when you finish/error
    await mongoose.disconnect();
  }
}
run().catch(console.dir);



mongodb+srv://0507040848ua_db_user:g4Iv7te2wb2YfHkP@cluster0.jloxejo.mongodb.net/?appName=Cluster0
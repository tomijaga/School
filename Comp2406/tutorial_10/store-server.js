const express = require("express");
const app = express();
const mongoose = require("mongoose");
const express_session = require("express-session");
const requirejs = require("requirejs");
const MongoDBStore = requirejs("connect-mongodb-session")(express_session);
let sessionStore = new MongoDBStore({
  uri: `mongodb+srv://tomijaga:robotrade@cluster.ftv5l.gcp.mongodb.net/tutorial_10?retryWrites=true&w=majority`,
  collection: "mySessions",
});

sessionStore.on("error", function (error) {
  console.log("Session Error:\n" + error);
});

const session = express_session({
  secret: "Avengers",
  rolling: true,
  resave: true,
  name: "session",
  saveUninitialized: true,
  rolling: true,
  store: sessionStore,
  cookie: {
    maxAge: 1000 * 60 * 30,
  },
});

app.use(session);

app.set("view engine", "pug");

let userRouter = require("./user-router");
app.use("/users", userRouter);
let productsRouter = require("./products-router");
app.use("/products", productsRouter);
let reviewsRouter = require("./reviews-router");
app.use("/reviews", reviewsRouter);

app.get("/", function (req, res) {
  //You can perform regular Mongo queries through Mongoose
  // use: mongoose.connection.db to refer to the database connection
  mongoose.connection.db
    .collection("config")
    .findOne({ id: "mainpage" }, function (err, result) {
      if (err) {
        res.status(500).send("Error reading main page config.");
        return;
      }
      console.log("Result: ");
      console.log(result);
      res.render("pages/index", result);
    });
});

mongoose.connect(
  "mongodb+srv://tomijaga:robotrade@cluster.ftv5l.gcp.mongodb.net/tutorial_10?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  }
);

let db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error:"));
db.once("open", function () {
  let featured = [
    { name: "Rusty Old Bike", price: 15.99 },
    { name: "Broken Wooden Chair", price: 56.99 },
    { name: "Rare Dinosaur Egg", price: 19.99 },
  ];
  let storeMotto = "We break it, you buy it.";

  mongoose.connection.db
    .collection("config")
    .replaceOne(
      { id: "mainpage" },
      { id: "mainpage", featured: featured, motto: storeMotto },
      { upsert: true },
      function (err, result) {
        if (err) {
          console.log("Error adding main page config.");
          return;
        }
        app.listen(3000);
        console.log("Server listening on port 3000");
      }
    );
});

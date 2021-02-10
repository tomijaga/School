/*
Routes:
	/cards - search all cards (query params: class, set, type, artist)
	/cards/:cardID - specific card with ID=:cardID
*/

import path from "path";
import fs from "fs";
import express from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import mongoose from "mongoose";
import expressReact from "express-react-views";
import CardModel from "./models/card.js";
import cardsRoute from "./routes/cards.js";
import indexRoute from "./routes/index.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

mongoose.connect(
  "mongodb+srv://tomijaga:robotrade@cluster.ftv5l.gcp.mongodb.net/tutorial_5?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  }
);

const app = express();
app.set("views", __dirname + "/views");
app.set("view engine", "jsx");
app.engine("jsx", expressReact.createEngine());

app.locals.db = mongoose.connection;
app.use(express.static("public"));

app.on("error", console.error.bind(console, "Database connection error:"));

app.locals.db.once("open", async () => {
  //Start listening when database is connected

  app.listen(3000, () =>
    console.log("Server listening at http://localhost:3000")
  );
});
app.use("/", indexRoute);
app.use("/cards", cardsRoute);

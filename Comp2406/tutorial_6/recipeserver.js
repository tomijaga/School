import express from "express";
import mongoose from "mongoose";
import RecipeModel from "./models/Recipe.js";
import path from "path";
import { fileURLToPath } from "url";
import { dirname } from "path";
import expressReact from "express-react-views";
import recipesRoute from "./routes/recipes.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

mongoose.connect(
  "mongodb+srv://tomijaga:robotrade@cluster.ftv5l.gcp.mongodb.net/tutorial_6?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  }
);

let app = express();

app.set("views", __dirname + "/views");
app.set("view engine", "jsx");
app.engine("jsx", expressReact.createEngine());

app.use("/recipes", recipesRoute);

app.locals.db = mongoose.connection;

app.use(express.static("public"));

app.on("error", console.error.bind(console, "Database connection error:"));

app.locals.db.once("open", () => {
  //Start listening when database is connected
  app.listen(3000, () =>
    console.log("Server listening at http://localhost:3000")
  );
});

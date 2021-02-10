import path from "path";
import express from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import RecipeModel from "../models/Recipe.js";
import mongoose from "mongoose";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const router = express.Router();

router.use(express.json());

router.get("/", (req, res) => {
  RecipeModel.find({}, (err, recipes) => {
    if (err) {
    } else {
      res.render("Index", { recipes });
    }
  });
});

const ObjectId = mongoose.Types.ObjectId;

const isIdValid = (req, res, next) => {
  const { id } = req.params;
  if (!ObjectId.isValid(id)) {
    return res.redirect("http://localhost:3000/404");
  }

  req.params.ObjectId = ObjectId(id);
  next();
};

router.get("/:id", isIdValid, (req, res) => {
  const _id = req.params.ObjectId;
  RecipeModel.findOne({ _id }, (err, recipe) => {
    if (err) {
      console.log(err);
    } else {
      res.render("RecipePage", { recipe });
    }
  });
});

router.post("/", (req, res) => {
  let newRecipe = RecipeModel(req.body.recipe);
  newRecipe.save((err, newRecipe) => {
    if (err) {
      console.error(err);
    } else {
      res.status(200).send("added");
    }
  });
});
export default router;

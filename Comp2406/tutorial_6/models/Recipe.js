import mongoose from "mongoose";

const Schema = mongoose.Schema;

const ingredientSchema = new Schema({
  name: String,
  unit: String,
  amount: Number,
});

const recipeSchema = new Schema({
  name: String,
  preptime: String,
  cookTime: String,
  description: String,
  ingredients: [ingredientSchema],
});

export default mongoose.model("recipes", recipeSchema);

import mongoose from "mongoose";

const Schema = mongoose.Schema;

const cardSchema = new Schema({
  artist: String,
  attack: Number,
  cardClass: String,
  health: Number,
  id: String,

  name: String,

  rarity: String,

  set: String,
  text: String,
  type: String,
});

export default mongoose.model("cards", cardSchema);

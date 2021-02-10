import mongoose from "mongoose";

const Schema = mongoose.Schema;

const cardSchema = new Schema(
  {
    artist: String,
    attack: Number,
    cardClass: String,
    collectible: Boolean,
    cost: Number,
    dbfId: Number,
    elite: Boolean,
    entourage: [String],
    flavor: String,
    health: Boolean,

    id: String,

    mechanics: [String],
    name: String,
    playRequirements: {
      REQ_MINION_TARGET: Number,
      REQ_TARGET_IF_AVAILABLE_AND_NO_3_COST_CARD_IN_DECK: Number,
    },
    rarity: String,
    referencedTags: [String],
    set: String,
    text: String,
    type: String,
  },
  { strict: false }
);

export default mongoose.model("cards", cardSchema);

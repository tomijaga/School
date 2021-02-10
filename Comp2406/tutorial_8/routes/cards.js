import path from "path";
import express from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import CardModel from "../models/card.js";
import mongoose from "mongoose";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const router = express.Router();

router.use(express.json());

router.get("/", (req, res) => {
  const {
    name,
    artist,
    minAttack,
    maxAttack,
    minHealth,
    maxHealth,
    cardClass,
    rarity,
  } = req.query;
  console.log({ name });

  if (
    name ||
    artist ||
    maxAttack ||
    minAttack ||
    minHealth ||
    maxHealth ||
    cardClass ||
    rarity
  ) {
    let nameRegex = new RegExp(name, "gi");

    let artistRegex = new RegExp(artist, "gi");

    let classRegex = new RegExp(cardClass == "NONE" ? "" : cardClass, "gi");

    let rarityRegex = new RegExp(rarity == "NONE" ? "" : rarity, "gi");

    CardModel.find({
      name: nameRegex,
      artist: artistRegex,
      cardClass: classRegex,
      rarity: rarityRegex,
    })
      .where("attack")
      .gte(minAttack ? minAttack : 0)
      .lte(maxAttack ? maxAttack : Infinity)
      .where("health")
      .gte(minHealth ? minHealth : 0)
      .lte(maxHealth ? maxHealth : Infinity)
      .exec((err, cards) => {
        if (err) {
          console.log("error occured at cards ");
        }
        return res.render("Cards", { cards });
      });
  } else {
    CardModel.find({})
      .limit(25)
      .exec((err, cards) => {
        if (err) {
          console.log("error occured at cards ");
        }
        return res.render("Cards", { cards });
      });
  }
});

router.get("/:id", async (req, res) => {
  const id = req.params.id;

  console.log({ id });
  let exists = await CardModel.exists({ id });

  if (exists) {
    CardModel.findOne({ id }, (err, card) => {
      if (err) {
        console.log(err);
      } else {
        return res.render("CardPage", { card });
      }
    });
  } else {
    return res.status(404).json({ card: "not Found" });
  }
});

export default router;

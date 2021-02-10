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
  const { name } = req.query;
  console.log({ name });
  if (name) {
    console.log("filtered");
    CardModel.find({ name })
      .limit(25)
      .exec((err, cards) => {
        if (err) {
          console.log("error occured at cards ");
        }
        return res.render("Index", { cards });
      });
  } else {
    CardModel.find({})
      .limit(25)
      .exec((err, cards) => {
        if (err) {
          console.log("error occured at cards ");
        }
        return res.render("Index", { cards });
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

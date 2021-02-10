import express from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import CardModel from "../models/card.js";

const router = express.Router();

router.use(express.json());

router.get("/", (req, res) => {
  res.render("Index");
});

export default router;

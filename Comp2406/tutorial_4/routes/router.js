import path, { resolve } from "path";
import express, { Router } from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import { toDoList, changeList } from "../initList.js";
import bodyParser from "body-parser";


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const router = express.Router();

router.get("/", async (req, res) => {
  console.log("requested List");
  console.log(toDoList);
  res.json(JSON.stringify(toDoList));
});

router.post("/add", async (req, res) => {
  if (req.body.toDo) {
    toDoList.push(req.body);
    console.log(toDoList);
    res.json("successful");
  } else {
    res.statusCode(404);
    res.statusMessage("data not Valid!");
  }
});

router.post("/remove", async (req, res) => {
  if (req.body) {
    let ids = req.body;

    console.log(ids);

    const newList = toDoList.filter((item, i) => {
      console.log(i, !ids.includes(i + ""));
      return !ids.includes(i + "");
    });

    changeList(newList);
    console.log(toDoList);
    res.json("successful");
  }
});

router.post("/highlight", async(req, res)=>{

if(req.body){
  const ids = req.body.items;
  const color = req.body.color

console.log("\n Highlighting Items:");
  console.log(ids, color);

  toDoList.forEach((item,i)=>{
    if(ids.includes(i+"")){
      item.borderColor=color;
    }
  })

console.log(toDoList);

res.json({selectedItems:ids, color:color});
}

})

router.get("/sort/color", (req, res)=>{
 
 console.log(toDoList);
  toDoList.sort((itemA, itemB) => {
    if (itemA.borderColor > itemB.borderColor) {
      return -1;
    } else if (itemA.borderColor < itemB.borderColor) {
      return 1;
    }
    return 0;
  });

  console.log(toDoList)
  res.json(toDoList);
});



export { router as listRouter };

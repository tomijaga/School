import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { dirname } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let rawData = fs.readFileSync(path.resolve(__dirname, "list.json"));

const toDoList = JSON.parse(rawData);

const changeList = (list) => {
  toDoList = list;
};

const writeToList = (list) => {
  fs.writeFileSync(path.resolve(__dirname, "list.json"), JSON.stringify(list));
};

export { toDoList, changeList, writeToList };

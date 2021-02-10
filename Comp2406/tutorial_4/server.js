import path from "path";
import express, { Router } from "express";
import { fileURLToPath } from "url";
import { dirname } from "path";
import bodyParser from "body-parser";
import { listRouter } from "./routes/router.js";
import http from "http";
import requirejs from "requirejs";
import { toDoList, changeList, writeToList } from "./initList.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const server = http.createServer(app);
const io = requirejs("socket.io").listen(server);

server.listen(3001, () => console.log("listening on port 3001"));

const connections = [];

io.sockets.on("connection", (socket) => {
  connections.push(socket);
  console.log(" %s sockets is connected", connections.length);

  socket.on("disconnect", () => {
    connections.splice(connections.indexOf(socket), 1);
  });

  socket.on("get list", (message) => {
    console.log(message);
    socket.emit("list", toDoList);
  });

  socket.on("add item", (item) => {
    if (item) {
      toDoList.push(item);
      writeToList(toDoList);
      console.log(toDoList);
      socket.emit("add status", "successful", item.toDo);
      socket.broadcast.emit("add status", "successful", item.toDo);
    } else {
      res.statusCode(404);
      res.statusMessage("data not Valid!");
    }
  });

  socket.on("remove items", (ids) => {
    if (ids) {
      console.log("removing items ...");
      console.log(ids);

      const newList = toDoList.filter((item, i) => {
        return !ids.includes(i + "");
      });

      writeToList(newList);
      console.log(toDoList);
      socket.emit("remove status", "successful", ids);
      socket.broadcast.emit("remove status", "successful", ids);
    }
  });

  socket.on("set highlight", (obj) => {
    if (obj) {
      const ids = obj.items;
      const color = obj.color;

      console.log("setting Highlight on", ids);

      toDoList.forEach((id, i) => {
        if (ids.includes(i + "")) {
          id.borderColor = color;
        }
      });

      writeToList(toDoList);
      console.log(toDoList);

      socket.emit("highlighted", { selectedItems: ids, color: color });
      socket.broadcast.emit("highlighted", {
        selectedItems: ids,
        color: color,
      });
    }
  });

  socket.on("sort by color", () => {
    toDoList.sort((itemA, itemB) => {
      if (itemA.borderColor > itemB.borderColor) {
        return -1;
      } else if (itemA.borderColor < itemB.borderColor) {
        return 1;
      }
      return 0;
    });

    writeToList(toDoList);
    console.log(toDoList);
    socket.emit("sorted by color", toDoList);
    socket.broadcast.emit("sorted by color", toDoList);
  });

  socket.on("sort by item", () => {
    toDoList.sort((obj1, obj2) => obj1.toDo.localeCompare(obj2.toDo));
    writeToList(toDoList);
    console.log("sorted Alphabetically");
    console.log(toDoList);
    socket.emit("sorted alphabetically");
    socket.broadcast.emit("sorted alphabetically");
  });
});

app.use(express.static(path.join(__dirname, "public")));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
// app.use("/list", listRouter);

app.get("/", (req, res) => {
  res.sendFile(ath.join(__dirname, "public/index.html"));
});

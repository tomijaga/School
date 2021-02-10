import express from "express";
import cors from "cors";
import Websocket from "ws";
//import firebase from "firebase";
import bodyParser from "body-parser";
import { getQuestion } from "./script.js";

const app = express();
const port = 3001;

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Set up a headless websocket server that prints any
// events that come in.
// const ws = new Websocket.Server({ noServer: true });
// ws.on("connection", (socket) => {
//   socket.on("message", (message) => {
//     console.log(message);
//   });
// });

// const client = new Websocket("ws://localhost:3001");

// client.on("open", () => {
//   client.send("Hello");
// });

// const server = app.listen(port);

// server.on("upgrade", (req, socket, head) => {
//   ws.handleUpgrade((req, socket, head) => {
//     ws.emit("connection", socket, request);
//   });
// });

app.get("/", (req, res) => {
  console.log("path ->", req.path);
  res.send(JSON.stringify({ welcome: "user3409" }));
});

app.get("/trivia", (req, res) => {
  console.log("path ->", req.path);
  res.send(JSON.stringify({ welcome: "user3409" }));
});

let count = 0;
let user = {
  points: 0,
  time: 0,
  hard: 0,
  medium: 0,
  easy: 0,
};

app.post("/trivia", async (req, res) => {
  if (count !== 0) {
    const { correct, difficulty, points, time } = req.body;

    user.points += points;
    user.time += time;

    if (correct) {
      switch (difficulty) {
        case "hard":
          user.hard++;
          break;
        case "medium":
          user.medium++;
          break;
        case "easy":
          user.easy++;
          break;
        default:
          break;
      }
    }
  }

  console.log(user);
  if (count < 10) {
    const question = await getQuestion(++count);

    console.log("count", count);

    res.send(question);
  } else {
    res.send(user);
  }
});

app.listen(port, () =>
  console.log(`Server running at http://localhost:${port}`)
);

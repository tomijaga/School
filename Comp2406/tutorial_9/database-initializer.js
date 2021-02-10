const mongoose = require("mongoose");
const Book = require("./BookModel");
const fs = require("fs");
const csv = require("csv-parser");
const results = [];

mongoose.connect(
  "mongodb+srv://tomijaga:robotrade@cluster.ftv5l.gcp.mongodb.net/tutorial_9?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  }
);
let db = mongoose.connection;

db.on("error", console.error.bind(console, "connection error:"));
db.once("open", async function () {
  Book.deleteMany({}, function (err) {
    console.log("Dropped database. Starting re-creation.");

    let books = JSON.parse(fs.readFileSync("books.json"));
    books = books.filter((book) => {
      return book.isbn.length == 10;
    });
    let totalBooks = books.length;
    let finishedBooks = 0;
    let countFail = 0;
    let countSuccess = 0;

    books.forEach((book) => {
      let b = new Book(book);
      b.save(function (err, callback) {
        finishedBooks++;
        if (err) {
          countFail++;
          console.log(err.message);
        } else {
          countSuccess++;
        }

        if (finishedBooks % 500 == 0) {
          console.log("Finished book #" + finishedBooks + "/" + totalBooks);
        }
        if (finishedBooks == totalBooks) {
          console.log("Finished.");
          console.log("Successfully added: " + countSuccess);
          console.log("Failed: " + countFail);

          Book.getTopBooks(process.exit);
        }
      });
    });
  });
});

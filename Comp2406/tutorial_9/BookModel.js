const { access } = require("fs");
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

let bookSchema = Schema({
  title: { type: String, required: true },
  authors: { type: String, required: true },
  isbn: {
    type: String,
    required: true,
    minlength: 10,
    maxlength: 10,
    validate: {
      validator: (entry) => {
        let checkSum = 0;
        let times = 10;
        for (const char of entry) {
          checkSum += char !== "X" ? char * times-- : 10;
        }
        //console.log({ entry, checkSum });

        return checkSum % 11 === 0 && /\d{9}(X|\d)$/.test(entry);
      },
      message: (props) => `${props.value} is not a valid ISBN number!`,
    },
  },
  ratings: [Number],
});

bookSchema.statics.getTopBooks = function (callback) {
  let ratings = [];
  const getAvgRating = (bookRatings) => {
    let ratingSum = bookRatings.reduce((acc, value) => {
      return value + acc;
    }, 0);

    return ratingSum / bookRatings.length;
  };
  const getBooks = () => {
    let books = [];
    for (const book of ratings) {
      books.push(book.book);
    }
    return books;
  };

  this.find().exec((err, data) => {
    if (err) {
      console.log("ERRRROOOOOOOOOOOORRRRRRRRRR!!!!");
      if (callback) callback(getBooks());
    } else {
      for (const book of data) {
        if (book.ratings.length > 10) {
          // console.log({ ratings: book.ratings });
          let avg = getAvgRating(book.ratings);
          // console.log({ avg });
          if (ratings.length >= 10) {
            ratings.pop();
          }
          ratings.push({ avg, book });
        }

        if (ratings.length >= 0) ratings.sort((a, b) => b.avg - a.avg);
      }

      console.log("\n TOP BOOKS\n");
      let count = 0;
      for (const book of ratings) {
        // console.log(book);
        console.log(`${++count}. ${book.book.title} => (${book.avg})`);
      }
      if (callback) return callback(getBooks());
    }
  });
};

module.exports = mongoose.model("Book", bookSchema);

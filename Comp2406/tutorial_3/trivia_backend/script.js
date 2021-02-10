import fetch from "node-fetch";
let question;

const callAPI = async (difficulty) => {
  const url = `https://opentdb.com/api.php?amount=1&difficulty=${difficulty}&type=multiple`;

  await fetch(url)
    .then((response) => response.json())
    .then((response) => (question = response.results[0]));

  if (question !== "") {
    return question;
  }
  return false;
};

const getRandom = (n) => {
  return Math.floor(Math.random() * n);
};

const getQuestion = async (id) => {
  let difficultyIndex;

  if (id <= 2) {
    difficultyIndex = 0;
  } else if (id <= 4) {
    difficultyIndex = getRandom(2);
  } else if (id <= 7) {
    difficultyIndex = getRandom(3);
  } else if (id === 8) {
    difficultyIndex = getRandom(2) + 1;
  } else {
    difficultyIndex = 2;
  }

  const difficulty =
    difficultyIndex === 0 ? "easy" : difficultyIndex === 1 ? "medium" : "hard";

  return await callAPI(difficulty);
};

export { getQuestion, callAPI, getRandom };

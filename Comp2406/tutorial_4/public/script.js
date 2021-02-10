let socket;
let items = [];

const parseServerList = (items) => {
  return (items || []).map((item, i) => {
    return {
      toDo: item.toDo,
      isChecked: false,
      isHighlighted: false,
      id: i,
      borderColor: item.borderColor,
    };
  });
};

const verifyList = () => {
  socket.emit("get list", "Request for toDoList");
  console.log("Getting List Items ...");
};

const getList = (list) => {
  console.log(list);
  items = parseServerList(list);
  displayItems();
};

const updateLocalStorage = () => {
  console.log("should be stored");
  localStorage.setItem("iitemstems", JSON.stringify(items));
};

const deleteAllDisplayedItems = () => {
  document.querySelectorAll("li").forEach((att) => {
    att.remove();
  });
};

const createListItem = (element) => {
  const input = document.createElement("input");
  input.setAttribute("type", "checkbox");
  input.checked = element.isChecked;
  input.setAttribute("id", element.id);

  const div1 = document.createElement("div");
  div1.appendChild(input);

  const div2 = document.createElement("div");
  div2.innerHTML = element.toDo;

  const div3 = document.createElement("div");
  div3.style.borderColor = element.borderColor;
  div3.classList.add("item");

  div3.appendChild(div2);
  div3.appendChild(div1);

  const li = document.createElement("li");
  li.appendChild(div3);

  const ol = document.querySelector("ol");
  ol.appendChild(li);
};

const printAllItems = (passed) => {
  (items || passed).forEach((obj) => {
    createListItem(obj);
  });
};

const displayItems = () => {
  deleteAllDisplayedItems();
  printAllItems();
};

const addItemToArray = (toDo) => {
  items.push({
    toDo: toDo,
    isChecked: false,
    isHighlighted: false,
    id: items.length,
    borderColor: "black",
  });
};

const verifyAdd = (event) => {
  if (event.keyCode === 13 || event.type === "click") {
    const inputText = document.querySelector(".input-text");
    const text = inputText.value;
    inputText.value = "";

    if (text !== "") {
      socket.emit("add item", { toDo: text, borderColor: "black" });
    }
  }
};

const addAndDisplay = (text) => {
  addItemToArray(text);
  displayItems();

  console.log('Added: "' + text + '"');
};

const addButton = document.querySelector(".add-button");
addButton.addEventListener("click", verifyAdd);

const textBox = document.querySelector(".input-text");
textBox.addEventListener("keyup", verifyAdd);

const verifySortByItem = () => {
  socket.emit("sort by item");
};

//Sort handler
const sortAlphabetically = () => {
  items.sort((obj1, obj2) => obj1.toDo.localeCompare(obj2.toDo));

  displayItems();
};

const sortButton = document.querySelector(".sort-items");
sortButton.addEventListener("click", verifySortByItem);

// Remove Handler
const getSelectedItems = () => {
  let id = [];
  let check = document.querySelectorAll("input");

  check = check.forEach((input) => {
    if (input.getAttribute("type") === "checkbox") {
      if (input.checked === true) {
        id.push(input.getAttribute("id"));
      }
    }
  });
  return id;
};

const resetOrder = () => {
  let i = 0;
  items = items.map((obj) => {
    obj.id = i++;
    //console.log(obj);
    return obj;
  });
};

const verifyRemove = () => {
  let ids = getSelectedItems();

  socket.emit("remove items", ids);
};

const removeSelectedItems = (ids) => {
  items = items.filter((obj) => {
    let x = obj.id;
    if (ids.includes(x.toString())) {
      console.log("deleted");
      return false;
    }
    return true;
  });

  resetOrder();
  displayItems();
};

const removeButton = document.querySelector(".remove-items");
removeButton.addEventListener("click", verifyRemove);

const defaultBorderColor = () => {
  if (confirm("This will change all the list items to the default color!")) {
    items = items.map((item) => {
      item.borderColor = "black";
      return item;
    });

    displayItems();
  }
};

const getColorInput = () => {
  let c = document.querySelector(".highlight");
  return `${c.value}`;
};

const highlightSelectedItems = (selectedItems, color) => {
  console.log(selectedItems);
  console.log(color);

  items.map((item) => {
    if (selectedItems.includes(item.id.toString())) {
      item.borderColor = color;
    }
    return item;
  });

  displayItems();
};

const verifyHiglight = () => {
  let selectedItems = getSelectedItems();
  let color = getColorInput();

  socket.emit("set highlight", { items: selectedItems, color: color });
};

const toggleHighlightButton = document.querySelector(".toggle-highlight");
toggleHighlightButton.addEventListener("dblclick", defaultBorderColor);
toggleHighlightButton.addEventListener("click", verifyHiglight);

const highlightColorInput = document.querySelector(".highlight");
highlightColorInput.addEventListener("change", verifyHiglight);

const verifySortByColor = async () => {
  socket.emit("sort by color");
};

const sortByColorButton = document.querySelector(".sort-by-color");

sortByColorButton.onclick = verifySortByColor;

// setInterval(() => {
//   getList();
// },2000);

const sendMessage = (message) => {
  socket.emit("sending message", message);
};
window.addEventListener("DOMContentLoaded", (event) => {});

console.log("DOM fully loaded and parsed");
socket = io.connect();

socket.on("list", (list) => {
  getList(list);
});

socket.on("add status", (status, text) => {
  if (status === "successful") {
    console.log("add was Successful");

    addAndDisplay(text);
  } else {
    console.error("Add was NOT successful!!!");
    alert("Something went wrong. Item was not added to the list");
  }
});

socket.on("remove status", (status, ids) => {
  if (status === "successful") {
    removeSelectedItems(ids);
  } else {
    alert("REMOVE ERROR !!!");
  }
});

socket.on("highlighted", (obj) => {
  const { selectedItems, color } = obj;
  highlightSelectedItems(obj.selectedItems, obj.color);
});

socket.on("sorted alphabetically", () => {
  sortAlphabetically();
});

socket.on("sorted by color", (list) => {
  items = parseServerList(list);
  displayItems();
});

window.onload = verifyList;

window.onbeforeunload = updateLocalStorage;

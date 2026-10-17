let board = ["", "", "", "", "", "", "", "", ""]; // 9 empty squares

function resetBoard() {
  board = ["", "", "", "", "", "", "", "", ""];
}

function getBoard() {
  return board;
}

function placeMark(index, mark) {
  if (index < 0 || index >= board.length || board[index] !== "") {
    return false;
  }
  board[index] = mark;
  return true;
}

let currentPlayer = "X";
let gameFinished = false;

const winningCombos = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
];

function checkWinner() {
  for (let combo of winningCombos) {
    let a = combo[0];
    let b = combo[1];
    let c = combo[2];
    if (board[a] !== "" && board[a] === board[b] && board[a] === board[c]) {
      return true;
    }
  }
  return false;
}

function isBoardFull() {
  for (let i = 0; i < board.length; i++) {
    if (board[i] === "") {
      return false;
    }
  }
  return true;
}

function startGame() {
  resetBoard();
  currentPlayer = "X";
  gameFinished = false;
}

function playRound(index) {
  if (gameFinished) {
    return { status: "over" };
  }

  if (!placeMark(index, currentPlayer)) {
    return { status: "invalid" };
  }

  if (checkWinner()) {
    gameFinished = true;
    return { status: "win", winner: { name: currentPlayer === "X" ? "Player 1" : "Player 2", mark: currentPlayer } };
  }

  if (isBoardFull()) {
    gameFinished = true;
    return { status: "tie" };
  }

  currentPlayer = currentPlayer === "X" ? "O" : "X";
  return { status: "next", activePlayer: { name: currentPlayer === "X" ? "Player 1" : "Player 2", mark: currentPlayer } };
}

const Gameboard = {
  getBoard,
  resetBoard
};

const GameController = (() => {
  const players = {
    X: { name: "Player 1", mark: "X" },
    O: { name: "Player 2", mark: "O" }
  };

  const getActivePlayer = () => players[currentPlayer];

  const start = (name1 = "Player 1", name2 = "Player 2") => {
    players.X.name = name1;
    players.O.name = name2;
    startGame();
  };

  const playRound = (index) => {
    if (gameFinished) {
      return { status: "over" };
    }

    if (!placeMark(index, currentPlayer)) {
      return { status: "invalid" };
    }

    if (checkWinner()) {
      gameFinished = true;
      return { status: "win", winner: getActivePlayer() };
    }

    if (isBoardFull()) {
      gameFinished = true;
      return { status: "tie" };
    }

    currentPlayer = currentPlayer === "X" ? "O" : "X";
    return { status: "next", activePlayer: getActivePlayer() };
  };

  return { start, playRound, getActivePlayer };
})();

const DisplayController = (function () {
  const boardDiv = document.getElementById("board");
  const resultDiv = document.getElementById("result");
  const form = document.getElementById("player-form");

  const render = () => {
    boardDiv.innerHTML = "";
    const currentBoard = Gameboard.getBoard();

    currentBoard.forEach((mark, index) => {
      const cell = document.createElement("div");
      cell.classList.add("cell");
      cell.textContent = mark;
      cell.addEventListener("click", () => handleCellClick(index));
      boardDiv.appendChild(cell);
    });
  };

  const handleCellClick = (index) => {
    const result = GameController.playRound(index);

    if (result.status === "invalid" || result.status === "over") return;

    render();

    if (result.status === "win") {
      resultDiv.textContent = `${result.winner.name} wins!`;
    } else if (result.status === "tie") {
      resultDiv.textContent = "It's a tie!";
    } else {
      resultDiv.textContent = `${GameController.getActivePlayer().name}'s turn (${GameController.getActivePlayer().mark})`;
    }
  };

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const name1 = document.getElementById("player1-name").value;
    const name2 = document.getElementById("player2-name").value;

    GameController.start(name1, name2);
    render();
    resultDiv.textContent = `${GameController.getActivePlayer().name}'s turn (${GameController.getActivePlayer().mark})`;
  });

  const init = () => {
    GameController.start("Player 1", "Player 2");
    render();
    resultDiv.textContent = `${GameController.getActivePlayer().name}'s turn (${GameController.getActivePlayer().mark})`;
  };

  return { init };
})();

DisplayController.init();
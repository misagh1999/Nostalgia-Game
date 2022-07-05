const YOUR_OPTION = 'your_option';
const RIVAL_OPTION = 'rival_option';
const YOUR_WIN = 'your_win';
const RIVAL_WIN = 'rival_win';

const ROCK = 'rock';
const PAPER = 'paper';
const SCISSORS = 'scissors';

const hand_rock_rule = [
  {YOUR_OPTION: ROCK, RIVAL_OPTION: ROCK, YOUR_WIN: true, RIVAL_WIN: true},
  {YOUR_OPTION: PAPER, RIVAL_OPTION: PAPER, YOUR_WIN: true, RIVAL_WIN: true},
  {
    YOUR_OPTION: SCISSORS,
    RIVAL_OPTION: SCISSORS,
    YOUR_WIN: true,
    RIVAL_WIN: true
  },
  {YOUR_OPTION: PAPER, RIVAL_OPTION: ROCK, YOUR_WIN: true, RIVAL_WIN: false},
  {
    YOUR_OPTION: PAPER,
    RIVAL_OPTION: SCISSORS,
    YOUR_WIN: false,
    RIVAL_WIN: true
  },
  {YOUR_OPTION: ROCK, RIVAL_OPTION: PAPER, YOUR_WIN: false, RIVAL_WIN: true},
  {YOUR_OPTION: ROCK, RIVAL_OPTION: SCISSORS, YOUR_WIN: true, RIVAL_WIN: false},
  {YOUR_OPTION: SCISSORS, RIVAL_OPTION: ROCK, YOUR_WIN: false, RIVAL_WIN: true},
  {
    YOUR_OPTION: SCISSORS,
    RIVAL_OPTION: PAPER,
    YOUR_WIN: true,
    RIVAL_WIN: false
  },
];

# tsdbcg
[![Build Status](https://travis-ci.com/BrennanAyers/tsdbcg.svg?branch=master)](https://travis-ci.com/BrennanAyers/tsdbcg)


## Setup
- Ruby Version: 2.4.1
- Rails Version: 5.2.3
To get the TSDBCG application up and running on your local machine, start by getting the source code from this GitHub repository:
```bash
git clone git@github.com:BrennanAyers/tsdbcg.git (for SSH)
cd tsdbcg
```
TSDBCG uses the `bundler` library to manage dependencies. This process will take some time to install all of the correct versions of the libraries we use. After cloning down the repo with the above commands:
```bash
bundler install
```
We need to set up our database next, of which TSDBCG uses Postgres. We suggest using the [Brew](https://brew.sh/) command-line tool to download and control Postgres. If you already have Brew installed, follow [these steps](https://gist.github.com/ibraheem4/ce5ccd3e4d7a65589ce84f2a3b7c23a3) to initialize a Postgres environment.
After those steps, run in the TSDBCG directory:
```bash
rails db:create
rails db:migrate
rails db:seed
```
Now that our application files are sorted, and the database has pertinent information inside of it, we can start the application:
```bash
rails start
```
This will begin the server on your `localhost:`, generally on Port 3000.

# Endpoints

## POST `api/v1/games`
- This request is used to start a new Game with a single Player. The Game does not start, as it does not have the required number of Players, but others will now be able to join using the Game ID.
- Example Request:
- - `POST api/v1/games` `BODY: { newPlayer: { name: "Ted" } }`
- Example Response:
- - `Status: 201`
- - `Body: { playerName: "Ted", playerId: 1, gameId: 1 }`

## POST `api/v1/join_game`
- A POST with a Body containing my Player Name, and the Game ID Of the Game I would like to join
In the format:
```
POST /api/v1/join_game
BODY: {player_name: "George", game_id: 1}
```
successfully returns:
```
Status: 200
BODY: {
  playerName: "George",
  playerId: 2,
  gameId: 1,
  gameStatus: "Game Started"
}
```
- This endpoint starts the game, instantiating gameCards and decks for both players

## GET `api/v1/games/GAME_ID/players/PLAYER_ID`
- A GET request to obtain the status of a given Player, in a given Game. This is used to render the given Players Deck and Discard piles, and draw cards from the Deck.
- Example Request:
- - `GET api/v1/games/1/players/1`
- Example Response:
- - `Status: 200`
```
BODY: {
  playerId: 1,
  deck: {
    {
      name: "Copper",
      category: "Money",
      cost: 0,
      victoryPoints: 0,
      spendingPower: 1,
      buyingPower: 0,
      actionsProvided: 0,
      cardsToDraw: 0,
      image: "copper.jpg",
      desc: "",
      tags: []
    },
    ...
  }
  discard: {
    {
      name: "Market",
      category: "Action",
      cost: 5,
      victoryPoints: 0,
      spendingPower: 1,
      buyingPower: 1,
      actionsProvided: 1,
      cardsToDraw: 1,
      image: "market.jpg",
      desc: "",
      tags: ["+1 Card", "+1 Action", "+1 Buy", "+1 Gold"]
    },
    ...
  }
}
```

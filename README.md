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
- A POST request used to start a new Game with a single Player. The Game does not start, as it does not have the required number of Players, but others will now be able to join using the Game ID.
- Example Request:
```json
POST api/v1/games
BODY: {
  "newPlayer": {
    "name": "Ted"
    }
  }
```
- Example Response:
```json
Status: 201
BODY: {
  "playerName": "Ted",
  "playerId": 1,
  "gameId": 1
}
```

## POST `api/v1/join_game`
- A POST request with a Body containing a Player name, and the Game ID of the Game the Player would like to join. Upon all Players required joining a Game, all GameCards for both the board, and all Players will be created and assigned to their respective areas.
Example Request:
```json
POST /api/v1/join_game
BODY: {
  "playerName": "George",
  "gameId": 1
}
```
Example Response:
```json
Status: 200
BODY: {
  "playerName": "George",
  "playerId": 2,
  "gameId": 1,
  "gameStatus": "Game Started"
}
```

## GET `api/v1/games/GAME_ID/players/PLAYER_ID`
- A GET request to obtain the status of a given Player, in a given Game. This is used to render the given Players Deck and Discard piles, and draw cards from the Deck.
- Example Request:
```json
GET api/v1/games/1/players/1
```
- Example Response:
```json
Status: 200
BODY: {
  "playerId": 1,
  "deck": [
    {
      "name": "Copper",
      "category": "Money",
      "cost": 0,
      "victoryPoints": 0,
      "spendingPower": 1,
      "buyingPower": 0,
      "actionsProvided": 0,
      "cardsToDraw": 0,
      "image": "copper.jpg",
      "desc": "",
      "tags": []
    },
    ...
  ],
  "discard": [
    {
      "name": "Market",
      "category": "Action",
      "cost": 5,
      "victoryPoints": 0,
      "spendingPower": 1,
      "buyingPower": 1,
      "actionsProvided": 1,
      "cardsToDraw": 1,
      "image": "market.jpg",
      "desc": "",
      "tags": ["+1 Card", "+1 Action", "+1 Buy", "+1 Gold"]
    },
    ...
  ]
}
```


## POST `api/v1/endturn`
- A POST request to indicate the end of a specific Players turn, and send all pertinent information to be updated. This includes their Deck Cards, their Discard Cards, and any Cards they bought during the course of their turn. Deck and Discard Cards are sent as an Array of Card ID's, indicating the order of Cards to be drawn next turn, and in which order they should appear in the Discard pile.
- Example Request:
```json
POST api/v1/endturn
BODY: {
  "gameId": 123,
  "playerId": 234,
  "deck": [ 5, 2, 7, 11, 10 ],
  "bought": [ 12, 13 ],
  "discard": [ 3, 1, 9, 4, 8, 6, 12, 13 ]
}
```
- Example Response:
```json
Status: XXX
BODY: To Be Determined
```

## GET `api/v1/game_state/GAME_ID`
- A GET request used to query the current Game state. This endpoint returns all publicly available information, such as all Action Cards, purchasable Money and Victory Cards, the Player turn order, Players current hand sizes, current most recent discarded Card, and all information to render the cards themselves.
- Example Request:
```json
GET api/v1/game_state/1
```
- Example Response:
```json
Status: 200
BODY: {
  "tableDeck": [
    {
      "name": "Gold",
      "category": ["Money"],
      "cost": 6,
      "victoryPoints": null,
      "spendingPower": 3,
      "buyingPower": 0,
      "actionsProvided": 3,
      "cardsToDraw": 0,
      "image": "./gold.jpg",
      "desc": "",
      "tags": [],
      "countAvailable": 5,
      "id_list": [ 1011, 1012, 1013, 1014, 1015 ]
    },
    {
      "name": "Estate",
      "category": ["Victory"],
      "cost": 2,
      "victoryPoints": 1,
      "spendingPower": null,
      "buyingPower": 0,
      "actionsProvided": null,
      "cardsToDraw": 0,
      "image": "./estate.jpg",
      "desc": "",
      "tags": [],
      "countAvailable": 8,
      "id_list": [ 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048]
    },
    ...
  ],
  "playerOrder": [ "Player_1_Name", "Player_2_Name" ],
  "playerInfo": {
    "Player_1_Name": {
      "deckSize": 10,
      "topCardDiscard": null,
      "handSize": 5
    },
    "Player_2_Name": {
      "deckSize": 10,
      "topCardDiscard": null,
      "handSize": 5
    }
  }
}
```

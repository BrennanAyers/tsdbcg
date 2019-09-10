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


## POST `api/v1/endturn`
This is the endpoint that is hit at the end of the turn to update a players deck/discard and the tableDeck.
A POST request in the format:
```
POST api/v1/endturn
Body:
{
gameId: 123,
playerId: 234
deck: [ ordered array cards ids],
bought: [array ids ]
discard: [ordered array card ids]
}
```
- Updates a players deck order based on order of cardIds in array
- Updates a players discard order based on order of cardIds in array
- Successfully returns  a 200

## GET `api/v1/game_state/<game_id>`
- This request is used to query the current game state, where <game_id> is the ID of the game object stored in the database. This endpoint returns all publicly available information, such as all kingdom cards, the player order and current hand sizes and discarded card, and information to render the cards themselves.
- Example Request:
- - `get api/v1/game_state/1` - Returns the game state for game ID of 1.
- Example Response:
- - `Status: 200`
-  
~~~~
  Body:
  {
    "tableDeck":
    [
      {
        "name":"Gold",
        "category":["Money"],
        "cost":6,
        "victoryPoints":null,
        "spendingPower":3,
        "buyingPower":0,
        "actionsProvided":3,
        "cardsToDraw":0,
        "image":"./gold.jpg",
        "desc":"",
        "tags":[],
        "countAvailable":5,
        "id_list":[1011,1012,1013,1014,1015]
      },
      {
        "name":"Estate",
        "category":["Victory"],
        "cost":2,
        "victoryPoints":1,
        "spendingPower":null,
        "buyingPower":0,
        "actionsProvided":null,
        "cardsToDraw":0,
        "image":"./estate.jpg",
        "desc":"",
        "tags":[],
        "countAvailable":8,
        "id_list":[1041,1042,1043,1044,1045,1046,1047,1048]
      }
    ],
    "playerOrder":["Player_1_Name","Player_2_Name"],
    "playerInfo":{
    "Player_1_Name":
      {
      "deckSize":10,
      "topCardDiscard":null,
      "handSize":5
      }
    },
    "Player_2_Name":
      {
      "deckSize":10,
      "topCardDiscard":null,
      "handSize":5
      }
    }
  }
  ~~~~

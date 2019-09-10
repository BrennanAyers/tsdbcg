# tsdbcg
[![Build Status](https://travis-ci.com/BrennanAyers/tsdbcg.svg?branch=master)](https://travis-ci.com/BrennanAyers/tsdbcg)


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

## GET `api/v1/game_state/<game_id>`
- This request is used to query the current game state, where <game_id> is the ID of the game object stored in the database. This endpoint returns all publicly available information, such as all kingdom cards, the player order and current hand sizes and discarded card, and information to render the cards themselves.
- Example Request:
- - `get api/v1/game_state/1` - Returns the game state for game ID of 1.
- Example Response:
- - `Status: 200`
-  ~~~~
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
    "playerOrder":["Player_1_Name"],
    "playerInfo":{
    "MyString":
      {
      "deckSize":10,
      "topCardDiscard":null,
      "handSize":5
      }
    }
  }

# tsdbcg


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
## POST `api/v1/games/:id/buy_card`
This endpont allows a player in a game to but a card for that case. A POST with the body
```
{
  buy_info: {
    player_id: id,
    bought: {
      "Gold" => 1,
      "Estate" => 1
    }
  }
}
```

successfully returns 
```
{
  player_name: name,
  bought: {
    "Gold" => 1,
    "Estate" => 1
  }
}
```
This post updates the cards in this players deck by setting the corresponding GameCard's player_id field to this player's id and discarded field to true, effectively adding it to this players discard.

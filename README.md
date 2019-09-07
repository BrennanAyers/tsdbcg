# Endpoints
## Get `api/v1/gamestate/:game_id`

Successfully returns a list of all cards as an array of objects. Empty values are returned as nil. in the format
```
{
    name: "Copper",
    category: "Money",
    cost: 0,
    victoryPoints: nil,
    spendingPower: 1,
    numberAvailable: 47
    id: 1113
  },
  {
    name: "Estate",
    category: ["Victory"],
    cost: 2,
    spendingPower: nil,
    victoryPoints: 1,
    numberAvailable: 7
    id: 6123
  }]

```


# Accession Server
### A deck building card game backend using Ruby on Rails to handle game state for the React frontend pair application.
[![Build Status](https://travis-ci.com/BrennanAyers/tsdbcg.svg?branch=master)](https://travis-ci.com/BrennanAyers/tsdbcg)

## About
This is the server side component to the deck building card game of Accession. This application is one half of the Accession game, and is required to generate games and manage game state. The general principles of Accession are...
- Deck building card games start with each player having the same collection of cards, who then buy cards from a central pool and build a deck to gain victory points and win the game. Accession is a base implementation of this style of game, with plans for expansion in the future. The full set of rules can be found at the bottom of this documentation.

## Hosted Version
A live version of this application can be accessed via https://accession-game-server.herokuapp.com/ using our endpoints below! If you would like to run your own local version, follow the instructions that follow.

## Setup
### Requirements
- Brew Package Manager
- Git
- PostgreSQL
- Ruby Version: `2.4.1`
- Rails Version: `5.2.3`

<details><summary><b>Brew Installation</b></summary>
<p>

[Brew](https://brew.sh/) is a package manager for Mac OS (or Linux) that allows us to install libraries using easy and convenient terminal commands. We need Brew to install later required elements of the Accession Server. To install Brew on a Mac OS machine, run in your terminal:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
For Linux instructions, refer [here](https://docs.brew.sh/Homebrew-on-Linux).
</p>
</details>

<details><summary><b>Git Installation</b></summary>
<p>

If you're on GitHub, you're halfway to knowing what Git is! Git is a 'version control system' that tracks changes to code, stored in what is generally called a 'repository'. GitHub is a remote hosting service of these repositories, and you're looking at one right now!
There are many ways to install and use Git:
- Brew `brew install git`
- [Desktop Client](https://desktop.github.com/)
- [Installable Source](https://git-scm.com/downloads) for Mac, Windows, Linux
- - Further instructions [here](https://help.github.com/en/articles/setting-your-username-in-git) and [here](https://help.github.com/en/articles/setting-your-commit-email-address)
</p>
</details>

<details><summary><b>Rbenv Installation</b></summary>
<p>

[rbenv](https://github.com/rbenv/rbenv) is an environment manager for the Ruby language that allows us to install and control multiple versions of Ruby on our computer. We can use Brew to install rbenv in our terminal:
```bash
brew install rbenv
rbenv init
```
The terminal will now instruct you to input some shortcuts for rbenv in your `~/.bash_profile`:
- `nano ~/.bash_profile` (or your preferred command line text editor)
- CMD+V/CTRL-V `eval "$(rbenv init -)"` - to paste the shortcut
- CTRL+X - to quit Nano
- Y - to save the file
- `source ~/.bash_profile`
- `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash`
- The last command will determine if your rbenv setup was successful. If you run into issues installing rbenv, I would suggest checking out their [issues board](https://github.com/rbenv/rbenv/issues), or Googling any specific errors on Google.
- If you are unable to use Brew, refer to [this section](https://github.com/rbenv/rbenv#basic-github-checkout) of the rbenv documentation.
</p>
</details>

<details><summary><b>PostgreSQL Installation</b></summary>
<p>

[Postgres](https://en.wikipedia.org/wiki/PostgreSQL) is a relational database management system that we use to store information in the Accession Server. All of the set up will be handled by Rails once we get to that step, but Postgres does need to be installed for that to happen. We highly suggest using Brew for this part of the process, but in the situation where Brew is not available, [these](https://www.postgresql.org/docs/current/install-getsource.html) are the instructions.
- For a Brew installation:
```bash
brew install postgresql
brew services start postgresql
psql postgres
```
</p>
</details>

- All below commands are to be run in your terminal or command line of choice.

To get the the Accession Server application up and running on your local machine, start by getting the source code from this GitHub repository:
```bash
git clone git@github.com:BrennanAyers/tsdbcg.git (for SSH)
cd tsdbcg
```
The Accession Server uses the `bundler` library to manage dependencies. This process will take some time to install all of the correct versions of the libraries we use. After cloning down the repo with the above commands:
```bash
bundler install
```
After Bundler installs all required packages, run in the the Accession Server directory:
```bash
rails db:create
rails db:migrate
rails db:seed
```
Now that our application files are sorted, and the database has pertinent information inside of it, we can start the application:
```bash
rails server
```
This will begin the server on your `localhost:`, generally on Port 3000. Now that that you have the game server up and running, you can interact with it through the Endpoints below, or install our UI application from [here](https://github.com/KevinKra/Dominion_fe)!

## Endpoints

### POST `api/v1/games`
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

### POST `api/v1/join_game`
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

### GET `api/v1/game_state/GAME_ID`
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
      "victoryPoints": 0,
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
      "spendingPower": 0,
      "buyingPower": 0,
      "actionsProvided": 0,
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
      "topCardDiscard": 0,
      "handSize": 5
    },
    "Player_2_Name": {
      "deckSize": 10,
      "topCardDiscard": 0,
      "handSize": 5
    }
  },
  "activePlayerName": "Player_1_Name",
  "activePlayerId": 1
}
```

### GET `api/v1/games/GAME_ID/players/PLAYER_ID`
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

### POST `api/v1/endturn`
- A POST request to indicate the end of a specific Players turn, and send all pertinent information to be updated. This includes their Deck Cards, their Discard Cards, and any Cards they bought during the course of their turn. Deck and Discard Cards are sent as an Array of Card ID's, indicating the order of Cards to be drawn next turn, and in which order they should appear in the Discard pile. On a successful request, the Game turn counter will be advanced, moving from the current Player to the next in the queue.
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
Status: 200
BODY: {
  "Message": "Player Tom turn ended"
}
```

## Testing
- Because the Accession Server is built using Rails, the project is set up for testing using the RSpec framework with its robust Rails integration. All tests written are setup inside the spec, there are no required seeds or files to run our test suite.
- The Accession Server uses SimpleCov to track test coverage on our code. The `coverage` folder that SimpleCov generates is in `.gitignore`, but you should still be able to check coverage by opening the `index.html` files after running the test suite. Code coverage is currently at 100%, so any further contributions should follow this lead.
- To run all of our specs using RSpec, in the terminal: `rspec` or `bundle exec rspec`

## Contributors
Accession was a collaboration between students in the Backend and Frontend programs at the [Turing School of Software and Design](http://turing.io) in Denver, Colorado. Everything was planned, programmed, and deployed in 13 days as our last project before graduation. Contributors are as follows:
#### Backend
- [Brennan Ayers](https://github.com/BrennanAyers)
- [Patrick Duvall](https://github.com/Patrick-Duvall)
- [Chris Davis](https://github.com/DavisC0801)
#### Frontend
- [Kevin Krato](https://github.com/KevinKra)
- [Vinton T'eo](https://github.com/vjt960)
#### Learning Goals
- Apply Backend and Frontend teams into one application
- Use professional workflow techniques (Agile, CI/CD) to create quality code
- Push ourselves outside of our comfort zone by creating a synchronous game with web technologies

## Game Rules
<details>
<summary><b>How To Play</b></summary>
<br>
<details>
<summary><b>Introduction</b></summary>
<br>
You are a monarch, like your parents before you - a ruler of a small pleasant kingdom of rivers and evergreens. Unlike your parents, however, you have hopes...dreams! You want a bigger and more pleasant kingdom, with more rivers, and a wider variety of trees. You want a Accession! In all directions lie fiefs, freeholds, and feodums - all small bits of land, controlled by petty lords and verging on anarchy. You will bring civilization to these unfortunates, uniting them under your banner.
<br><br>
But wait. It must be something in the air; several other monarchs have had the exact same idea. You must race to get as much of the unclaimed land as possible while you can, fending them off along the way. To do this you will hire minions, construct buildings, spruce up your castle, and fill the coffers of your treasury. Your parents wouldn't be proud, but your grandparents, on your mother's side, would be delighted.
<br><br>
This is a game of building a deck of cards. The deck represents your Accession. It contains your resources, victory points, and the things you can do. It starts out a small sad collection of Estates and Coppers, but you hope that by the end of the game it will be brimming with Gold, Provinces, and the inhabitants and structures of your castle and kingdom. You win by having the most Victory Points in your deck when the game ends.
</details>
<details>
<summary><b>Overview</b></summary>
<br>
Accession is a game of building a deck of cards. Each player has their own deck, their own discard pile, their own hand of cards and play area. Players start with a weak initial deck and gradually acquire better cards over the course of the game.
<br><br>
Players take turns. Each turn has three phases: Action, then Buy, then Clean-up, which you can remember as ABC. In the Action phase, you can play one Action card from your hand; in the Buy phase, you can play any number of Treasure cards and then buy one card to add to your deck; and in Clean-up you sweep up all of your cards from play and from your hand and discard them, then draw a new hand of 5 cards, shuffling as needed.
<br><br>
The game ends after 3 kingdom piles are empty or the Province pile is empty.
</details>
<details>
<summary><b>Action Phase</b></summary>
<br>
In your Action phase, you can play one Action card from your hand. Those are cards that say "Action" on the bottom, and by default have a white banner (some are other colors due to additional types). Playing an Action card has three steps: announcing it; moving it to the "in play" area - the table space in front of you; and following the instructions on it, in order, top to bottom. If the card has a dividing line (e.g. Moat), you stop there; instructions below the line happen at some other time (indicated). If you cannot do everything a card tells you to do, you do as much as you can; you can still play a card even if you know you will not be able to do everything it tells you to.
<br><br>
Some cards give "+1 Action." This increases how many Action cards you can play in a turn. The increase happens right then, but you do not play the next Action card until completely finishing the first one. Some cards give "+2 Actions"; that means you can play two more Action cards that turn.
So, for example, if you play Militia, which does not give +Actions, you resolve Militia and are done with your Action phase. But you could instead play a Market, then another Market, then a Militia; each Market gives you +1 Action, which lets you keep playing Actions.
<br><br>
Using up your Actions is optional; you can have an Action card left in hand that you can play, and decide not to play it.
</details>
<details>
<summary><b>Buy Phase</b></summary>
<br>
First you can play any number of Treasure cards from your hand, in any order. Treasure cards say "Treasure" on the bottom and have a yellow banner. You play one by moving it to the "in play" area; you probably will not announce your Treasures, though you can if you want. The Treasures have no text, just a big coin with a number on it. You get that many coins to spend this turn - one coin for a Copper, two for a Silver, three for a Gold, indicated on the card. You do not have to play every Treasure in your hand (but only get this turn for the Treasures you play).
<br><br>
Then, you can buy one card, costing as many coins as you have or less. Costs are indicated in the lower left corner of cards. You buy a card by choosing it from the Supply, and then "gaining" it. "Gaining" a card means moving it from the Supply to your discard pile. Your total amount of coins available to spend goes down by the cost of the card. For example if you played four Coppers and a Silver, that makes 6 coins total; if you bought a Market, that costs 5 coins, so you would move a Market from the Supply to your discard pile and have 1 coin left.
<br><br>
Buying cards does not use up Treasure cards; you still have the cards. The Treasures produce income usable every time you draw them. Buying cards just uses up the coins you have available this turn.
Some cards give "+1 Buy." This increases how many cards you can buy in a turn in your Buy phase. For example with 6 coins and an extra Buy, you could buy two Silvers, which each cost 3 coins. Using up your Buys is optional. You can have two Buys but just buy one card, or skip buying entirely. As Copper costs   0 coins, you could use a Buy with no coins to buy a Copper.
<br><br>
You cannot go back and play more Treasures after buying a card; first play Treasures, then buy.
</details>
<details>
<summary><b>Clean-up Phase</b></summary>
<br>
Take all of the cards you have in play (both Actions and Treasures), and any remaining cards in your hand, and put them all into your discard pile. The order does not matter; you can hide the cards from your hand under the played cards if you want to.
<br><br>
Draw a new hand of 5 cards. If your deck has fewer than 5 cards, first shuffle your discard pile and put it under your deck, then draw.
<br><br>
Play passes to the player to your left. Any unused +Actions, unused +Buys, or unspent coins that you had left are gone; you start each turn fresh.
</details>
<details>
<summary><b>Game End</b></summary>
<br>
The game ends at the end of a turn, if either the Province pile is empty, or any three or more Supply piles are empty (any piles at all, including Kingdom cards, Copper, etc.).
<br><br>
Take all of your cards - from your hand, deck, discard pile, play area, and even set aside cards - and sort them for putting them back in their piles. Count up your Victory Points.
<br><br>
The player with the most Victory Points wins. If players tie for Victory Points, a player who tied but had fewer turns wins. If players tie and had the same number of turns, they rejoice in their shared victory.
</details>
<details>
<summary><b>Card Reference</b></summary>
<br>
<b>Cellar:</b> Choose any number of cards from your hand; discard them all at once; then draw as many cards as you actually discarded. If this causes you to shuffle, you will shuffle in the cards you discarded. You do not have to let players see any but the top card discarded; however the number of cards you discard is public.
<br><br>
<b>Market:</b> You draw a card and get +1 Action, +1 Coin, and +1 Buy.
<br><br>
<b>Militia:</b> Players with 3 or fewer cards in hand do not discard any cards. Players with more cards discard until they only have 3.
<br><br>
<b>Mine:</b> You can, for example, trash a Copper to gain a Silver, or trash a Silver to gain a Gold. The Treasure you gain comes from the Supply and is put into your hand; you can play it for coins the same turn. If you do not have a Treasure to trash, you do not gain one.
<br><br>
<b>Moat:</b> An Attack card says "Attack" on the bottom line; in this set Militia are Attacks. When another player plays an Attack card, you may reveal a Moat from your hand, before the Attack does anything, to be unaffected by the Attack - you do not discard for Militia. Moat stays in your hand, and can still be played on your next turn. Moat does not stop anything an Attack does to other players, or for the player who played it; it just protects you personally. Moat can also be played on your turn for +2 Cards. If multiple Attacks are played on a turn or in a round of turns, you may reveal Moat for as many of them as you want.
<br><br>
<b>Remodel:</b> You cannot trash the Remodel itself, since it is not in your hand after you play it. If you do not have a card to trash, you do not gain one. If you do gain a card, it comes from the Supply and is put into your discard pile. The gained card does not need to cost exactly 2 coins more than the trashed card; it can cost that much or less, and can even be another copy of the trashed card. You cannot use coins to increase how expensive of a card you gain.
<br><br>
<b>Smithy:</b> You draw 3 cards.
<br><br>
<b>Village:</b> You draw a card and get +2 Actions.
<br><br>
<b>Woodcutter:</b> You get +2 Coins, and +1 Buy.
<br><br>
<b>Workshop:</b> The card you gain comes from the Supply and is put into your discard pile. You cannot use coins to increase how expensive of a card you gain; it always costs from 0 coins to 4 coins.
</details>
<details><summary><b>Rules Credits</b></summary>
Thank you to Donald X. Vaccarino and Rio Grande Games for making the original Dominion game!
</details>
</details>

# tsdbcg
A Deck Building Card Game built using X and Y working with A to Z.

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

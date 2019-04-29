<%-- 
    Document   : lobby
    Created on : 30 mars 2019, 15:41:32
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mahjong lobby</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    </head>
    <body>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                var handle = $("#discardTime-handle");
                $("#discardTimeSlider").slider({
                    min: 5,
                    max: 60,
                    create: function () {
                        handle.text($(this).slider("value"));
                    },
                    slide: function (event, ui) {
                        handle.text(ui.value);
                    }
                });

                var handlee = $("#pickTime-handle");
                $("#pickTimeSlider").slider({
                    min: 5,
                    max: 60,
                    create: function () {
                        handlee.text($(this).slider("value"));
                    },
                    slide: function (event, ui) {
                        handlee.text(ui.value);
                    }
                });
            });
        </script>

        <a href="/accueil"><i id="homeIcon" class="fas fa-sign-out-alt fa-5x"></i></a>

        <h1 id="title">${lobby.getName()}</h1>
        <h4>The Id of the Lobby :</h4> 
        <h4> ${lobby.getUUID().toString()}</h4>
        <div id="lobby">
            <div id="topArea">
                <div id="players">
                    <div id="player1">
                        <input class="playerName" type="text" name="player1" value=${lobby.getOwner().getName()} disabled>
                        <i class="fas fa-crown"></i>
                    </div>
                    <div id="player2">
                        ${lobby.getPlayers()[1]!=null && playerId.equals(lobby.getOwner().getUUID().toString())? "<button id='1' class='removeBotButton'>X</button>" :"" }
                        <input class="playerName" type="text" name="player2" value="${lobby.getPlayers()[1].getName()}" disabled>
                        ${lobby.getNumberOfPlayers()==1 && playerId.equals(lobby.getOwner().getUUID().toString()) ? '<button class="addBotButton">Add a bot</button>
                          <select id="botDifficulty" class="difficultyBot">
                          <option>SILLY</option>
                          <option>EASY</option>                              
                          </select>' : ""}
                    </div>
                    <div id="player3">
                        ${lobby.getPlayers()[2]!=null && playerId.equals(lobby.getOwner().getUUID().toString()) ? "<button id='2' class=removeBotButton>X</button>" :"" }
                        <input class="playerName" type="text" name="player3" value="${lobby.getPlayers()[2].getName()}" disabled>
                        ${lobby.getNumberOfPlayers()==2 && playerId.equals(lobby.getOwner().getUUID().toString())? '<button class="addBotButton">Add a bot</button>
                          <select id="botDifficulty" class="difficultyBot">
                          <option>SILLY</option>
                          <option>EASY</option>                          
                          </select>' : ""}
                    </div>
                    <div id="player4">
                        ${lobby.getPlayers()[3]!=null && playerId.equals(lobby.getOwner().getUUID().toString())? "<button id='3' class=removeBotButton>X</button>" :"" }
                        <input class="playerName" type="text" name="player3" value="${lobby.getPlayers()[3].getName()}" disabled>
                        ${lobby.getNumberOfPlayers()==3 && playerId.equals(lobby.getOwner().getUUID().toString()) ? '<button class="addBotButton">Add a bot</button>
                          <select id="botDifficulty" class="difficultyBot">
                          <option>SILLY</option>
                          <option>EASY</option>     
                          </select>' : ""}
                    </div>
                </div>
                <div id="lobbyParameters">
                    <select  ${playerId.equals(lobby.getOwner().getUUID().toString()) ? "" : "disabled"} class="lobbyParameter" id="visibilitySettings">
                        <option>Public</option>
                        <option ${!lobby.isVisible() ? "selected" : ""}>Private</option>
                    </select>
                    <!--TODO Attendre que description fonctionne-->
                    <input class="lobbyParameter" type="text" value=${lobby.getRule().getName()} disabled>
                    <h3>Choose the time to discard</h3>
                    <div>
                        <div style="text-align: center;">${lobby.getPlayTime()}</div>
                    </div>
                    <h3>Choose the time to pick a tiles from the discard area</h3>
                    <div>
                        <div style="text-align: center;">${lobby.getStealTime()}</div>
                    </div>
                </div>
            </div>
            <div id="centerButton">
                <p>${ownerUUID}</p>
                <a id="launchGameButton"><button ${lobby.getNumberOfPlayers()==4 && playerId.equals(lobby.getOwner().getUUID().toString()) && nbReadyPlayers==4 ? "" : "disabled"} id="launchButton">Launch</button></a>
                <button id="readyButton">Ready (${nbReadyPlayers}/${lobby.getNumberOfPlayers()})</button>
            </div>
        </div>
    </body>

    <script>
         setTimeout(function () {
         window.location.reload();
         }, 4000);
         
        let addBotButtons = document.getElementsByClassName("addBotButton");
        let removeBotButtons = document.getElementsByClassName("removeBotButton");
        let difficulties = document.getElementsByClassName("difficulty");
        let launchButton = document.getElementById("launchGameButton");
        let readyButton = document.getElementById("readyButton");
        let visibilitySettings = document.getElementById("visibilitySettings");

        visibilitySettings.onchange = function () {
            let Http = new XMLHttpRequest();
            let url = '/lobby?action=changeVisibility&lobbyId=${lobby.getUUID()}&playerId=' + "${playerId}";
            Http.open("POST", url, true);
            Http.onreadystatechange = (e) => {
                console.log(e);
            };
            Http.send();
        };

        readyButton.onclick = function () {
            let Http = new XMLHttpRequest();
            let url = '/lobby?action=setReady&lobbyId=${lobby.getUUID()}&playerId=' + "${playerId}";
            Http.open("POST", url, true);
            Http.onreadystatechange = (e) => {
                console.log(e);
                window.location.reload();
            };
            Http.send();
        };

        launchButton.onclick = function () {
            let Http = new XMLHttpRequest();
            let url = '/lobby?action=launchGame&lobbyId=${lobby.getUUID()}&playerId=' + '${playerId}';
            Http.open("POST", url, true);
            Http.onreadystatechange = (e) => {
                console.log(e);
            };
            Http.send();
        };

        for (button in addBotButtons) {
            addBotButtons[button].onclick = function () {
                let botDifficulty = document.getElementById("botDifficulty").value;
                let Http = new XMLHttpRequest();
                let url = '/lobby?lobbyId=${lobby.getUUID()}&action=addBot&playerId=' + "${playerId}" + "&botDifficulty=" + botDifficulty;
                Http.open("POST", url, true);
                Http.onreadystatechange = (e) => {
                    window.location.reload();
                };
                Http.send();
            };
        }
        ;
        let index = 0;
        for (button in removeBotButtons) {
            removeBotButtons[button].onclick = function () {
                let Http = new XMLHttpRequest();
                index = button;
                let url = '/lobby?lobbyId=${lobby.getUUID()}&action=removePlayer&idPlayer=' + this.id + '&playerId=' + '${playerId}';
                console.log(url);
                Http.open("POST", url, true);
                Http.onreadystatechange = (e) => {
                    console.log(e);
                    window.location.reload();
                };
                Http.send();
            };
        }
        ;


    </script>
    <style>

        a{
            color: black;
        }

        #homeIcon {
            position: absolute;
            left: 10px;
            top: 10px;
        }

        #title{
            display: absolute;
            text-align: center;
            margin-top: 17vh;
        }

        #lobby{
            position: absolute;
            top: 50vh;
            left: 50vw;
            transform:translate(-50%, -50%);
        }

        #topArea{
            display: grid;
            grid-template-columns: 30vw;
            margin-bottom: 5vh;
            margin-top: 5vh;
        }

        .playerName,.lobbyParameter{
            margin-top: 5px;
            margin-bottom: 5px;
            width: 15vw;
            height: 5vh;
            text-align: center;
        }

        #players{
            grid-column: 1;
        }

        #lobbyParameters{
            grid-column: 2;
            display: flex;
            flex-direction: column;
        }

        #visibility{
            text-align: center;
        }


        #readyArea{
            grid-column: 2;
            margin-left: 1vw;
            margin-top: 3vh;
            width: 8vw;
        }

        #centerButton{
            text-align: center;
        }

        #launchButton{
            margin-top: 5vh;
            width: 15vw;
            height: 5vh;
        }

        #discardTime-handle, #pickTime-handle {
            width: 3em;
            height: 1.6em;
            top: 50%;
            margin-top: -.8em;
            text-align: center;
            line-height: 1.6em;
        }
    </style>
</html>

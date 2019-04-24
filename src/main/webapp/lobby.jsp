<%-- 
    Document   : lobby
    Created on : 30 mars 2019, 15:41:32
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Display Parameters Mahjong</title>
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
        <%@ include file="buttons.jsp" %>

        <h1 id="title">${lobby.getName()}</h1>

        <div id="lobby">
            <div id="topArea">
                <div id="players">
                    <div id="player1">
                        <input class="playerName" type="text" name="player1" value=${lobby.getOwner().getName()} disabled>
                        <i class="fas fa-crown"></i>
                    </div>
                    <div id="player2">
                        ${lobby.getPlayers()[1]!=null && ownerUUID.equals(lobby.getOwner().getUUID())? "<button id='1' class='removeBotButton'>X</button>" :"" }
                        <input class="playerName" type="text" name="player2" value="${lobby.getPlayers()[1].getName()}" disabled>
                        ${lobby.getNumberOfPlayer()==1 && ownerUUID.equals(lobby.getOwner().getUUID()) ? '<button class="addBotButton">Add a bot</button>
                          <select class="difficultyBot">
                          <option>SILLY</option>
                          </select>' : ""}
                    </div>
                    <div id="player3">
                        ${lobby.getPlayers()[2]!=null && ownerUUID.equals(lobby.getOwner().getUUID()) ? "<button id='2' class=removeBotButton>X</button>" :"" }
                        <input class="playerName" type="text" name="player3" value="${lobby.getPlayers()[2].getName()}" disabled>
                        ${lobby.getNumberOfPlayer()==2 && ownerUUID.equals(lobby.getOwner().getUUID())? '<button class="addBotButton">Add a bot</button>
                          <select class="difficultyBot">
                          <option>SILLY</option>
                          </select>' : ""}

                    </div>
                    <div id="player4">
                        ${lobby.getPlayers()[3]!=null && ownerUUID.equals(lobby.getOwner().getUUID())? "<button id='3' class=removeBotButton>X</button>" :"" }
                        <input class="playerName" type="text" name="player3" value="${lobby.getPlayers()[3].getName()}" disabled>
                        ${lobby.getNumberOfPlayer()==3 && ownerUUID.equals(lobby.getOwner().getUUID()) ? '<button class="addBotButton">Add a bot</button>
                          <select class="difficultyBot">
                          <option>SILLY</option>
                          </select>' : ""}
                    </div>
                </div>
                <script>console.log("${lobby.isVisible()}");</script>
                <div id="lobbyParameters">
                    <select class="lobbyParameter" id="visibility">
                        <option>Public</option>
                        <option ${!lobby.isVisible() ? "selected" : ""}>Private</option>
                    </select>
                    <input class="lobbyParameter" type="text" value=${lobby.getRule().getDescription()} disabled>
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
                <a href="/game?lobbyId=${lobby.getUUID()}"><button ${lobby.getNumberOfPlayer()==4 && ownerUUID.equals(lobby.getOwner().getUUID()) && nbReadyPlayers==4 ? "" : "disabled"} id="launchButton">Launch</button></a>
                <button id="readyButton">Ready (${nbReadyPlayers}/${lobby.getNumberOfPlayer()})</button>
            </div>
        </div>
    </body>

    <script>

        let addBotButtons = document.getElementsByClassName("addBotButton");
        let removeBotButtons = document.getElementsByClassName("removeBotButton");
        let difficulties = document.getElementsByClassName("difficulty");

        let readyButton = document.getElementById("readyButton");
        for (button in addBotButtons) {
            addBotButtons[button].onclick = function () {
                let Http = new XMLHttpRequest();
                let url = '/lobby?lobby=${lobby}&action=addBot';
                Http.open("POST", url, true);
                Http.onreadystatechange = (e) => {
                    console.log(e);
                    window.location.reload();
                };
                Http.send();
            };
        }
        ;
        let index=0;
        for (button in removeBotButtons) {
            removeBotButtons[button].onclick = function () {
                let Http = new XMLHttpRequest();
                index=button;
                let url = '/lobby?lobby=${lobby}&action=removePlayer&idPlayer='+this.id;
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
        #parametersIcon {
            position: absolute;
            right: 10px;
            top: 10px;
        }

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

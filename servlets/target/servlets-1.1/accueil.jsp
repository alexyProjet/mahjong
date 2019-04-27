<%-- 
    Document   : accueil
    Created on : 30 mars 2019, 00:05:52
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Menu Mahjong</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link rel="stylesheet" href="menu.css" >
    </head>
    <body>
        <a href="displayParameters.html"><i id="parametersIcon" class="fas fa-cog fa-5x"></i></a>
        <h1 id="title">Mahjong Online</h1>
        <div id="menu">
            <a id="createLobbyButton" href="/createLobby"><button class="menuButton">Create Lobby</button></a>
            <a id="joinLobbyButton" href="/joinLobby"><button class="menuButton">Join Public Lobby</button></a>
            <a id="joinPrivateLobbyButton" href="/joinPrivateLobby"><button class="menuButton">Join Private Lobby</button></a>
            <a id="launchTutoButton" href="/game?tuto=true&playerName="><button class="menuButton">Tutorial</button></a>
            <a id="creditsButton" href="/credits"><button class="menuButton">Credits</button></a>
        </div>
        <script>
            (function(){
                document.getElementById("launchTutoButton").href+=localStorage.getItem("playerName");
            })();
            
            if (localStorage.getItem("playerName") == null) {
                /*
                console.log("oui");
                window.location.href = "/createPlayer?playerName=" + playerName;
                */
                let playerName = prompt("Hey ! what's your name ?");
                localStorage.setItem("playerName",playerName);
                document.getElementById("launchTutoButton").href+=localStorage.getItem("playerName");
            }
        </script>
    </body>
    <style>

        #parametersIcon {
            position: absolute;
            right: 10px;
            top: 10px;
        }

        a{
            color: black
        }

        #menu{
            position: absolute;
            display: flex;
            flex-direction: column;
            top: 50vh;
            left: 50vw;
            transform:translate(-50%, -50%);
        }

        .menuButton{
            margin: 10px;
            height: 7vh;
            width: 20vw;
        }

        #title{
            display: absolute;
            text-align: center;
            margin-top: 17vh;

        }

    </style>
</html>

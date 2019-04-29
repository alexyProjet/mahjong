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
        <link rel="stylesheet" href="menu.css">
    </head>
    <body>
        <a href="/displayParameters"><i id="parametersIcon" class="fas fa-cog fa-5x"></i></a>
        <img id="title" src="./buttonsSVG/MahjongButton.svg">
        <div id="menu">
            <a id="createLobbyButton" href="/createLobby"><img class="menuButton" src="./buttonsSVG/CreateLobbyButton.svg"></a>
            <a id="joinLobbyButton" href="/joinLobby"><img class="menuButton" src="./buttonsSVG/JoinPublicLobbyButton.svg"></a>
            <a id="joinPrivateLobbyButton" href="/joinPrivateLobby"><img class="menuButton" src="./buttonsSVG/JoinPrivateLobbyButton.svg"></a>
            <a id="launchTutoButton" href="/game?tuto=true&playerName="><img class="menuButton" src="./buttonsSVG/TutorialButton.svg"></a>
            <a id="creditsButton" href="/credits"><img class="menuButton" src="./buttonsSVG/CreditsButton.svg"></a>
        </div>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script>
            (function(){
                document.getElementById("launchTutoButton").href+=localStorage.getItem("playerName");
                 $('#parametersIcon').on('click',function(){
                    localStorage.setItem('restoreURL', $(location).attr('href'));
                 });
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
</html>

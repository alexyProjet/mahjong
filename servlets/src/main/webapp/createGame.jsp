<%-- 
    Document   : createGame
    Created on : 30 mars 2019, 00:15:15
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
              integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--<link rel="stylesheet" href="createlobby.css" type="text/css">-->
        <title>Lobby creation</title>
    </head>

    <body>
        
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
        <h1 id="title">Create a lobby</h1>

        <div id="lobby">


            <div id="name">
                <h3>Choose the name</h3>
                <input  id="nameInput" class="lobbyParameter" type="text" name="lobbyName" placeholder="Enter a lobby name..." value= ${!empty name ? name : ""}>
            </div>

            <div id="visibility">
                <h3>Choose the visibility</h3>
                <select class="lobbyParameter" id="visibilityInput">
                    <option ${visibility=="public" ? "selected": ""}>Public</option>
                    <option ${visibility=="private" ? "selected":""}>Private</option>
                </select>
            </div>

            <div id="Rules">
                <h3>Choose a rule</h3>
                <select class="lobbyParameter" id="ruleInput">
                    <option ${rule=="traditionnal" ? "selected": ""}>Traditionnal</option>
                    <option>...</option>
                </select>
            </div>


            <div id="timePlay">
                <h3>Choose the time to discard</h3>
                <div id="discardTimeSlider">
                    <div id="discardTime-handle" class="ui-slider-handle"></div>
                </div>
                <h3>Choose the time to pick a tiles from the discard area</h3>
                <div id="pickTimeSlider">
                    <div id="pickTime-handle" class="ui-slider-handle"></div>
                </div>
            </div>
        </div>


        <div id="centerButton">
            <button id="launchButton">Create the Lobby</button>
        </div>


        <script>
            let launchButton = document.getElementById("launchButton");
            
            (function(){
                if(localStorage.getItem("playerName")===null){
                    let playerName = prompt("Hey ! what's your name ?");
                    localStorage.setItem("playerName",playerName);
                }
            })();

            launchButton.addEventListener("click", function () {
                let name = document.getElementById("nameInput").value;

                let visibilities = document.getElementById("visibilityInput");
                let visibility = visibilities.options[visibilities.selectedIndex].value;

                let rules = document.getElementById("ruleInput");
                let rule = rules.options[rules.selectedIndex].value;

                let playTime = document.getElementById("discardTime-handle").innerHTML;

                let stealTime = document.getElementById("pickTime-handle").innerHTML;

                if (name)
                    window.location.href = '/lobby?name=' + name + "&visibility=" + visibility + "&rule=" + rule + "&playTime=" + playTime + "&stealTime=" + stealTime + "&playerName=" + localStorage.getItem("playerName");
                else
                    alert("Please enter a name for the lobby");

            });
        </script>



    </body>

    <style>
        body{
            text-align: center;
        }

        button {
            margin: 5px;
        }
        a{
            color: black;
        }

        #homeIcon{
            position: absolute;
            left: 10px;
            top: 10px;
        }


        #parametersIcon {
            position: absolute;
            right: 10px;
            top: 10px;
        }

        #title{
            display: absolute;
            text-align: center;
            margin-top: 17vh;
        }

        #lobby{
            position: absolute;
            top: 35vh;
            left: 50vw;
            transform:translate(-50%, -35%);
            display: grid;
            grid-template-columns: 18vw;
        }

        #centerButton{
            text-align: center;
        }

        #launchButton{
            margin-top: 35vh;
            width: 15vw;
            height: 5vh;
        }

        .lobbyParameter{
            margin-top: 5px;
            margin-bottom: 5px;
            width: 15vw;
            height: 5vh;
            text-align: center;
        }

        #name{
            grid-column: 1;
        }

        #visibility{
            grid-column: 2;
        }

        #rules{
            grid-column: 1;
        }

        #timePlay{
            grid-column: 2;
        }
    </style>

</html>
<%-- 
    Document   : joinLobby
    Created on : 1 avr. 2019, 18:38:11
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/zf-5.5.2/jqc-1.11.3,dt-1.10.8/datatables.min.css" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <script type="text/javascript" src="https://cdn.datatables.net/r/zf-5.5.2/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

        <title>WireFrame of listLobby</title>
    </head>
    <body>
        <%@ include file="buttons.jsp" %>

        <h1 id="title">List of lobbies</h1>

        <div id="listLobbies" class="unselectable">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NAME</th>
                        <th>RULE</th>
                        <th>PLAYERS</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:forEach items="${ lobbyList }" var="lobby" varStatus="status">
                        <tr class='lobby'> <th>${lobby.getUUID()}</th> <th>${lobby.getName()}</th> <th>${lobby.getRule().getDescription()}</th> <th>${lobby.getNumberOfPlayer()}/4</th> </tr>;
                    </c:forEach>
                </tbody>
            </table>

        </div>

        <div id="centerButton">
            <a class="icon"><button disabled id="launchButton">Go !</button></a>
        </div>


        <script type="text/javascript">


            (function () {
                if (localStorage.getItem("playerName") === null) {
                    let playerName = prompt("Hey ! what's your name ?");
                    localStorage.setItem("playerName", playerName);
                }
            })();


            let lobbies = document.getElementsByClassName("lobby");
            let lobbySelected;
            let launchButton = document.getElementById("launchButton");

            for (lobby in lobbies) {
                lobbies[lobby].onclick = function () {
                    if (this.children[3].innerHTML !== "4/4") {
                        if (lobbySelected) {
                            lobbySelected.id = "";
                        }
                        this.id = "selected";
                        lobbySelected = this;
                        launchButton.disabled = false;
                    }
                    ;

                };
            }

            launchButton.onclick = function () {
                let lobbyId = lobbySelected.children[0].innerHTML;
                let Http = new XMLHttpRequest();
                let url = "/joinLobby?lobbyId=" + lobbyId + "&playerName=" + localStorage.getItem("playerName");
                Http.open("POST", url, true);
                Http.onreadystatechange = (e) => {
                    if (Http.status === 200) {
                        let playerId=e.currentTarget.response;
                        window.location.href = "/lobby?lobbyId=" + lobbyId + "&playerId="+playerId;
                    } else {
                        alert("You can't join this lobby");
                    }
                };
                Http.send();
            };

        </script>
    </body>

    <!-- -->

    <style>
        #selected{
            background-color: grey;
        }

        .unselectable {
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        a,a:hover{
            color: black;
        }

        #parametersIcon {
            position: absolute;
            right: 10px;
            top: 10px;
        }
        #homeIcon {
            position: absolute;
            left: 10px;
            top: 10px;
        }

        #title{

            text-align: center;
        }

        #listLobbies{
            position: absolute;
            top: 50vh;
            left: 50vw;
            transform:translate(-50%, -50%);
        }


        #myTable{
            width: 60vw;
        }

        #centerButton{
            text-align: center;
        }

        #launchButton,#privateButton{
            margin-top: 80vh;
            width: 15vw;
            height: 5vh;
            background-color: white;
            border: 2px solid black;
            color: black;
        }

    </style>
</html>

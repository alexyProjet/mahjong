<%-- 
    Document   : joinPrivateLobby
    Created on : 3 avr. 2019, 00:02:25
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="joinForm" method="POST" action="/lobby">
            <input id="lobbyId" type="text" name="lobbyId">
            <input type="submit" value="GO !">
        </form>
    </body>

    <script>
        let lobbyId;
        let joinForm = document.getElementById("joinForm");
        let Http = new XMLHttpRequest();
        let url;
        joinForm.onsubmit = function (e) {
            e.preventDefault();
            lobbyId = document.getElementById("lobbyId").value;
            url = "/joinLobby?lobbyId=" + lobbyId + "&playerName=" + localStorage.getItem("playerName");
            Http.open("POST", url, true);
            Http.onreadystatechange = (e) => {
                if (Http.status === 200) {
                    window.location.href = "/lobby?lobbyId=" + lobbyId + "&playerId=" + e.currentTarget.response;
                } else {
                    alert("You can't join this lobby");
                }
            };
            Http.send();
        };



    </script>
</html>

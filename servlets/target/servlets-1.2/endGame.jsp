<%-- 
    Document   : endGame
    Created on : 27 avr. 2019, 09:43:34
    Author     : florent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Results</title>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    </head>

    <body>
        <script>

            function updateScore() {
                let elems = $('.player');
                for (elem of elems) {
                    if ($(elem).hasClass('player'))
                        $(elem).css("color", "#202020");
                    else
                        $(elem).css("color", "#d3d3d3");
                }
            }
            $(function () {
                updateScore();
            });

        </script>
        <h1 id="title">Results</h1>

        <div id="results">
            <div id="firstBlock">
                <img id="oneImg"  class="rank" src="/scoreSVG/one.svg">
                <div class="windScoreBlock" >
                    <c:if test="${ player.getWind() == firstWind.getWind()}">
                        <div class="wind player" id="firstWind">${firstWind.getWind()}</div>
                    </c:if>
                    <c:if test="${ player.getWind() != firstWind.getWind()}">
                        <div class="wind" id="firstWind">${firstWind.getWind()}</div>
                    </c:if>
                    <c:if test="${ player.getWind() == firstWind.getWind()}">
                        <div class="score player" id="firstScore">Score : ${firstWind.getScore()}</div>
                    </c:if>
                    <c:if test="${ player.getWind() != firstWind.getWind()}">
                        <div class="score" id="firstScore">Score : ${firstWind.getScore()}</div>
                    </c:if>
                </div>
            </div>
            <div id="block">
                <div class="otherBlock">
                    <img class="rank otherImg" src="/scoreSVG/two.svg">
                    <div class="windScoreBlock ">
                        <c:if test="${ player.getWind() == secondWind.getWind()}">
                            <div class="wind otherWind player">${secondWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != secondWind.getWind()}">
                            <div class="wind otherWind">${secondWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() == secondWind.getWind()}">
                            <div class="score player otherScore">Score : ${secondWind.getScore()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != secondWind.getWind()}">
                            <div class="score otherScore">Score : ${secondWind.getScore()}</div>
                        </c:if>
                    </div>
                </div>
                <div class="otherBlock">
                    <img  class="rank otherImg" src="/scoreSVG/three.svg">
                    <div class="windScoreBlock">
                        <c:if test="${ player.getWind() == thirdWind.getWind()}">
                            <div class="wind otherWind player">${thirdWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != thirdWind.getWind()}">
                            <div class="wind otherWind">${thirdWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() == thirdWind.getWind()}">
                            <div class="score player otherScore">Score : ${thirdWind.getScore()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != thirdWind.getWind()}">
                            <div class="score otherScore">Score : ${thirdWind.getScore()}</div>
                        </c:if>
                    </div>
                </div>
                <div class="otherBlock">
                    <img  class="rank otherImg" src="/scoreSVG/four.svg">
                    <div class="windScoreBlock">
                        <c:if test="${ player.getWind() == fourthWind.getWind()}">
                            <div class="wind otherWind player">${fourthWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != fourthWind.getWind()}">
                            <div class="wind otherWind">${fourthWind.getWind()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() == fourthWind.getWind()}">
                            <div class="score player otherScore">Score : ${fourthWind.getScore()}</div>
                        </c:if>
                        <c:if test="${ player.getWind() != fourthWind.getWind()}">
                            <div class="score otherScore">Score : ${fourthWind.getScore()}</div>
                        </c:if>
                    </div>
                </div>

            </div>
            <div id="goHomeBlock">
                <button id="goHomeButton" onclick="window.location.href = '/accueil'">Go Home !</button>
            </div>
        </div>   
    </body>
</html>

<style>
    #title{
        display: absolute;
        text-align: center;
        margin-top: 5vh;
    }
    #results{
        position: absolute;
        display: flex;
        flex-direction: column;
        top: 50vh;
        left: 50vw;
        transform:translate(-50%, -50%);
    }
    #goHomeBlock{
        text-align: center;
        padding-top: 7vh;
    }
    #goHomeButton{
        margin: 10px;
        height: 7vh;
        width: 20vw;
        text-align: center;
    }
    #firstBlock{
        border-radius: 0px 0px 100px 0px;
        -moz-border-radius: 0px 0px 100px 0px;
        -webkit-border-radius: 0px 0px 100px 0px;
        border-bottom:  9px outset #e0e0e0;
        border-right: 9px outset #e0e0e0;
        padding: 30px;
        display: flex;
        flex-direction: row;


    }
    #oneImg{
        height:20vh;
        width: 20vw;
        margin-left: 10vw;
    }
    .otherImg{
        height:10vh;
        width: 10vw;
    }
    .windScoreBlock{
        display: flex;
        flex-direction: column;
    }
    #firstWind{
        color: #d3d3d3;
        font-family: 'Raleway',sans-serif;
        font-size: 62px;
        font-weight: 800;
        line-height: 72px;
        margin: 0 0 24px;
        text-transform: uppercase;
    }
    .otherWind{
        color: #d3d3d3;
        font-family: 'Raleway',sans-serif;
        font-size: 31px;
        font-weight: 800;
        line-height: 36px;
        margin: 0 0 12px;
        text-align: right;
        text-transform: uppercase;
    }
    #firstScore{ 
        color: #d3d3d3;
        font-family: 'Raleway',sans-serif;
        font-size: 30px;
        font-weight: 800;
        line-height: 36px;
        margin: 0 0 24px;
    }
    .otherScore{ 
        color: #d3d3d3;
        font-family: 'Raleway',sans-serif;
        font-size: 15px;
        font-weight: 800;
        line-height: 18px;
        margin: 0 0 12px;
    }

    #block{
        display: flex;
        flex-direction: row;
        margin-top: 5vh;
    }
    .otherBlock{
        border-radius: 0px 0px 100px 0px;
        -moz-border-radius: 0px 0px 0px 0px;
        -webkit-border-radius: 0px 0px 0px 0px;
        border-bottom:  9px outset #e0e0e0;
        display: flex;
        padding: 30px;
        margin-right: 10px;
    }
</style>
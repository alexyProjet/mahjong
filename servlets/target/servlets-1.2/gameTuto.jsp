<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
              integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link rel="stylesheet" href="game.css">
        <link rel="stylesheet" href="svg.css">


        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
                <script src="jquery.wait.js"></script>
        <title>Maquette de la partie</title>
    </head>

    <body>
        <script>
            
             function majZoom(){//Zoom 
                let tiles = $('.tile');
                for (tile of tiles) {
                        $(tile).on("mouseover", function () {
                        html = $(this).attr('src');                        
                            if(zoomOn){                                
                                $('#zoomWindow').html('<img id="zoomTile" src="' + html + '" />');
                                $('#zoomWindow').removeClass('hide').wait(100).addClass('hide');       
                            }                   
                        });
                    }   
            }
            
            function updateWall() {
                let elems = $('.tileWall,.rotateWall');
                for (elem of elems) {
                    if ($(elem).hasClass('double tile'))
                        $(elem).attr("src", "./tilesSVG/XX.svg");
                    else if ($(elem).hasClass('single tile'))
                        $(elem).attr("src", "./tilesSVG/XX2.svg");
                }
            }
            
            $(function () {
                /*
                 if (typeof localStorage.getItem('playerHand') !== 'undefined' && localStorage.getItem('playerHand') !== null)
                 $('#bottomHand').html(localStorage.getItem('playerHand'));
                 */
                $("#sortable").sortable({
                    scroll: false
                });
                /*
                 $("#sortable").on("sortupdate", function (event, ui) {
                 localStorage.setItem('playerHand', $('#bottomHand').html());
                 });
                 */
                $("#bottomDiscardArea").droppable({
                    drop: function (event, ui) {
                        if ($(ui.draggable).hasClass("ui-sortable-helper")) {
                            var itemText = $(ui.draggable);
                            $('#bottomDiscardArea').html($('#bottomDiscardArea').html() + $(itemText).html().replace("tilePlayer", "tileDiscard"));
                            $(ui.draggable).empty();
                             majZoom();
                        }
                    }
                });



            
            updateWall();
            

            zoomOn = false;
            document.addEventListener('keydown', function(e){
              if(e.key === 'e'){
                  if(zoomOn === true){
                      zoomOn = false;
                      Swal.fire({ type: 'error',title: 'Zoom off',showConfirmButton: false,timer: 250});
                  }else{
                      zoomOn = true;
                      Swal.fire({ type: 'success',title: 'Zoom on',showConfirmButton: false,timer: 250});
                  }
              }     
            });

            
          
            majZoom();
        });
            
        </script>
               <%@ include file="buttons.jsp" %>

        <a href="greenbook_en.pdf" target="_blank"><i id="reminderIcon" class="fas fa-info fa-5x"></i></a>

         <div id="zoomWindow" class="hide">
             <div id="zoom"></div>
        </div>

        <div id="topPlayer">
            <div id="topHand" class="hand">
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
                <img class="tileHand tile" src="./tilesSVG/XX.svg" />
            </div>
            <div id="topMeld">
                <% out.println((String) request.getAttribute("topMeld")); %>
            </div>
        </div>

        <div id="leftPlayer">
            <div id="leftHand" class="hand">
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
            </div>
            <div id="leftMeld">
                <% out.println((String) request.getAttribute("leftMeld")); %>
            </div>
        </div>


        <div id="rightPlayer">
            <div id="rightHand" class="hand">
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
                <img class="rotateHand tile" src="./tilesSVG/XX.svg" />
            </div>
            <div id="rightMeld">
                <% out.println((String) request.getAttribute("rightMeld")); %>
            </div>
        </div>

        <div id="bottomPlayer">
            <div id="bottomMeld">
                <% out.println((String) request.getAttribute("bottomMeld")); %>
            </div>
            <div id="bottomHand" class="hand">
                <ul id="sortable">
                    <c:forEach items="${myHand}" var="tile">
                        <li class="playerTiles">
                            <img class="tilePlayer tile" src="./tilesSVG/${tile}.svg" />
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>




        <div id="playArea">
            <div id="topWall" class="wall">
                <% out.println((String) request.getAttribute("topWall")); %>

            </div>
            <div id="leftWall" class="wall">
                <% out.println((String) request.getAttribute("leftWall")); %>
            </div>
            <div id="rightWall" class="wall">
                <% out.println((String) request.getAttribute("rightWall")); %>
            </div>
            <div id="bottomWall" class="wall">
                <% out.println((String) request.getAttribute("bottomWall")); %>
            </div>
            <div id="discardArea">
                <div id="topDiscardArea" class="discardZone">
                    <% out.println((String) request.getAttribute("topDiscard")); %>
                </div>
                <div id="rightDiscardArea" class="discardZone">
                    <% out.println((String) request.getAttribute("rightDiscard")); %>
                </div>
                <div id="bottomDiscardArea" class="discardZone">
                    <% out.println((String) request.getAttribute("bottomDiscard")); %>
                </div>
                <div id="leftDiscardArea" class="discardZone">
                    <% out.println((String) request.getAttribute("leftDiscard"));%>
                </div>
                <div id="voidArea"></div>
            </div>
        </div>
    </body>

</html>

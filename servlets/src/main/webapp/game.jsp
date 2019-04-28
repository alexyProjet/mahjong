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

            function majZoom() {//Zoom 
                let tiles = $('.tile');
                for (tile of tiles) {
                    $(tile).on("mouseover", function () {
                        html = $(this).attr('src');
                        if (zoomOn) {
                            $('#zoomWindow').html('<img id="zoomTile" src="' + html + '" />');
                            $('#zoomWindow').removeClass('hide').wait(500).addClass('hide');
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
                document.addEventListener('keydown', function (e) {
                    if (e.key === 'e') {
                        if (zoomOn === true) {
                            zoomOn = false;
                            Swal.fire({type: 'error', title: 'Zoom off', showConfirmButton: false, timer: 250});
                        } else {
                            zoomOn = true;
                            Swal.fire({type: 'success', title: 'Zoom on', showConfirmButton: false, timer: 250});
                        }
                    }
                });



                majZoom();
            });

        </script>
        <a href="/accueil"><i id="homeIcon" class="fas fa-sign-out-alt fa-5x"></i></a>

        <a href="greenbook_en.pdf" target="_blank"><i id="reminderIcon" class="fas fa-info fa-5x"></i></a>

        <c:if test="{myWind==Wind.SOUTH}">
            <img id="compass" src="./miscSVG/compass.svg">
        </c:if>
        <c:if test="{myWind==Wind.EST}">
            <img id="compass" class="right" src="./miscSVG/compass.svg">
        </c:if>
        <c:if test="{myWind==Wind.WEST}">
            <img id="compass" class="left" src="./miscSVG/compass.svg">
        </c:if>
        <c:if test="{myWind==Wind.NORTH}">
            <img id="compass" class="bottom" src="./miscSVG/compass.svg">
        </c:if>


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
            <div id="topMeldBlock">
                <div id="topMeld">
                    <div id="meldTop0">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneWest0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneSouth0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneEast0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneNorth0.getTiles()}" var="tile">
                                <img  id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldTop1">

                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneWest1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneSouth1.getTiles()}" var="tile">
                                <img  id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneEast1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneNorth1.getTiles()}" var="tile">
                                <img  id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldTop2">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneWest2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneSouth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneEast2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneNorth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldTop3">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneWest3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneSouth3.getTiles()}" var="tile">
                                <img  id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneEast3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneNorth3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                <div id="topSupreme">
                    <c:if test="{myWind==Wind.EAST}">
                        <c:forEach items="${supremeZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.WEST}">
                        <c:forEach items="${supremeZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.NORTH}">
                        <c:forEach items="${supremeZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>


                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${supremeZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                </div>
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
            <div id="leftMeldBlock">
                <div id="leftMeld">
                    <div id="meldLeft0">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneSouth0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneEast0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneNorth0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneWest0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}"  class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldLeft1">

                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneSouth1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneEast1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneNorth1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneWest1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldLeft2">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneSouth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneEast2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneNorth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneWest2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>

                    <div id="meldLeft3">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneSouth3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneEast3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneNorth3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneWest3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld  tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                <div id="leftSupreme">
                    <c:if test="{myWind==Wind.EAST}">
                        <c:forEach items="${supremeZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.WEST}">
                        <c:forEach items="${supremeZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.NORTH}">
                        <c:forEach items="${supremeZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>


                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${supremeZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>


        <div id="rightPlayer">
            <div id="rightMeldBlock">
                <div id="rightSupreme">
                    <c:if test="{myWind==Wind.EAST}">
                        <c:forEach items="${supremeZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.WEST}">
                        <c:forEach items="${supremeZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                    <c:if test="{myWind==Wind.NORTH}">
                        <c:forEach items="${supremeZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>


                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${supremeZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>

                </div>
                <div id="rightMeld">
                    <div id="meldRight0">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneNorth0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneWest0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneSouth0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneEast0.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldRight1">

                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneNorth1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneWest1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneSouth1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneEast1.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                    <div id="meldRight2">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneNorth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneWest2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneSouth2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneEast2.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>

                    <div id="meldRight3">
                        <c:if test="{myWind==Wind.EAST}">
                            <c:forEach items="${meldZoneNorth3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.NORTH}">
                            <c:forEach items="${meldZoneWest3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>

                        <c:if test="{myWind==Wind.WEST}">
                            <c:forEach items="${meldZoneSouth3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                        <c:if test="{myWind==Wind.SOUTH}">
                            <c:forEach items="${meldZoneEast3.getTiles()}" var="tile">
                                <img id="${tile.getTileID()}" class="rotateMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
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

        </div>

        <div id="bottomPlayer">
            <div id="bottomMeldBlock">
                <div id="bottomMeld">
                    <div id="meldBottom0">
                        <c:forEach items="${myMeldZone0.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </div>
                    <div id="meldBottom1">
                        <c:forEach items="${myMeldZone1.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </div>
                    <div id="meldBottom2">
                        <c:forEach items="${myMeldZone2.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </div>
                    <div id="meldBottom3">
                        <c:forEach items="${myMeldZone3.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </div>
                </div>
                <div id="bottomSupreme">
                    <c:forEach items="${mySupremeZone.getTiles()}" var="tile">
                        <img id="${tile.getTileID()}" class="tileMeld tile" src="./tilesSVG/${tile.getName()}.svg" />
                    </c:forEach>

                </div>
            </div>
            <div id="bottomHand" class="hand">
                <ul id="sortable">
                    <c:forEach items="${myHand.getTiles()}" var="tile">
                        <li class="playerTiles">
                            <img id="${tile.getTileID()}" class="tilePlayer tile" src="./tilesSVG/${tile.getName()}.svg" />
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
                <% out.println((String) request.getAttribute("bottomWall"));%>
            </div>
            <div id="discardArea">
                <div id="topDiscardArea" class="discardZone">
                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${discardZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.North}">
                        <c:forEach items="${discardZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.West}">
                        <c:forEach items="${discardZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.East}">
                        <c:forEach items="${discardZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="tileDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                </div>
                <div id="rightDiscardArea" class="discardZone">
                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${discardZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.North}">
                        <c:forEach items="${discardZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.West}">
                        <c:forEach items="${discardZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.East}">
                        <c:forEach items="${discardZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard  tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                </div>
                <div id="bottomDiscardArea" class="discardZone">
                    <c:forEach items="${myDiscardArea.getTiles()}" var="tile">
                        <img id="${tile.getTileID()}" class="tileDiscard tile" src="./tilesSVG/${tile.getName()}.svg" />
                    </c:forEach>
                </div>
                <div id="leftDiscardArea" class="discardZone">
                    <c:if test="{myWind==Wind.SOUTH}">
                        <c:forEach items="${discardZoneWest.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.North}">
                        <c:forEach items="${discardZoneEast.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.West}">
                        <c:forEach items="${discardZoneNorth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                    <c:if test="{myWind==Wind.East}">
                        <c:forEach items="${discardZoneSouth.getTiles()}" var="tile">
                            <img id="${tile.getTileID()}" class="rotateDiscard tile" src="./tilesSVG/${tile.getName()}.svg" />
                        </c:forEach>
                    </c:if>
                </div>
                <div id="voidArea"></div>
            </div>
        </div>
    </body>

</html>

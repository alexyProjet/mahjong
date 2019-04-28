
<%-- 
    Document   : displayParameters
    Created on : 24 avr. 2019, 21:25:56
    Author     : florent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Display Parameters Mahjong</title>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<a href=""><i id="backIcon" class="fas fa-arrow-left fa-5x"></i></a>
	<h1 id="title">Display Parameters</h1>
	<div id="displayParameters">
                <div id="playerId" class="block">
                    <label class="parametersLabel">Your username:</label>
                    <input class="parametersText" type="text" name="playerId" value="" />
                </div>
            
		<div id="language" class="block">
			<label class="parametersLabel">Language</label>
			<select class="parametersButton" placeholder="Language">
				<option>French</option>
			</select>
		</div>
                
                
                <h3>Music</h3>
                <div id="music">
                    <div id="music-handle" class="ui-slider-handle"></div>
                </div>
                <h3>Sound</h3>
                <div id="sound">
                    <div id="sound-handle" class="ui-slider-handle"></div>
                </div>
                
		
		<div id="saveBlock">
			<button class="parametersButton" onclick="Swal.fire({ type: 'success',title: 'Parameters saved',showConfirmButton: false,timer: 1500})">Save</button>
		</div>
	</div>

</body>
</html>

<style>
    #backIcon {
	position: absolute;
	left: 10px;
	top: 10px;
}

a{
	color:black;
}

#displayParameters{
	position: absolute;
	display: flex;
	flex-direction: column;
	top: 50vh;
	left: 50vw;
	transform:translate(-50%, -50%);
}

.block{
	display: grid;
	grid-template-columns: 10vw;
}

.parametersButton{
	margin: 10px;
	height: 7vh;
	width: 20vw;
	text-align: center;
	grid-column: 2;
}

.parametersText{
	margin: 10px;
	height: 7vh;
	width: 20vw;
	text-align: center;
	grid-column: 2;
}

.parametersLabel{
	font-size: 2em;
	grid-column: 1;
	padding-left: 10px;
	padding-top: 10px;
}

#title{
	display: absolute;
	text-align: center;
	margin-top: 17vh;
}

#saveBlock{
	text-align: center;
        margin-top: 5vh;
}
    
    
    
</style>
<script>
    
    $(function(){
       if (typeof localStorage.getItem('restoreURL') !== 'undefined' && localStorage.getItem('restoreURL') !== null)
            $('a').attr('href',localStorage.getItem('restoreURL'));
        
        
        var handle = $("#music-handle");
                $("#music").slider({
                    min: 0,
                    max: 100,
                    create: function () {
                        handle.text($(this).slider("value"));
                    },
                    slide: function (event, ui) {
                        handle.text(ui.value);
                    }
                });

         var handlee = $("#sound-handle");
                $("#sound").slider({
                    min: 0,
                    max: 100,
                    create: function () {
                        handlee.text($(this).slider("value"));
                    },
                    slide: function (event, ui) {
                        handlee.text(ui.value);
                    }
                });
    });
</script>

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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<a href=""><i id="backIcon" class="fas fa-arrow-left fa-5x"></i></a>
	<h1 id="title">Display Parameters</h1>
	<div id="displayParameters">
		<!-- <div id="language" class="block">
			<label class="parametersLabel">Language</label>
			<select class="parametersButton" placeholder="Language">
				<option>English</option>
				<option>French</option>
			</select>
		</div> -->

		
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
}
    
    
    
</style>
<script>
    
    $(function(){
       if (typeof localStorage.getItem('restoreURL') !== 'undefined' && localStorage.getItem('restoreURL') !== null)
            $('a').attr('href',localStorage.getItem('restoreURL'));
    });
</script>

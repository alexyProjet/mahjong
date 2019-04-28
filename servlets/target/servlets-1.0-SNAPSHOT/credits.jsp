<%-- 
    Document   : credits.jsp
    Created on : 24 avr. 2019, 21:40:49
    Author     : florent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Display Parameters Mahjong</title>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
	<link rel="stylesheet" href="../css/credits.css" >
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<%@ include file="buttons.jsp" %>
	<h1 id="title">Credits</h1>
	<div id="credits">
            <h2 id="team">-- DAO - Fichiers --</h2>
		<div class="authorName">Nesrine Hantat</div>
		<div class="authorName">Aliyou Sylla</div>
            <h2 id="team">-- DAO - SGBD --</h2>
		<div class="authorName">Louis Allain</div>
		<div class="authorName">Faroud Sadikou</div>
            <h2 id="team">-- Engine --</h2>
		<div class="authorName">Charles Cogoluegnes</div>
		<div class="authorName">Anton Cosnefroy</div>
		<div class="authorName">Tristan Furno</div>
		<div class="authorName">Maxime Guillaume</div>
		<div class="authorName">Pierre Guriel--Fardel</div>
		<div class="authorName">Samuel Le Berre</div>
		<div class="authorName">Clément Mallejac</div>
		<div class="authorName">Abdelilah Moulida</div>
            <h2 id="team">-- IA --</h2>
		<div class="authorName">Arthur Dembiermont</div>
		<div class="authorName">Valentin Durand</div>
		<div class="authorName">Maël Le Gal</div>
		<div class="authorName">Vincent Maurice</div>
		<div class="authorName">Guenole Thevenard</div>
            <h2 id="team">-- Interface --</h2>
		<div class="authorName">Jules Audurier</div>
		<div class="authorName">Allan Comisso</div>
		<div class="authorName">Liam Cotte</div>
		<div class="authorName">Alexy Duhamel</div>
		<div class="authorName">Maxime Hamon</div>
		<div class="authorName">Florent Simonet</div>
            <h2 id="team">-- Réseau --</h2>
		<div class="authorName">Alexandre Amouriq</div>
		<div class="authorName">Mael Berrigaud</div>
		<div class="authorName">Pierre Goujon</div>
            <h2 id="team">-- SAPI --</h2>
		<div class="authorName">Youri Bernard</div>
		<div class="authorName">Johan Gousset</div>
		<div class="authorName">Romann Yvinec</div>
            <h2 id="team">-- Tutoriel --</h2>
		<div class="authorName">Ewen Bouder</div>
	</div>
</body>
</html>

<style>
    #parametersIcon {
	position: absolute;
	right: 10px;
	top: 10px;
}

a{
	color: black;
}

#homeIcon {
	position: absolute;
	left: 10px;
	top: 10px;
}

#title{
	display: absolute;
	text-align: center;
	margin-top: 17vh;

}

#credits{
	position: absolute;
	left: 44.5vw;
	text-align: center;
}

#team{
	text-align: center;
}

.authorName{
	text-align: center;
}

</style>
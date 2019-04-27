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
	<div id="authors">
		<div class="authorName">Allain LOUIS</div>
		<div class="authorName">Alexandre AMOURIQ</div>
		<div class="authorName">Jules AUDURIER</div>
		<div class="authorName">Youri BERNARD</div>
		<div class="authorName">Mael BERRIGAUD</div>
		<div class="authorName">Ewen BOUDER</div>
		<div class="authorName">Charles COGOLUEGNES</div>
		<div class="authorName">Allan COMISSO</div>
		<div class="authorName">Anton COSNEFROY</div>
		<div class="authorName">Liam COTTE</div>
		<div class="authorName">Arthur DEMBIERMONT</div>
		<div class="authorName">Alexy DUHAMEL</div>
		<div class="authorName">Valentin DURAND</div>
		<div class="authorName">Tristan FURNO</div>
		<div class="authorName">Pierre GOUJON</div>
		<div class="authorName">Johan GOUSSET</div>
		<div class="authorName">Maxime GUILLAUME</div>
		<div class="authorName">Pierre GURIEL-FARDEL</div>
		<div class="authorName">Maxime HAMON</div>
		<div class="authorName">Nesrine HANTAT</div>
		<div class="authorName">Samuel LE BERRE</div>
		<div class="authorName">Maël LE GAL</div>
		<div class="authorName">Clement MALLEJAC</div>
		<div class="authorName">Vincent MAURICE</div>
		<div class="authorName">Nathan MINGOUBE</div>
		<div class="authorName">Abdelilah MOULIDA</div>
		<div class="authorName">Cynthia PIQUET</div>
		<div class="authorName">Goulven POULALIOU</div>
		<div class="authorName">Faroud SADIKOU</div>
		<div class="authorName">Florent SIMONET</div>
		<div class="authorName">Aliyou SYLLA</div>
		<div class="authorName">Guenole THEVENARD</div>
		<div class="authorName">Romann YVINEC</div>
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

#authors{
	text-align: center;
}

.authorName{
	text-align: center;
}

</style>
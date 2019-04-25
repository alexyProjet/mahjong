<%-- 
    Document   : buttons
    Created on : 2 avr. 2019, 22:29:33
    Author     : aster
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<a href="/displayParameters"><i id="parametersIcon" class="fas fa-cog fa-5x"></i></a>
<a href="/accueil"><i id="homeIcon" class="fas fa-home fa-5x"></i></a>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
    $(function(){
        $('a').on('click',function(){
           localStorage.setItem('restoreURL', $(location).attr('href'));
        });
    });
    
</script>
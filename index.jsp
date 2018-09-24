<!-- index.jsp -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="msg" class="java.lang.String" scope="request" />
<html>
<head>
<title>Gestion turnos Une</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script language="JavaScript">

function enviarSolicitud(){
	var user= document.getElementById("usuario");
	var passwd= document.getElementById("password");
	
	if(user.value == '' ){
		alert("Ingrese por favor un nombre de usuario.");
		user.focus();
		return;
	}
	if(passwd.value == '' ){
		alert("Ingrese una contraseña, no se permiten contraseñas en blanco.");
		passwd.focus();
		return;
	}
	
	document.formaUsuario.submit();
}
</script>
<link href="turnos.css" rel="stylesheet" type="text/css">

<body>
 <center><img src="imagenes/cabecera.png" height="141" width="888"></center>
  <center>
  
  <p>&nbsp;</p>
  <p><strong><font size="+3">Gestion turnos Une</font></strong> </p>
   
  
  <p><strong><font size="+1">Registro</font></strong></p>
  
  <center>
  <!--  div class="loginStyle" align="center"-->
  
  <form name="formaUsuario" method="post" action="action">
  <input type="hidden" name="accion" value="inicio">
  <table width="216" height="80" align="center">
    <tr>
      <td>Usuario</td>
      <td><input name="usuario" type="text" size="13" id="usuario"></td>
    </tr>
    <tr>
      <td>Password</td>
      <td><input name="password" type="password" size="13" id="password"></td>
    </tr>
  </table>
  <p>
    <input name="boton" type="button" id="boton" value="Enviar" onClick="javascript:enviarSolicitud();">
    </form>    
    <!-- /div--> 
    </center>
  </p>
  <p>&nbsp;</p>
  <p><font size="+1">${msg}</font></p>
  
</center>
</body>
</html>

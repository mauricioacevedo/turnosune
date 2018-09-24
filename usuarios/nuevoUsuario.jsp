<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="user" value="${requestScope.usuario}" />
<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${empty user?"Nuevo":"Modificar"} Usuario - Turnos Une-EPM TELCO</title>
<script type="text/javascript">
function validarCampos(){

	var nick=document.getElementById("nick").value;
	var passwd=document.getElementById("passwd").value;
	var nombre=document.getElementById("nombre").value;
	var registro=document.getElementById("registro").value;
	var rotacion=document.getElementById("selectRotacion").value;
	var nivel=document.getElementById("selectNivel").value;
	var nivel2=document.getElementById("selectNivel").text;

	
	if(nick==''){
		alert("debe ingresar un nombre de usuario.");
		document.getElementById("nick").focus();
		return;
	}
	
	if(registro==''){
		alert("debe ingresar el registro del usuario.");
		document.getElementById("registro").focus();
		return;
	}
	
	if(passwd==''){
		alert("debe ingresar una contraseña.");
		document.getElementById("passwd").focus();
		return;
	}
	
			
	var conf=confirm("Esta es la configuracion del Usuario:"+
					"\nNombre de usuario: "+nick+
					"\nContraseña: "+passwd+
					"\nNombre: "+nombre+
					"\nRegistro: "+registro+
					"\nRotacion: "+rotacion+
					"\nNivel de Usuario: "+nivel2+
					"\nDesea Continuar?");
	if(conf){ 
		 
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=doAgregarUsuario";
		url=url+"&nick="+nick+"&passwd="+passwd+"&nombre="+nombre+"&rotacion="+rotacion+"&nivel="+nivel+"&registro="+registro;
		
		url=url+'${not empty user?"&idUser=":""}${not empty user?user.id:""}';
		location.href=url;
	}
	
}

function validarCampos2(){

	var nick=document.getElementById("nick").value;
	var passwd=document.getElementById("passwd").value;
	var nombre=document.getElementById("nombre").value;
	var registro=document.getElementById("registro").value;
	var rotacion=document.getElementById("selectRotacion").value;
	var nivel=document.getElementById("selectNivel").value;
	var nivel2=document.getElementById("selectNivel");
	nivel2=nivel2.options[nivel2.options.selectedIndex].text;
	var participaPool=document.getElementById("selectPool").value;
	var participaPool2=document.getElementById("selectPool").text;
	
	var declinaPool=document.getElementById("selectDeclinaPool").value;
	var declinaPool2=document.getElementById("selectDeclinaPool").text;
	
	
	var grupo='';
	
	<c:if test="${not empty user and user.nivel=='3'}">
	
	var gruposel=document.getElementById("selectGrupos");
	
for (var i=0;i < gruposel.options.length;i++){
     if (gruposel.options[i].selected){
           grupo += gruposel.options[i].value+",";
	}
} 

	</c:if>
	
	
	if(participaPool=='FALSE'){
		//debido a esto necesariamente este usuario no tiene pool este turno.
		declinaPool='TRUE';
		declinaPool2='Si';
	}
	
	
	if(nick==''){
		alert("debe ingresar un nombre de usuario.");
		document.getElementById("nick").focus();
		return;
	}
	
	if(registro==''){
		alert("debe ingresar el registro del usuario.");
		document.getElementById("registro").focus();
		return;
	}
	
	if(passwd==''){
		alert("debe ingresar una contraseña.");
		document.getElementById("passwd").focus();
		return;
	}
	
			
	var conf=confirm("Esta es la configuracion del Usuario:"+
					"\nNombre de usuario: "+nick+
					"\nContraseña: "+passwd+
					"\nNombre: "+nombre+
					"\nRegistro: "+registro+
					"\nRotacion: "+rotacion+
					"\nNivel de Usuario: "+nivel2+
					"\nUsuario del Pool de domingos: "+participaPool2+
					"\nDeclina el Pool este turno: "+declinaPool2+
					(grupo!=''?"\nGrupos: "+grupo:"")+
					"\nDesea Continuar?");
	if(conf){ 
		 
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=doModificarUsuario";
		url=url+"&nick="+nick+"&passwd="+passwd+"&nombre="+nombre+"&rotacion="+rotacion+"&nivel="+nivel+"&idUser=${user.id}&registro="+registro;
		url=url+"&participaPool="+participaPool+"&declinaPool="+declinaPool+"&grupo="+grupo;
		
		location.href=url;
	}
	
}


function regresarInicioUsuarios(){
	location.href="${pageContext.request.contextPath}/action?accion=gestorUsuarios";
}
</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center>Ingreso de Usuarios - Une-EPM TELCO</center>

<p></p>
<br>
 
<table width="40%" align="center">
<tr>
<td align="center" width="50%">Nombre de Usuario</td>
<td align="center" width="50%">
<input type="text" id="nick" value="${empty user?'':user.nick}"> 
</td>
</tr>

<tr>
<td align="center" width="50%">Registro</td>
<td align="center" width="50%">
<input type="text" id="registro" value="${empty user?'':user.registro}"> 
</td>
</tr>

<tr>
<td align="center" width="50%">Contraseña</td>
<td align="center" width="50%">
<input type="password" id="passwd" value="${empty user?'':user.passwd}"> 
</td>
</tr>

<tr>
<td align="center" width="50%">Nombre</td>
<td align="center" width="50%">
<input type="text" id="nombre" value="${empty user?'':user.nombre}">  
</td>
</tr>

<tr>
<td align="center" width="50%">Rotacion</td>
<td align="center" width="50%">

<select id="selectRotacion" ${not empty user and user.nivel>='2'?'disabled':''}>
	<option value="true" ${not empty user and user.rotacion=='true'?'selected="selected"':''}>Si</option>
	<option value="false" ${not empty user and user.rotacion=='false'?'selected="selected"':''}>No</option>
</select>
</td>
</tr>

<tr>
<td align="center" width="50%">Nivel de Usuario</td>
<td align="center" width="50%">
<select id="selectNivel" "${not empty user?'disabled=disabled':''}">
	<option value="1" ${not empty user and user.nivel=='1'?'selected="selected"':''}>Asesor</option>
	<option value="3" ${not empty user and user.nivel>='2'?'selected="selected"':''}>Administrador</option>
</select>
</td>
</tr>

<%--Esta condicion es para verificar si es del grupo de basica o no
	solo los probadores de basica pueden tener acceso al pool
 --%>
<c:if test="${not empty user}">
<tr>
<td align="center" width="50%">Pool de domingo</td>
<td align="center" width="50%">
<select id="selectPool" ${not empty user and user.nivel>='2'?'disabled':''}>
	<option value="FALSE" "${not empty user and user.participa_pool=='false'?'selected=selected':''}">No</option>
	<option value="TRUE" "${not empty user and user.participa_pool=='true'?'selected=selected':''}">Si</option>
</select>
</td>
</tr>

<tr>
<td align="center" width="50%">Declina el pool este turno?</td>
<td align="center" width="50%">
<select id="selectDeclinaPool" ${not empty user and user.nivel>='2'?'disabled':''}>
	<option value="FALSE" "${not empty user and user.declina_pool=='false'?'selected=selected':''}">No</option>
	<option value="TRUE" "${not empty user and user.declina_pool=='true'?'selected=selected':''}">Si</option>
</select>
</td>
</tr>

</c:if>

<c:if test="${not empty user and user.nivel=='3'}">

<tr>
<td align="center" width="50%">Grupos Asignados</td>
<td align="center" width="50%">

<select id="selectGrupos" multiple="multiple">
<c:forEach items="${listaGrupos}" var="grupo">
<option value="${grupo.id}" "${fn:contains(user.grupos_admin,grupo.id)?'selected=selected':''}">${grupo.descripcion}</option>
</c:forEach>
</select>
</td>
</tr>

</c:if>

</table>

<center><input type="button" value="${empty user?'insertar':'modificar'}" onclick="javascript:validarCampos${empty user?'':'2'}();">&nbsp;&nbsp;<input type="button" value="cancelar" onclick="javascript:regresarInicioUsuarios();"></center>

</body>
</html>

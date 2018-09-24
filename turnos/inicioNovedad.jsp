<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaPool" value="${requestScope.listaPool}" />
<%-- esta es una lista de arrays de 2 pocisiones: [0]: usuario, [1]:turno --%>


<c:set var="usuario" value="${requestScope.usuario}" scope="request"/>
<c:set var="grupoId" value="${requestScope.grupoId}" scope="request"/>
<c:set var="usuarioPool" value="${requestScope.usuarioPool}" scope="request"/>
<c:set var="turnoUsuarioPool" value="${requestScope.turnoUsuarioPool}" scope="request"/>
<c:set var="msg" value="${requestScope.msg}" scope="request"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Definir Novedad</title>

<script type="text/javascript">


function definirNovedad(){
	
	var novedad=document.getElementById("selectNovedades").value;
	var descNovedad="";
	var url2="";
	
	descNovedad=document.getElementById("inputNovedad").value;
		
	if(descNovedad==''&&novedad!=''){
		alert("defina una descripcion de la novedad para este usuario.");
		return;
	}
	
	if(novedad==''){
		descNovedad='';
	}
	
	url2="&novedad="+novedad+"&descripcionNovedad="+descNovedad;
	
	if(novedad!=''){
		var conf=confirm("Esta novedad excluye al probador del turno asignado?");
	}
	
	if(conf){
		url2+="&excluir=true";
		alert("El probador no volvera a rotar hasta que se cambie la novedad de este.");
	}
	
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=definirNovedad&user=${usuario.id}"+url2;

}

function traerUsuarioPool(){

	var user = document.getElementById("selectPool");
	
	if(user.value=='-1')
		return;
	
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=traerUsuarioPool&userPool="+user.value+"&userId=${usuario.id}&grupoId=${grupoId}";
	
}

function asignarDomingo(){
	var user = document.getElementById("selectPool");
	
	if(user.value=='-1')
		return;
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=asignarDomingoPool&userPool="+user.value+"&userId=${usuario.id}&grupoId=${grupoId}";
}

function cambiarTurno(){
	var user = document.getElementById("selectPool");
	
	if(user.value=='-1')
		return;
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=cambiarTurnoPool&userPool="+user.value+"&userId=${usuario.id}&grupoId=${grupoId}";	
}

function declinarPool(){
	var user = document.getElementById("selectPool");
	
	if(user.value=='-1')
		return;
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=declinarPool&userPool="+user.value+"&grupoId=${grupoId}&userId=${usuario.id}";	
}

</script>

</head>
<body>
<br>
<center>Definir Novedad para el usuario <font color="red" size="-1">${usuario.nombre}</font></center>
<br>
<table align="center">
<tr>
<td align="center"  bgcolor="#b5b5b5">Seleccione Novedad</td>
<td align="center">
<select id="selectNovedades">
<option value="">SIN NOVEDAD</option>
<option value="INCAPACITADO" ${fn:contains(usuario.novedad,'INCAPACITADO')?'selected=selected'}>INCAPACITADO</option>
<option value="VACACIONES" ${fn:contains(usuario.novedad,'VACACIONES')?'selected=selected':''}>VACACIONES</option>
<option value="PERMISO" ${fn:contains(usuario.novedad,'PERMISO')?'selected=selected':''}>PERMISO</option>
<option value="OTRA" ${fn:contains(usuario.novedad,'OTRA')?'selected=selected':''}>OTRA</option>
</select>
<br>
<input type="text" id="inputNovedad" size="17" value='${usuario.descripcion_novedad}'>
</td>
</tr>
</table>
<center>
<input type="button" value="Definir Novedad" onclick="javascript:definirNovedad();">
&nbsp;&nbsp;
<input type="button" value="Cerrar" onclick="javascript:window.close();">
</center>
<br>

<c:if test="${not empty usuario.turno and usuario.turno != '-1' }" >

<c:if test="${not empty msg}">
<center><font color="red">${msg}</font></center>
<br>
</c:if>

<center>Enviar el turno del usuario al pool</center>
<table align="center">
<tr>
<td bgcolor="#b5b5b5">
Usuario del pool
</td>
<td>
<select id="selectPool" onchange="javascript:traerUsuarioPool();">
<option value="-1" >Seleccione:</option>
<c:forEach items="${listaPool}" var="userPool">
<%-- Esto es para controlar que no muestre el mismo usuario
	 si el usuario al que se le va a cambiar el turno es un usuario del pool.
 --%>
<c:if test="${userPool[0].id!=usuario.id}">
<option value="${userPool[0].id}" ${not empty usuarioPool and usuarioPool.id==userPool[0].id?'selected=selected ':''}>${userPool[0].nombre}</option>
</c:if>
</c:forEach>
</select>
</td>
</tr>
<tr>
<td bgcolor="#b5b5b5">Turno</td><td>${usuarioPool.turno=='-1'?'Sin turno':usuarioPool.turno}</td>
</tr>
<tr>
<td bgcolor="#b5b5b5">Horario</td>
<td>
<c:if test="${usuarioPool.turno !='-1'}" >
${turnoUsuarioPool.dias}-${turnoUsuarioPool.horas}
</c:if>
</td>
</tr>
<tr>
<td bgcolor="#b5b5b5">Sabado</td>
<td>
<c:if test="${usuarioPool.turno !='-1'}" >
${turnoUsuarioPool.dias=='L-S' or turnoUsuarioPool.dias=='L-D'?turnoUsuarioPool.horasSabado:'No Aplica'}
</c:if>
</td>
</tr>
<tr>
<td bgcolor="#b5b5b5">Domingo</td>
<td>
<c:if test="${usuarioPool.turno !='-1'}" >
${turnoUsuarioPool.dias=='L-D'?turnoUsuarioPool.horasDomingo:'No Aplica'}
</c:if>
</td>
</tr>
</table>

<center>
<c:if test="${not empty usuarioPool}">
<c:if test="${usuarioPool.turno!='-1'}">
<input type="button" value="Asignar Domingo" onclick="javascript:asignarDomingo();">
</c:if>
&nbsp;
<input type="button" value="Cambiar Turno" onclick="javascript:cambiarTurno();">
&nbsp;
<input type="button" value="Declinar Pool" onclick="javascript:declinarPool();">
</c:if>
</center>



</c:if>
<!-- para los botones tengo en cuenta:
- cambiar los turnos completamente entre los usuarios
- solo reemplazar el domingo
- si el usuarioPool ya tiene turno domingo colocarle declinar aunque el listado del pool
  ya deberia salir validado con esta regla



 -->


</body>
</html>
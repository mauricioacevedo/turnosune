<!-- inicioAsignacionTurnos.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaVistas" value="${requestScope.listaVistas}" />
<c:set var="turnosLibres" value="${requestScope.turnosLibres}" />
<c:set var="turnoSeleccionado" value="${requestScope.turnoSeleccionado}" />
<c:set var="usuarioSeleccionado" value="${requestScope.usuarioSeleccionado}" />
<c:set var="semana" value="${requestScope.semana}" />
<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />
<c:set var="grupoSelected" value="${requestScope.grupoSelected}" />
<%-- con esta variable ( grupoSelected2 ) verifico si se eligieron todos los probadores o no --%>
<c:set var="grupoSelected2" value="${requestScope.grupoSelected2}" />
<c:set var="msg" value="${requestScope.msg}" />
<%-- con este usuario controlo que grupos puede manejar o cuales no
	 no se utiliza el de la session como tal porke el objeto puede estar viejo!!!! OJO!
 --%>
<c:set var="usuarioSession" value="${requestScope.usuarioSession}" />


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Asignacion Turnos ( Semana ${semana}</title>

<script type="text/javascript">

function resetHistorico(){
	if(confirm("Se actualizara el historico de los agentes con la informacion actual\n"+
				"Desea continuar?")){
		location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=resetHistorico&grupoId=${grupoSelected.id}";			
	}
}

function actualizarInfo(usuario){
	// aca va separado por punto y coma el id de usuario y el id de turno.
	var turno=document.getElementById("selectTurnos"+usuario).value;
	if(turno=="-100")
		return;
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=mostrarInfo&ids="+turno+"&grupoId=${grupoSelected.id}";
}

function asignarTurno(usuario){
	// aca va separado por punto y coma el id de usuario y el id de turno.
	var turnoSelected=document.getElementById("selectTurnos"+usuario).value;
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=asignarTurno&ids="+turnoSelected+"&grupoId=${grupoSelected.id}";
}

function liberarTurno(usuario){
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=liberarTurno&idUser="+usuario+"&grupoId=${grupoSelected.id}";
}

function asignacionAutomatica(){
	var grupoSelected=document.getElementById("selectGrupos");
	var gr=grupoSelected.options[grupoSelected.selectedIndex].text;
	
	var conf=confirm("A continuacion se hace la rotacion de turnos para los usuarios del grupo "+gr+", desea continuar?");
	if(conf)
		location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=asignacionAutomatica&grupoId=${grupoSelected.id}";
}

function asignacionGeneral(){

	var conf=confirm("A continuacion se hace la rotacion de turnos para todos los grupos, desea continuar?");
	if(conf)
		location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=asignacionGeneral";
}


function traerGrupo(){
	
	var grupo=document.getElementById("selectGrupos").value;
	
	if(grupo=='-1')
		return;
		
	location.href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&grupoId="+grupo;
}

function inicioNovedad(idUser){
		
	var url="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=inicioNovedad&userId="+idUser+"&grupoId=${grupoSelected.id}";
	var win=window.open(url, 'Disponible','scrollbars=yes,resizable=yes,hotkeys=yes,height=400,width=400,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();	

}

</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center><h3>Asignacion Turnos ( Semana ${semana})</h3></center> 
${not empty msg?'<br><center><font color="red">':''}${msg}${not empty msg?'</font></center>':''}
<br>
<!--center><input type="button" value="Rotacion General" onclick="javascript:asignacionGeneral();"></center-->
<br>
<center>Seleccione un grupo de Trabajo
<select id="selectGrupos" onchange="javascript:traerGrupo();">
<option value="-1">Seleccione:</option>
<option value="todos" ${grupoSelected2=='todos'?'selected=selected':''}>Todos</option>
<c:forEach items="${listaGrupos}" var="grupo">
<option value="${grupo.id}" ${grupo.id==grupoSelected.id?'selected=selected':''}>${grupo.descripcion}</option>
</c:forEach>
</select>
&nbsp;
&nbsp;

<c:if test="${not empty usuarioSession.grupos_admin and fn:contains(usuarioSession.grupos_admin,grupoSelected.id)}">
	<c:if test="${empty grupoSelected2 and not empty grupoSelected}">
		<input type="button" value="Rotar este grupo" onclick="javascript:asignacionAutomatica();">
		&nbsp;<input type="button" value="Reset Historico" onclick="javascript:resetHistorico();">
	</c:if>
</c:if>
</center>

<c:if test="${not empty grupoSelected or not empty grupoSelected2}">

<table width="100%" align="center">
<tr bgcolor="red">
<td align="center"><b><font color="white">Usuario</font></b></td>
<td align="center"><b><font color="white">Rotacion</font></b></td>
<td align="center"><b><font color="white">Turno</font></b></td>
<td align="center"><b><font color="white">Horario</font></b></td>
<td align="center"><b><font color="white">Tipo</font></b></td>
<c:if test="${not empty usuarioSession.grupos_admin and fn:contains(usuarioSession.grupos_admin,grupoSelected.id)}">
	<c:if test="${empty grupoSelected2}">
		<td align="center"><b><font color="white">Operacion</font></b></td>
	</c:if>
</c:if>
</tr>

<c:set var="i" value="0" />

<c:forEach items="${listaVistas}" var="view">

<c:set var="bgcolor" value="${i%2 == 0?'':'#EDEDED'}" />

<c:set var="bgcolor" value="${view.novedadExcluyente?'#FFCFCD':bgcolor}" />
<c:set var="bgcolor" value="${usuarioSeleccionado==view.idUser?'#FFFBCD':bgcolor}" />


<tr bgcolor="${bgcolor}">
<td align="center">
<span title="${view.novedad}${view.descripcionNovedad!=''?':':''}${view.descripcionNovedad}">${view.nombre}</span>

</td>
<td align="center">${view.rotacion?"Si":"No"} Rota</td>
<td align="center">

<c:if test="${empty grupoSelected2}">

	<c:if test="${not view.novedadExcluyente}">

		<select id="selectTurnos${view.idUser}" onchange="javascript:actualizarInfo('${view.idUser}');" ${not empty usuarioSession.grupos_admin and fn:contains(usuarioSession.grupos_admin,grupoSelected.id)?'':'disabled'}>
		<%-- esto es para cuando el usuario ya tiene un turno asignado --%>
		<option value="-100">Sel.</option>
		<c:if test="${view.idTurno2 !=-1}">
		<option value="${view.idUser};${view.idTurno2}" selected=selected>${view.idTurno}</option>
		</c:if>
		
		
		<c:forEach items="${turnosLibres}" var="turno">
		<c:set var="sel" value="" />
		<c:if test="${turnoSeleccionado.id2==turno.id2 and usuarioSeleccionado==view.idUser}">
		<c:set var="sel" value="selected=selected" />
		</c:if>
		
		<option value="${view.idUser};${turno.id2}" ${sel}>${turno.id}</option>
		</c:forEach>
		</select>
	</c:if>
</c:if>
<c:if test="${not empty grupoSelected2}">
${view.idTurno2=='-1'?'Sin turno':view.idTurno}
</c:if>
</td>


<c:if test="${view.idTurno2 ==-1}">
	<td align="center">
	<c:if test="${usuarioSeleccionado==view.idUser}">
	${turnoSeleccionado.dias}, ${turnoSeleccionado.horas}
	</c:if>
	</td>
	<td align="center">
	<c:if test="${usuarioSeleccionado==view.idUser}">
	${turnoSeleccionado.tipo_turno}
	</c:if>
	
	<c:if test="${view.novedadExcluyente}">
	${view.novedad}:${view.descripcionNovedad}
	</c:if>	
	
	</td>
	
	
	
</c:if>
<c:if test="${view.idTurno2 !=-1}">
	
	<c:if test="${empty turnoSeleccionado}">
		<td align="center">
		${view.horario}
		</td>
		<td align="center">
		${view.tipo_usuario}
	</td>
	</c:if>
	
	<c:if test="${not empty turnoSeleccionado}">
		<td align="center">
		<c:if test="${usuarioSeleccionado==view.idUser}">
		${turnoSeleccionado.dias}, ${turnoSeleccionado.horas}
		</c:if>
		<c:if test="${usuarioSeleccionado!=view.idUser}">
		${view.horario}
		</c:if>
		
		</td>
		<td align="center">
		<c:if test="${usuarioSeleccionado==view.idUser}">
		${turnoSeleccionado.labores}
		</c:if>
		
		<c:if test="${usuarioSeleccionado!=view.idUser}">
		${view.labores}
		</c:if>
			
		</td>
	</c:if>
</c:if>
<c:if test="${not empty usuarioSession.grupos_admin and fn:contains(usuarioSession.grupos_admin,grupoSelected.id)}">
<c:if test="${empty grupoSelected2}">
<td>
	<c:if test="${not view.novedadExcluyente}">
		<input type="button" value="Asignar" onclick="javascript:asignarTurno('${view.idUser}');">
 		- <input type="button" value="Liberar" onclick="javascript:liberarTurno('${view.idUser}');">
 - 
 </c:if>
 <input type="button" value="Novedad" onclick="javascript:inicioNovedad('${view.idUser}');">
 </td>
 </c:if>
</c:if>
<!-- td><a href="">Asignar</a> - <a href="">Liberar</a></td-->
</tr>
<c:set var="i" value="${i+1}"/>
</c:forEach>

</table>

</c:if>
<%-- center><a href="${pageContext.request.contextPath}/action?accion=asignadorTurnos&operacion=inicioEnvioHorario">Enviar Horario</a></center--%>

</body>
</html>
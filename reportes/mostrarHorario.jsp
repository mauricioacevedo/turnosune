<!-- mostrarHorario.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listadoGruposUsuarios" value="${requestScope.listadoGruposUsuarios}" />
<c:set var="usuario" value="${requestScope.usuario2}" scope="request" />
<%--c:set var="turno" value="${requestScope.turno}" /--%>
<%--c:set var="turnosHistoricos" value="${requestScope.turnosHistoricos}" /--%>
<c:set var="infoSemanaActual" value="${requestScope.infoSemanaActual}" />
<c:set var="infoSiguienteSemana" value="${requestScope.infoSiguienteSemana}" />
<c:set var="semanaActual" value="${requestScope.semanaActual}" />
<c:set var="semanaSiguiente" value="${requestScope.semanaSiguiente}" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vista de turnos</title>
<script language="javascript">

function mostrarTurnoDetallado(historicoId){

	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=mostrarTurnoDetalladoHistorico&historicoId="+historicoId;

	var win=window.open(url, 'Turnos','scrollbars=yes,resizable=yes,hotkeys=yes,height=300,width=700,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();
}

function mostrarSimuladorTurno(idHistorico){
	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=inicioSimuladorTurnos&turnoHistorico="+idHistorico;

	var win=window.open(url, 'Turnos','scrollbars=no,resizable=yes,hotkeys=yes,height=450,width=500,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();
}

</script>
</head>
<body>
<!-- encabezado diferente para la pantalla de los muchachos -->
<jsp:include page="../headerAsesores.jsp" flush="true" />
<c:set var="idHistoricoUltimoTurno" value="ND" />
<center><h2>Turnos del Asesor ${usuario.nombre}</h2></center>
<br>

<!-- TABLA GENERAL -->
<table align="center" cellpadding="2" cellspacing="2">
<tr>
<!-- CODIGO DE LA PRIMERA SEMANA, SEMANA ACTUAL -->
<td align="center" width="50%" height="100%">
<c:if test="${not empty infoSemanaActual}" >

<font size="3"><b>Semana Actual ( semana ${semanaActual} )</b></font>
<br>
<table align="center" cellpadding="2" cellspacing="2" width="100%" height="100%">

<%-- ESTA ASIGNACION ES PARA PODER VISUALIZAR LA SIMULACION DE TURNOS A FUTURO. --%>
<c:set var="idHistoricoUltimoTurno" value="${infoSemanaActual.turnoId2}" />
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Turno</td>
		<td align='center' bgcolor='#EDEDED'>${infoSemanaActual.turnoId}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Labores</td>
		<td align='center' bgcolor='#EDEDED'>${infoSemanaActual.labores}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario General</td>
		<td align='center' bgcolor='#EDEDED'>${infoSemanaActual.dias} ${infoSemanaActual.horas_semana}</td>
		</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario sabado</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty infoSemanaActual.horas_sabado or infoSemanaActual.horas_sabado==''}">
			No Aplica
		</c:if>
		${infoSemanaActual.horas_sabado}
		</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario Domingo</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty infoSemanaActual.horas_domingo or infoSemanaActual.horas_domingo==''}">
		No Aplica
		</c:if>
		${infoSemanaActual.horas_domingo}
		</td>
	</tr>
		<tr>
		<td align='center' colspan='2' bgcolor='white'>
		<a href="javascript:mostrarTurnoDetallado('${infoSemanaActual.id}');"><font color="red">Ver Horario Detallado</font></a>		
		</td>
	</tr>
</table>
<br>

<br>
</c:if>

<c:if test="${empty infoSemanaActual}" >
<font color="red"><b>No hay turno asignado para la semana ${semanaActual}</b></font>
<br>Por favor comunicarse con su supervisor.
</c:if>
</td>

<!-- CODIGO DE LA PROXIMA SEMANA -->

<td align="center" width="50%" height="100%">
<c:if test="${not empty infoSiguienteSemana}" >

<font size="3"><b>Proxima semana ( semana ${semanaSiguiente} )</b></font>
<br>
<table align="center" cellpadding="2" cellspacing="2" width="100%" height="100%">

<%-- ESTA ASIGNACION ES PARA PODER VISUALIZAR LA SIMULACION DE TURNOS A FUTURO. --%>
<c:set var="idHistoricoUltimoTurno" value="${infoSiguienteSemana.turnoId2}" />
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Turno</td>
		<td align='center' bgcolor='#EDEDED'>${infoSiguienteSemana.turnoId}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Labores</td>
		<td align='center' bgcolor='#EDEDED'>${infoSiguienteSemana.labores}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario General</td>
		<td align='center' bgcolor='#EDEDED'>${infoSiguienteSemana.dias} ${infoSiguienteSemana.horas_semana}</td>
		</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario sabado</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty infoSiguienteSemana.horas_sabado or infoSiguienteSemana.horas_sabado==''}">
			No Aplica
		</c:if>
		${infoSiguienteSemana.horas_sabado}
		</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario Domingo</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty infoSiguienteSemana.horas_domingo or infoSiguienteSemana.horas_domingo==''}">
		No Aplica
		</c:if>
		${infoSiguienteSemana.horas_domingo}
		</td>
	</tr>

	<tr>
		<td align='center' colspan='2' bgcolor='white'>
		<a href="javascript:mostrarTurnoDetallado('${infoSiguienteSemana.id}');">Ver Horario Detallado</a>		
		</td>
	</tr>


</table>
<br>

<br>

</c:if>

<c:if test="${empty infoSiguienteSemana}" > 
<font color="red"><b>Aun no hay asignado turno para la siguiente semana ( ${semanaSiguiente} )</b></font>
<br>Por favor comunicarse con su supervisor inmediato si es del caso.
</c:if>
</td>

</tr>
</table>

<br>

	<center><a href="javascript:mostrarSimuladorTurno('${idHistoricoUltimoTurno}');">Simulacion de turnos</a></center>
<br>

</body>
</html>
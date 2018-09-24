<!-- simuladorTurnos.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="userr" value="${requestScope.usuario}" scope="request" />
<c:set var="semana" value="${requestScope.semana}" scope="request" />
<c:set var="turno" value="${requestScope.proximoTurno}" scope="request" />
<c:set var="semanaActual" value="${requestScope.semanaActual}" scope="request" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vista de turnos</title>
<script language="javascript">

function mostrarTurnoDetallado(historicoId){

	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=mostrarTurnoDetalladoHistorico&historicoId="+historicoId;

	var win=window.open(url, 'Turnos','scrollbars=no,resizable=yes,hotkeys=yes,height=300,width=700,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();
}

function mostrarSimuladorTurno(){
	
	var semana = document.getElementById("semana").value;
	if(isNaN(semana)){
		alert("Por favor ingrese una semana valida, numeros entre 1 y 54");
		return;
	}
	if(semana<1||semana>54){
		alert("Por favor ingrese una semana valida, numeros entre 1 y 54");
		return;
	}
	//verifico si es menor a la semana actual, si es menor no se debe permitir
	var semanaActual=${semanaActual};
	if(semana<semanaActual){
		alert("Por favor ingrese una semana futura.");
		return;
	}	
	
	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=inicioSimuladorTurnos&semana="+semana;

	location.href=url;	
}

</script>
</head>
<body>

<c:set var="idHistoricoUltimoTurno" value="ND" />
<center><h2>Simulador de Turnos</h2></center>
<br>

<!-- TABLA GENERAL -->
<table align="center" cellpadding="2" cellspacing="2">
<tr>
<!-- CODIGO DE LA PRIMERA SEMANA, SEMANA ACTUAL -->
<td align="center" width="50%" height="100%">

<font size="3"><b>Ingrese la semana</b></font>
<input type="text" id="semana" size="2" value="${semana}">
 <input type="button" value="Consultar" name="con" size="2" onclick="javascript:mostrarSimuladorTurno();">
<br><br>
<table align="center" cellpadding="2" cellspacing="2" width="60%" height="220">

<%-- ESTA ASIGNACION ES PARA PODER VISUALIZAR LA SIMULACION DE TURNOS A FUTURO. --%>
<c:set var="idHistoricoUltimoTurno" value="${infoSemanaActual.id}" />
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Turno</td>
		<td align='center' bgcolor='#EDEDED'>${turno.id}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Labores</td>
		<td align='center' bgcolor='#EDEDED'>${turno.labores}</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario General</td>
		<td align='center' bgcolor='#EDEDED'>${turno.dias} ${turno.horas}</td>
		</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario sabado</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty turno.horasSabado or turno.horasSabado==''}">
			No Aplica
		</c:if>
		${turno.horasSabado}
		</td>
	</tr>
	<tr>
		<td align='center' bgcolor='#B5B5B5'>Horario Domingo</td>
		<td align='center' bgcolor='#EDEDED'>
		<c:if test="${empty turno.horasDomingo or turno.horasDomingo==''}">
		No Aplica
		</c:if>
		${turno.horasDomingo}
		</td>
	</tr>
		<tr>
		<td align='center' colspan='2' bgcolor='white'>
		
		<!--a href="javascript:mostrarTurnoDetallado('${turno.id2}');"><font color="red">Ver Horario Detallado</font></a-->		
		</td>
	</tr>
</table>
<br>
<input type="button" value="Cerrar" onclick="javascript:window.close();">
<br>
</body>
</html>
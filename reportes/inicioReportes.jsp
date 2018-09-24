
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reportes - Une-EPM TELCO</title>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center>Reportes</center>
<br>
<table align="center" width="40%">
<tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=establecerTurnos">Establecer Turnos</a></td></tr>
<!--  tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=mostrarHorario">Listado de Turnos</a></td></tr-->
<tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=inicioHistorialTurnos">Historial de turnos</a></td></tr>
<tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=inicioMallaTurnos">Malla de turnos</a></td></tr>
<tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=inicioAutorizacionIngreso">Autorizacion de Ingreso</a></td></tr>
<tr><td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=inicioBuscarRecursohora">Recurso por hora</a></td></tr>
<tr><td></td></tr>
</table>
</body>
</html>
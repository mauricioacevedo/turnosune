<!-- inicioTurnos.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaTurnos" value="${requestScope.listaTurnos}" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Turnos - Une-EPM TELCO</title>

<script type="text/javascript">

function eliminarTurno(id){
	var conf=confirm("Se eliminara el turno "+id+" \nDesea continuar?");
	
	if(conf){
		location.href="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=eliminarTurno&idTurno="+id;
	}
}

</script>

</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center><h3>Turnos</h3></center> 

<p></p>
<center> <a href='${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=agregarTurno'>Agregar Turno</a></center>
<p></p>
<table width="80%" align="center" border="0">
<tr bgcolor="red">
<td align="center"><b><font color="white">Turno</font></b></td>
<td align="center"><b><font color="white">Dias</font></b></td>
<td align="center"><b><font color="white">Horas</font></b></td>
<td align="center"><b><font color="white">Tipo</font></b></td>
<td align="center"><b><font color="white">Estado</font></b></td>
<td align="center"><b><font color="white">Grupo</font></b></td>
<td align="center"><b><font color="white">Operacion</font></b></td>
</tr>
<c:set var="i" value="0" />
<c:forEach items="${listaTurnos}" var="turno">

<tr bgcolor="${i%2 == 0? '' :'#EDEDED'}">
<td align="center">${turno.id}</td>
<td align="center">${turno.dias}</td>
<td align="center">${turno.horas}</td>
<td align="center">${turno.tipo_turno}</td>
<td align="center">${turno.estado==-1?"No ":""}Asignado</td>
<td align="center">${turno.grupoId==-1?"Sin Grupo":turno.grupoId}</td>
<td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=modificarTurno&idTurno=${turno.id2}">Modificar</a><!-- a href="javascript:eliminarTurno('${turno.id2}');">Eliminar</a --></td>
</tr>
<c:set var="i" value="${i+1}"/>
</c:forEach>

</table>
</body>
</html>
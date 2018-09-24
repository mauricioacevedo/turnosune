<!-- historialTurnos.jsp  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />
<c:set var="listaYears" value="${requestScope.listaYears}" />
<c:set var="listaSemanas" value="${requestScope.listaSemanas}" />

<c:set var="listaGruposAMostrar" value="${requestScope.listaGruposAMostrar}" />
<c:set var="user" value="${requestScope.user}" />

<%-- esta variable tendra una lista con los grupos que se van a mostrar, si son todos contendra
	 todos los grupos, si es uno solo solo contendra un grupo, asi se generaliza el reporte.
 --%>

<c:set var="grupoSelected" value="${requestScope.grupoSelected}" />
<c:set var="grupoSelected2" value="${requestScope.grupoSelected2}" />
<c:set var="semanaRequest" value="${requestScope.semana}" />
<c:set var="yearRequest" value="${requestScope.year}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Historial de Turnos</title>

<script type="text/javascript">

function traerGrupo(){
	
	var grupo=document.getElementById("selectGrupos").value;
	
	if(grupo=='-1')
		return;
	
	var semana = document.getElementById("selectSemanas").value;
	var year = document.getElementById("selectYears").value;
	
	location.href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=getHistorialGrupo&grupoId="+grupo+"&year="+year+"&semana="+semana;
}

function editarTurnoHistorico(id_historial){

	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=modificarTurnoHistorico&turnoHistorico="+id_historial;

	location.href=url;
}

</script>

</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center>Historial de Turnos</center> 
<br>


<table align="center">
<tr>
<td align="center">
Seleccione un grupo:&nbsp;
<select id="selectGrupos">
<option value="-1">Seleccione:</option>
<option value="todos" "${grupoSelected2=='todos'?'selected=selected':''}">Todos</option>
<c:forEach items="${listaGrupos}" var="grupo">
<option value="${grupo.id}" "${grupo.id==grupoSelected.id?'selected=selected':''}">${grupo.descripcion}</option>
</c:forEach>
</select>
</td>
<td align="center">Año:&nbsp;
<select id="selectYears">
<c:forEach items="${listaYears}" var="year">
<option value="${year}" ${year==yearRequest?'selected=selected':''}>${year}</option>
</c:forEach>
</select>
</td>
<td align="center">Semana:&nbsp;
<select id="selectSemanas">
<option value="actual" ${semanaRequest=='actual'?'selected=selected':''}>Plantilla Actual</option>
<c:forEach items="${listaSemanas}" var="semana">
<option value="${semana}" ${semanaRequest==semana?'selected=selected':''}>${semana}</option>
</c:forEach>
</select>
</td>
<td align="center">
<input type="button" value="Consultar" onclick="javascript:traerGrupo();"> 
</td>
</tr>
</table>


<br><br>

<table width="100%" align="center">
<tr bgcolor="#B5B5B5">
<td align="center">Registro</td>
<td align="center">Nombre</td>
<td align="center">Turno</td>
<td align="center">Dias</td>
<td align="center">Horario</td>
<td align="center">Actividad</td>
<td align="center">Novedades</td>
<td align="center">Grupo de Trabajo</td>
</tr>

<c:forEach items="${listaGruposAMostrar}" var="grupo2show">

<c:set var="listaDatos" value="${grupo2show.elementosAsociados}" />

<c:forEach items="${listaDatos}" var="row">
<tr bgcolor="#EDEDED">
<td align="center">${row[0].registro}</td>
<td align="center">${row[0].nombre}</td>
<!-- la idea es que se puedan modificar los historicos -->
<td align="center">
<c:set var="id_historico" value="${row[2]}" />

<c:if test="${not empty id_historico}">
<a href="javascript:editarTurnoHistorico('${id_historico}');">
</c:if>
${row[1].id}
<c:if test="${not empty id_historico}">
</a>
</c:if>
</td>

<td align="center">${row[1].dias}</td>
<td align="center">${row[1].horas}</td>
<td align="center">${row[1].labores}</td>
<td align="center">${row[0].novedad}</td>
<td align="center">${grupo2show.descripcion}</td>
</tr>
</c:forEach>

</c:forEach>
</table>

</body>
</html>
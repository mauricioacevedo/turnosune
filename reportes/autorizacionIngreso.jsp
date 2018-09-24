<!-- autorizacionIngreso.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />
<c:set var="listaUsers" value="${requestScope.listaUsers}" />
<c:set var="listaUsuariosPorGrupo" value="${requestScope.listaUsuariosPorGrupo}" />
<c:set var="grupoSelected" value="${requestScope.grupoSelected}" />
<c:set var="listaVistas" value="${requestScope.listaVistas}" />

<c:set var="listaYears" value="${requestScope.listaYears}" />
<c:set var="listaSemanas" value="${requestScope.listaSemanas}" />
<c:set var="semanaRequest" value="${requestScope.semana}" />
<c:set var="yearRequest" value="${requestScope.year}" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Autorizacion de entrada a Gestion Daños</title>

<script type="text/javascript">

	function reiniciarForma(){
		var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=reiniciarFormaAutorizacion";
		var selYears=document.getElementById("selectYears").value;
		var selSemanas=document.getElementById("selectSemanas").value;
		
		 url+="&semana="+selSemanas+"&year="+selYears;
		
		location.href=url;
	}

	function traerGrupo(){
		
		var sel=document.getElementById("selectGrupos").value;
		var selYears=document.getElementById("selectYears").value;

		var selSemanas=document.getElementById("selectSemanas").value;
		
		var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=traerUsuariosPorGrupo";
		url+="&grupoId="+sel+"&semana="+selSemanas+"&year="+selYears;
		
		location.href=url;
	}
	
	function agregarUsuario(){
		//alert("llego");
		var id=document.getElementById("selectUsuarios").value;
		var selYears=document.getElementById("selectYears").value;
		var selSemanas=document.getElementById("selectSemanas").value;
		
		var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=agregarUsuarioAutorizacion";
		url+="&userId="+id+"&semana="+selSemanas+"&year="+selYears;
		
		location.href=url;
	}

	function agregarGrupo(){
		//alert("llego");
		var sel=document.getElementById("selectGrupos").value;
		var selYears=document.getElementById("selectYears").value;
		var selSemanas=document.getElementById("selectSemanas").value;
		
		var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=agregarGrupoAutorizacion";
		url+="&grupoId="+sel+"&semana="+selSemanas+"&year="+selYears;
		
		location.href=url;
	}
	
	function generarReporte(){
		
		var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=exportarAutorizacion&pantalla=reporteAutorizacion";
		location.href=url;
	}

</script>

</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center>Autorizacion de Ingreso para fin de semana y Festivos</center>
<br>

<table align="center">
<tr>
<td align="center">Año:&nbsp;
<select id="selectYears">
<c:forEach items="${listaYears}" var="year">
<option value="${year}" ${year==yearRequest?'selected=selected':''}>${year}</option>
</c:forEach>
</select>
</td>
<td align="center">Semana:&nbsp;
<select id="selectSemanas" onchange="javascript:reiniciarForma();">
<c:forEach items="${listaSemanas}" var="semana">
<option value="${semana}" ${semanaRequest==semana?'selected=selected':''}>${semana}</option>
</c:forEach>
</select>
</td>

</tr>
</table>



<table width="100%">

<tr>
<td align="center" width="25%">Semana</td>
<td align="center" width="75%" rowspan="3">
</td>
</tr>
<tr>
<td align="center" width="25%">Grupos de Trabajo</td>
<td align="center" width="25%">Usuarios fin de semana</td>
<td align="center" width="25%">&nbsp;</td>
<td align="center" width="25%">&nbsp;</td>
</tr>
<tr>

<td align="center" width="25%">

<select id="selectGrupos" multiple="multiple" onchange="javascript:traerGrupo();" size="12">
<c:forEach items="${listaGrupos}" var="grupo">
<option value="${grupo.id}" ${grupoSelected.id==grupo.id ?'selected=selected':''}>${grupo.descripcion}</option>
</c:forEach>
</select>
</td>
<td align="center" width="25%">
<select id="selectUsuariosSistema" multiple="multiple" disabled="disabled" size="12">
<c:forEach items="${listaUsuariosPorGrupo}" var="useryturno">
<option value="${useryturno[0].id}">${useryturno[0].nombre}</option>
</c:forEach>
</select>
</td>
<td align="center" width="25%">------------</td>
<td align="center" width="25%">



<select id="selectUsuarios" multiple="multiple" size="12">
<c:forEach items="${listaUsers}" var="user">
<option value="${user.id}">${user.nombre}</option>
</c:forEach>
</select>
</td>
</tr>

<tr>
<td align="center" colspan="2"><input type="button" value="Agregar Grupo" onclick="javascript:agregarGrupo();"></td>

<td align="center" colspan="2"><input type="button" value="Agregar Usuario" onclick="javascript:agregarUsuario();" ></td>
</tr>
</table>


<br>


<table align="center" width="100%">
<tr bgcolor="#B5B5B5">
<td rowspan="2" align="center"><b>Nombre</td>
<td rowspan="2" align="center"><b>Registro</td>
<td rowspan="2" align="center"><b>Turno</td>
<td colspan="2" align="center"><b>Horario</td>
<td rowspan="2" align="center"><b>Actividad</td>
<td rowspan="2" align="center"><b>Observaciones</td>
</tr>
<tr bgcolor="#B5B5B5">
<td align="center"><b>Sabado</td>
<td align="center"><b>Domingo<br><b>Festivo</td>
</tr>

<c:forEach items="${listaVistas}" var="view">

<tr  bgcolor="#EDEDED">
<td align="center">${view.nombre}</td>
<td align="center">${view.registro}</td>
<td align="center">${view.turno}</td>
<td align="center">${view.horarioSabado}</td>
<td align="center">${view.horarioDomingo}</td>
<td align="center">${view.actividad}</td>
<td align="center">${view.observaciones}</td>
</tr>

</c:forEach>

</table>
<br>

<center><input type="button" value="Generar Reporte" onclick="javascript:generarReporte();"></center> 


</body>
</html>
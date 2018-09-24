<!-- definirHorario.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listasCorreo" value="${requestScope.listasCorreo}" />
<c:set var="dispon" value="${requestScope.dispon}" />
<c:set var="semana" value="${requestScope.semana}" />
<c:set var="year" value="${requestScope.year}" />
<c:set var="gruposUsuario" value="${requestScope.gruposUsuario}" />


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Horarios - Une-EPM TELCO</title>
<script type="text/javascript">
function enviarHorario(){
	
	var semana=document.getElementById("semana").value;
	var year=document.getElementById("year").value;
	if(isNaN(semana)){
		alert("Ingrese solo cantidades numericas para la semana");
		return;
	}
	if(isNaN(year)){
		alert("Ingrese solo cantidades numericas para el año");
		return;
	}
	
	var selectGrupos=document.getElementById("selectGrupos");
	var grupo="";
	var gruposActualizar="";
	for (var i=0;i < selectGrupos.options.length;i++){
		if (selectGrupos.options[i].selected){
			grupo += selectGrupos.options[i].value+",";
			gruposActualizar += selectGrupos.options[i].text+",";
		}
	}
	
	if(!confirm("Se actualizara el horario de los grupos \n"+
		gruposActualizar+"\nPara la semana "+semana+" de "+year)){
		return;
	}
	
	var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=doDefinirHorario&semana="+semana+"&year="+year+"&gruposActualizar="+grupo;
	
	location.href=url;
}

function seleccionarLista(){
	var listaSelected=document.getElementById("selectListas").value;
	
	var inputListas=document.getElementById("correos");
	
	var delimitador="";
	if(inputListas.value==""){
		delimitador="";
	} else {
		delimitador=",";
	}
	
	if(inputListas.value.indexOf(inputListas)!=-1){
		return;
	}
	
	inputListas.value=inputListas.value+delimitador+listaSelected;
}

function editarDisponible(){
	var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=modificarInfoDisponible";
	var win=window.open(url, 'Disponible','scrollbars=yes,resizable=yes,hotkeys=yes,height=400,width=300,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();	
	
}

</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />

<table width="300" align="center">
<tr>
<td colspan="2" align="center">Establecer Malla de Turnos</td>
</tr>
<tr>
<td width="30%">Año</td><td><input type="text" id="year" size="15" value="${year}"></td>
</tr>
<tr>
<td width="30%">Semana</td><td><input type="text" id="semana" size="15" value="${semana}"></td>
</tr>
<tr>
<td width="30%">Disponible</td><td><a href="javascript:editarDisponible();">editar</a></td>
</tr>

<tr>
<td width="30%">Grupos a Actualizar</td>
<td>
<select id="selectGrupos" multiple="multiple">
<c:forEach items="${gruposUsuario}" var="grupo">
<option value="${grupo.id}" "selected=selected">${grupo.descripcion}</option>
</c:forEach>
</select>
</td>
</tr>
</table>
<br>
<center><input type="button" value="enviar" onclick="javascript:enviarHorario();"></center>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="idDisponible" value="${requestScope.idDisponible}" />
<c:set var="celular" value="${requestScope.celular}" />
<c:set var="fijo" value="${requestScope.fijo}" />
<c:set var="year" value="${requestScope.year}" />
<c:set var="semana" value="${requestScope.semana}" />
<c:set var="mail" value="${requestScope.mail}" />
<c:set var="cargo" value="${requestScope.cargo}" />
<c:set var="disponibles" value="${requestScope.disponibles}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Informacion Disponible</title>
<script type="text/javascript">
function guardarInfo(){
	var idDisponible=document.getElementById("selectDisponibles");
	var celular=document.getElementById("celular").value;
	var fijo=document.getElementById("fijo").value;
	var cargo=document.getElementById("cargo").value;
	var year=document.getElementById("year").value;
	var semana=document.getElementById("semana").value;

	if(idDisponible.value==''){
		alert("Ingrese el nombre del disponible");
		nombre.focus();
		return;
	}
	
	var parametros="&idDisponible="+idDisponible.value+"&celular="+celular+"&fijo="+fijo+"&cargo="+cargo+"&semana="+semana+"&year="+year;
	location.href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=doModificarInfoDisponible"+parametros;
}
</script>
</head>
<body>
<br>
<center>Informacion del Disponible</center>
<br>
<table align="center" width="100%">
<tr>
<td>Nombre</td><td>

<select id="selectDisponibles">

<c:forEach items="${disponibles}" var="dispon">
<option value="${dispon.id}" ${dispon.id == idDisponible ?'selected=selected':''} >${dispon.nombre}</option>
</c:forEach>

</select>

</td>
</tr>
<tr>
<td>Telefono Celular</td><td><input type="text" id="celular" value="${celular}"></td>
</tr>
<tr>
<td>Telefono Fijo</td><td><input type="text" id="fijo" value="${fijo}"></td>
</tr>
<tr>
<td>Cargo</td><td><input type="text" id="cargo"  value="${cargo}"></td>
</tr>
<tr>
<td>Año</td><td><input type="text" id="year"  value="${year}"></td>
</tr>
<tr>
<td>Semana</td><td><input type="text" id="semana"  value="${semana}"></td>
</tr>
</table>
<br>
<center><input type="button" value="Guardar" onclick="javascript:guardarInfo();">&nbsp;&nbsp;<input type="button" value="Cancelar" onclick="javascript:window.close();"></center>

</body>
</html>
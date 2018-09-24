<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="group" value="${requestScope.group}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${empty group?"Nuevo":"Modificar"} Grupo de Trabajo - Turnos Une-EPM TELCO</title>
<script type="text/javascript">

	function agregarGrupo(){
		var texto=document.getElementById("desc").value;
		var subdir=document.getElementById("subdirecciones").value;
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=doAgregarGrupo";
		url+="&descripcion="+texto+"&subdir="+subdir;
		location.href=url;
	}
	
	function modificarGrupo(){
		var texto=document.getElementById("desc").value;
		var subdir=document.getElementById("subdirecciones").value;
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=doModificarGrupo";
		url+="&descripcion="+texto+"&idGroup=${group.id}"+"&subdir="+subdir;
		location.href=url;
	}
	
	function regresarInicioGrupos(){
		location.href="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=inicioGruposTrabajo";	
	}

	function ventanaUsuarios(){
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=asignarUsuariosAGrupo&grupoId=${group.id}";
		var wind=window.open(url, 'Usuarios','scrollbars=yes,resizable=yes,hotkeys=yes,height=600,width=600,left=100,top=50,menubar=yes,toolbar=no');
		wind.focus();
	}
	function ventanaTurnos(){
		var url="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=asignarTurnosAGrupo&grupoId=${group.id}";
		var wind=window.open(url, 'Turnos','scrollbars=yes,resizable=yes,hotkeys=yes,height=600,width=600,left=100,top=50,menubar=yes,toolbar=no');
		wind.focus();
	}
</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center>${empty group?"Nuevo":"Modificar"} Grupo de Trabajo</center>

<br>
<table align="center" width="40%">
<tr>
<td align="center">Ingrese la descripcion del grupo</td>
<td align="center"><textarea id="desc" rows="3" cols="20">${group.descripcion}</textarea></td>
</tr>

<tr>
<td align="center">Subdireccion</td>
<td align="center">

<select id="subdirecciones">

	<option value="2" ${group.subdireccionId=='2'?' selected=selected':''}>Instalaciones</option>
	<option value="3" ${group.subdireccionId=='3'?' selected=selected':''}>Mesa de Ayuda Reparaciones</option>
	<option value="1" ${group.subdireccionId=='1'?' selected=selected':''}>Nivel 2 Reparaciones</option>

</select>

</td>
</tr>

<c:if test="${not empty group}">
<tr>
<td align="center"><a href="javascript:ventanaUsuarios();">Agregar Usuarios</a></td>
<td align="center"><a href="javascript:ventanaTurnos();">Agregar Turnos</a></td>
</tr>
</c:if>
</table>
<br>
<center><input type="button" value="${empty group?"Agregar":"Modificar"}" onclick="javascript:${empty group?'agregar':'modificar'}Grupo();">&nbsp;&nbsp;<input type="button" value="cancelar" onclick="javascript:regresarInicioGrupos();"></center>
<center></center>
</body>
</html>

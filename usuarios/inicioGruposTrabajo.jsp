<!-- inicioGruposTrabajo.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Grupos de Trabajo - Une-EPM TELCO</title>
<script type="text/javascript">

function eliminarGrupo(id){
	var confirma=confirm("Se eliminara el grupo "+id+", desea continuar?");
	
	if(confirma){
		location.href="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=eliminarGrupo&idGrupo="+id;
	}
}

</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center><h3>Grupos de Trabajo</h3></center> 
<p></p>
<center>
<a href='${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=agregarGrupo'>Agregar Grupo</a>
</center>
<p></p>
<table width="70%" align="center">
<tr bgcolor="red">
<td align="center"><b><font color="white">Id</font></b></td>
<td align="center"><b><font color="white">Descripcion</font></b></td>
<td align="center"><b><font color="white">Usuarios</font></b></td>
<td align="center"><b><font color="white">Turnos</font></b></td>
<td align="center"><b><font color="white">Opciones</font></b></td>
</tr>
<c:set var="i" value="0" />
<c:forEach items="${listaGrupos}" var="grupo" >
<tr bgcolor="${i%2 == 0? '' :'#EDEDED'}">
<td align="center">${grupo.id}</td>
<td align="center">${grupo.descripcion}</td> 
<td align="center">${grupo.numUsers}</td>
<td align="center">${grupo.numTurnos}</td>
<td align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=modificarGrupo&idGrupo=${grupo.id}">Modificar</a>-°-<a href="javascript:eliminarGrupo('${grupo.id}');">Eliminar</a></td>
</tr>
<c:set var="i" value="${i+1}"/>
</c:forEach>
</table>

</body>
</html>
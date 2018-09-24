<!-- inicioUsuarios.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaUsuarios" value="${requestScope.listaUsuarios}" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Usuarios - Une-EPM TELCO</title>
<script type="text/javascript">
function eliminarUsuario(id,nombre){
	var conf=confirm("Esta seguro que desea eliminar el usuario "+nombre+" ?");
	
	if(conf){
		location.href="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=eliminarUsuario&idUser="+id;
	}	
}
</script>
</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center><h3>Usuarios</h3></center> 

<p></p>
<center>
<a href='${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=agregarUsuario'>Agregar Usuario</a>
&nbsp;&nbsp;

</center>
<p></p>
<table width="100%" align="center" border="0">
<tr bgcolor="red">
<!--  td align="center">Id</td-->
<td align="center"><b><font color="white">Nombre</font></b></td>
<td align="center"><b><font color="white">Turno</font></b></td>
<td align="center"><b><font color="white">Novedad</font></b></td>
<td align="center"><b><font color="white">Rotacion</font></b></td>
<td align="center"><b><font color="white">User Name</font></b></td>
<td align="center"><b><font color="white">Operacion</font></b></td>
</tr>
<c:set var="i" value="0" />
<c:forEach items="${listaUsuarios}" var="usuario">


<tr bgcolor="${i%2 == 0? '' :'#EDEDED'}">
<%-- td align="center">${usuario.id}</td--%>
<td align="center">${usuario.nombre}</td>
<td align="center">${usuario.turno==-1?'Sin turno':usuario.turno}</td>
<td align="center"><span title="${usuario.descripcion_novedad}">${usuario.novedad != ''?usuario.novedad:'Sin novedad'}</span></td>
<td align="center">${usuario.rotacion?"Si ":"No "}Rota</td>

<td align="center">${usuario.nick}</td>
<td align="center">
<c:if test="${usuario.nick !='admin'}" >
<a href="${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=modificarUsuario&idUser=${usuario.id}">Modificar</a>

<!-- a href="javascript:eliminarUsuario('${usuario.id}','${usuario.nombre}');">Eliminar</a-->
</c:if>
</td>
</tr>
<c:set var="i" value="${i+1}"/>
</c:forEach>

</table>
</body>
</html>
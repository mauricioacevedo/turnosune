<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/turnos.css">

<div aling><img src="imagenes/cabecera.png" height="141" width="888"></center>
<table width="100%">
<c:set var="fechaCompletaHeader" value="${requestScope.fechaCompletaHeader}" />
<tr>
<td width="40%" align="center"><b>${fechaCompletaHeader}</b></td>
<td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=asignadorTurnos">Asignacion</a></td>
<td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorUsuarios">Usuarios</a></td>
<td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorTurnos">Turnos</a></td>
<td width="10%" align="center"><a href='${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=inicioGruposTrabajo'>Grupos de Trabajo</a></td>
<td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=gestorReportes">Reportes</a></td>

<!--td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=configuracion">Configuracion</a></td-->

<td width="10%" align="center"><a href="${pageContext.request.contextPath}/action?accion=salir">Salir</a></td>
</tr>
</table>
<br><br>
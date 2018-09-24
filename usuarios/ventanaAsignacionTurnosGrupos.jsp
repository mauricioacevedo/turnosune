<!-- ventanaAsignacionTurnosGrupos.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" scope="session" />

<c:set var="listaTurnos" value="${requestScope.listaTurnos}" />
<c:set var="grupo" value="${requestScope.grupo}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Asignacion de Turnos - Une-EPM TELCO</title>
<script type="text/javascript">

function enviarSeleccion(){
	//este codigo verifica los cambios efectuados sobre los usuarios y envia a realizar solo los usuarios
	//que tuvieron cambios en su configuracion.
	
	
	<c:set var="lista" value="" />
	<c:forEach items="${listaTurnos}" var="turno">
	<c:set var="lista" value="${lista}${turno.id2},${turno.grupoId};" />
	</c:forEach>
	
	var values="${lista}";
	
	var lis=values.split(";");
	
	var valoresRequest="";
	
	for( i=0;i<lis.length;i++){
		if(lis[i]=="")
			continue;
	
		var values2=lis[i].split(",");
		var id=values2[0];
		var grupo=values2[1];
		
		var check=document.getElementById("check"+id);	
		
		// este usuario no cambio y no pertenecia a este grupo
		if(grupo==-1&&!check.checked){
			//alert("el usuario no tenia grupo inicialmente, osea no cambio");
			continue;
		}
		// este usuario no cambio y sigue perteneciendo a este grupo
		if(grupo=='${grupo.id}'&&check.checked){
			//alert("el usuario tenia grupo inicialmente, osea no cambio tampoco");
			continue;
		}
		//si llego hasta aca significa que este usuario fue modificado, lo agrego a la lista que
		//se ira por el request.
		
		var estado="";
		if(check.checked)
			estado='${grupo.id}';
		else
			estado='-1';
		valoresRequest+=id+","+estado+";";
		
	}
	
	
	location.href='${pageContext.request.contextPath}/action?accion=gestorUsuarios&operacion=doAsignarTurnosAGrupo&valores='+valoresRequest+"&grupo=${grupo.id}";
	
}

</script>
</head>
<body>
<center>Asignacion de Turnos al grupo ${grupo.descripcion}</center>
<br>
<table align="center" width="80%">
<tr bgcolor="gray">
<td align="center">Selecion</td>
<td align="center">Id</td>
<td align="center">Horario</td>
<td align="center">Labores</td>
</tr>

<c:forEach items="${listaTurnos}" var="turno">
<tr bgcolor="#DFDFDF">
<td align="center"><input type="checkbox" id="check${turno.id2}" ${turno.grupoId==grupo.id?"checked='true'":""}></td>
<td align="center">${turno.id}</td>
<td align="center">${turno.dias} - ${turno.horas}</td>
<td align="center">${turno.labores}</td>
</tr>
</c:forEach>
</table>
<br>
<center>
<input type="button" value="Enviar" onclick="javascript:enviarSeleccion();">
&nbsp;&nbsp;
<input type="button" value="Cancelar" onclick="javascript:window.close();">
</center>
</body>
</html>
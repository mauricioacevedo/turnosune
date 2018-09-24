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
<meta http-equiv="refresh" content="60;${pageContext.request.contextPath}/action?<% out.print(request.getQueryString()); %>">
<title>Estado del recurso</title>      

<script type="text/javascript">

function traerGrupo(){
	
	var grupo=document.getElementById("selectGrupos").value;
	
	if(grupo=='-1')
		return;
	
	var semana = document.getElementById("selectSemanas").value;
	var year = document.getElementById("selectYears").value;
	
	location.href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=getInfoRecursoHora&grupoId="+grupo+"&dia=${dia}&year="+year+"&semana="+semana;
}

function editarTurno(idTurno){
	var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=editarTurno&turnoId="+idTurno;
	var win=window.open(url, 'Disponible','scrollbars=yes,resizable=yes,hotkeys=yes,height=400,width=500,left=100,top=50,menubar=yes,toolbar=no');
	win.focus();
}

function getDia(dia){

	var grupo="${empty grupoSelected2?grupoSelected.id:'todos'}";
	
	var semana = document.getElementById("selectSemanas").value;
	var year = document.getElementById("selectYears").value;
	location.href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=getMallaGrupo&grupoId="+grupo+"&dia="+dia+"&year="+year+"&semana="+semana;
}

function actualizarTotales(){
	var horas="";
	for ( i=6; i< 22;i++ ) {
		var array = new Array(4);
		array[0]="00";
		array[1]="15";
		array[2]="30";
		array[3]="45";
		
		var hora=(i<=9?"0":"")+i;
		
		for(j=0;j<4;j++){
			var hora2=hora+":"+array[j];
			var dib=document.getElementsByName("d"+hora2);
			//if(j==0) alert(dib.length+"-"+hora2);
			
			//var divv= document.getElementById("d"+hora2);
			//if(j==0) alert(divv.innerHTML);
			
			var totalDescanso=0;
			var totalRecurso=0;
			for (var k=0; k<dib.length; k++) {
      			var di=dib[k];
      			
      			var estado=di.innerHTML;
      			if(estado=='-'){
      				//no hay recurso, no hay que medir
      			} else if(estado=='T'){
      				totalRecurso = totalRecurso+1;
      			} else if(estado=='P'){
      				totalRecurso = totalRecurso+1;
      				totalDescanso = totalDescanso + 1;
      			} else if(estado=='A'){
      				totalRecurso = totalRecurso+1;
      				totalDescanso = totalDescanso + 1;
      			}
			}
			
			var divTotalDescanso=document.getElementById("desc"+hora2);
			var divTotalRecurso=document.getElementById("totalRec"+hora2);
			divTotalDescanso.innerHTML=totalDescanso;
			divTotalRecurso.innerHTML=totalRecurso;
		}
		
		horas = horas+hora+";";
	}
	
	//alert(horas);
}

</script>

</head>
<body>
<jsp:include page="../header.jsp" flush="true" />
<center><h2>Estado de Asesores por hora</h2></center> 
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



<!-- table align="left">
<tr>
<td bgcolor="#B5B5B5" align="center">Dia</td>
<td align="center">
<c:choose>
<c:when test="${dia=='semana'}">
<b>Semana</b>
</c:when>
<c:otherwise>
<a href="javascript:getDia('semana');">Semana</a>
</c:otherwise>
</c:choose>
</td>
<td align="center">
<c:choose>
<c:when test="${dia=='sabado'}">
<b>Sabado</b>
</c:when>
<c:otherwise>
<a href="javascript:getDia('sabado');">Sabado</a>
</c:otherwise>
</c:choose>

</td>
<td align="center">
<c:choose>
<c:when test="${dia=='domingo'}">
<b>Domingo</b>
</c:when>
<c:otherwise>
<a href="javascript:getDia('domingo');">Domingo</a>
</c:otherwise>
</c:choose>

</td>
</tr>
</table-->




<br><br>

<table  align="center" width="100%">
<c:forEach items="${listaGruposAMostrar}" var="grupoIteracion">
<c:set var="listaDatos" value="${grupoIteracion.elementosAsociados}" /><c:set var="listaDatos" value="${grupoIteracion.elementosAsociados}" />


<tr><td bgcolor="red" align="center" colspan="10"><b><font color="white">${grupoIteracion.descripcion}</font><b></td></tr>
	<tr bgcolor="lightgray">
		<td align="center"><b>Nombre</b></td>
		<td align="center"><b>Turno</b></td>
		<td align="center"><b>Horario</b></td>
		<td align="center"><b>Descansos</b></td>
		<td align="center"><b>Estado</b></td>
	</tr>

<c:set var="i" value="0" />

<c:forEach items="${listaDatos}" var="tupla" >
	
	
	<c:set var="turno" value="${tupla[0]}" />
	<c:set var="nUsuario" value="${empty tupla[1]?'SIN_USUARIO':tupla[1]}" />
	
	<c:set var="estado_y_turno" value="${fn:split(turno.estado_tiempo_real,';')}" />

	<c:set var="color_bg" value="" />
	<c:if test="${estado_y_turno[0]=='ALMUERZO'}" >
		<c:set var="color_bg" value="red" />
	</c:if>
	
	<c:if test="${estado_y_turno[0]=='DESCANSO'}">
		<c:set var="color_bg" value="lightgreen" />
	</c:if>

	<c:if test="${estado_y_turno[0]=='DESCONECTADO'}">
		<c:set var="color_bg" value="lightgray" />
	</c:if>

	<c:if test="${estado_y_turno[0]=='CONECTADO'}">
		<c:set var="color_bg" value="white" />
	</c:if>
	
	<tr bgcolor="${i%2 == 0? '' :'#EDEDED'}">
		<td align="center">${nUsuario}</td>
		<td align="center">${turno.id}</td>
		<td align="center">${estado_y_turno[1]}</td>
		<td align="center">${estado_y_turno[2]}</td>
		<td align="center" bgcolor="${color_bg}">${estado_y_turno[0]}</td>
	</tr>
	<c:set var="i" value="${i+1}"/>
</c:forEach>

</c:forEach>
</body>

</html>
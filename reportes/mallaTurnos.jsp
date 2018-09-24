<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="listaGrupos" value="${requestScope.listaGrupos}" />
<c:set var="listaYears" value="${requestScope.listaYears}" />
<c:set var="listaSemanas" value="${requestScope.listaSemanas}" />
<c:set var="tipoUsuario" value="${requestScope.tipoUsuario}" />

<c:set var="listaGruposAMostrar" value="${requestScope.listaGruposAMostrar}" />
<c:set var="user" value="${requestScope.user}" />

<%-- esta variable tendra una lista con los grupos que se van a mostrar, si son todos contendra
	 todos los grupos, si es uno solo solo contendra un grupo, asi se generaliza el reporte.
 --%>

<c:set var="lapsoTiempo" value="${requestScope.lapsoTiempo}" />
<c:set var="grupoSelected" value="${requestScope.grupoSelected}" />
<c:set var="grupoSelected2" value="${requestScope.grupoSelected2}" />
<c:set var="semanaRequest" value="${requestScope.semana}" />
<c:set var="yearRequest" value="${requestScope.year}" />
<c:set var="tipoUsuario" value="${requestScope.tipoUsuario}" />

<%-- En esta variable se controlaran los segmentos de tiempo de la aplicacion --%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Malla de Turnos</title>

<script type="text/javascript">

function traerGrupo(){
	
	var grupo=document.getElementById("selectGrupos").value;
	
	if(grupo=='-1')
		return;
	
	var semana = document.getElementById("selectSemanas").value;
	var year = document.getElementById("selectYears").value;
	
	location.href="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=getMallaGrupo&grupoId="+grupo+"&dia=${dia}&year="+year+"&semana="+semana;
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

	var lapsoTiempo="${lapsoTiempo}";
	var divo=60/lapsoTiempo;
	var horas="";
	for ( i=6; i< 22;i++ ) {
		var array = new Array(divo);
		
		for(k=0; k<divo;k++){
			var indice=k*lapsoTiempo;
			if(indice<=9){
				indice="0"+indice;
			}
			array[k]=indice;
		}
		

		var hora=(i<=9?"0":"")+i;
		
		for(j=0;j<divo;j++){
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

function formatoTurno(horario, idturno){
	//alert(horario);
	var hours=horario.split("-");
	var horaInicio=hours[0];
	var horaFinal=hours[1];
	
	var horaf=hora;
	var horas="";
	
	var rango="no";
	
	var lapsoTiempo="${lapsoTiempo}";
	var div=60/lapsoTiempo;
	var horas="";	

	for ( i=6; i< 22;i++ ) {
		var array = new Array(div);

		for(k=0; k<div;k++){
			var indice=k*lapsoTiempo;
			if(indice<=9){
				indice="0"+indice;
			}
			array[k]=indice;
		}


		var hora=(i<=9?"0":"")+i;
		
		for(j=0;j<12;j++){
			var hora2=hora+":"+array[j];
			var display="";
			var backg="";
			if(rango=="no"){
				display="-";
				backg="	gray";
				if(hora2==horaInicio){
					rango="si";
				}
			}
			if(rango=="si"){
				display="T";
				backg="yellow";
				if(hora2==horaFinal){
					rango="no";
				}
			}
			
			//if(hora2=="06:00") alert("d"+idturno+"-"+hora2)
			var dib=document.getElementById("d"+idturno+"-"+hora2);
			
			dib.style.background=backg;
			dib.innerHTML=display;
			//dib.style.backgroundColor="#b2f6ff";
			
			
		}
		
		horas = horas+hora+";";
	}
	actualizarTotales();
}



function clickColumna22(hora, idturno){

	//alert("me dieron! "+hora);
	//var dib=document.getElementsByName("d"+hora);
	
	//var len=rows.childNodes.length;
	
	var horaf=hora;
	var horas="";
	
	var lapsoTiempo="${lapsoTiempo}";
	var div=60/lapsoTiempo;
	
	for ( i=6; i< 22;i++ ) {
		var array = new Array(div);
		
		for(k=0; k<div;k++){
			var indice=k*lapsoTiempo;
			if(indice<=9){
				indice="0"+indice;
			}
			array[k]=indice;
		}
		
		var hora=(i<=9?"0":"")+i;
		
		for(j=0;j<div;j++){
			var hora2=hora+":"+array[j];
			
			var dib=document.getElementById("d"+idturno+"-"+hora2);
			dib.style.backgroundColor="#b2f6ff";
			
		}
		
		horas = horas+hora+";";
	}
	

	var dib=document.getElementsByName("d"+horaf);
	for (var k=0; k<dib.length; k++) {
		var di=dib[k];
		
		di.style.backgroundColor="#b2f6ff";
		
		var estado=di.innerHTML;
		
		if(estado=='-'){
			//no hay recurso, no hay que medir
		} else if(estado=='T'){
			//totalRecurso = totalRecurso+1;
		} else if(estado=='P'){
			//totalRecurso = totalRecurso+1;
			//totalDescanso = totalDescanso + 1;
		} else if(estado=='A'){
			//totalRecurso = totalRecurso+1;
			//totalDescanso = totalDescanso + 1;
		}
	}
}


function clickColumna(hora, idturno){

	//alert("me dieron! "+hora+", id-turno: "+idturno);
	var hora3=hora;
	var di=document.getElementById("d"+idturno+"-"+hora);
	var contenido=di.innerHTML;
	
	
	//para verificar si es un usuario administrador o no
	
	var isadmin="no";
	<c:if test="${not empty user.grupos_admin and fn:contains(user.grupos_admin,grupoIteracion.id)}">
	isadmin="yes";
	</c:if>
	
	var lasemana="${semanaRequest}";
	
	if(isadmin!="yes")
		return;
	
	
	
	
	if(contenido=="-"){
		di.innerHTML='+';
		estado='+';
		clickColumna22(hora, idturno);
	
		if(lasemana!="actual"){
			return;
		}
		
		/*
		//clickColumna22(hora, idturno);
		var out=confirm("desea modificar el horario del turno con la hora actual("+hora+")?");
		if(out){
			guardarInformacionAjax("modificarHorarioTurno","&horasDescanso="+descansoSemana+"&dia=${dia}&idTurno="+idturno+"&hora="+hora3+"&nextState="+estado);
			return;
		}*/
		return;
	}
	
	
	
	//alert("Contenido: '"+contenido+"'");
	var estado="ND";
	if(di.innerHTML=='T'){
		//dieron click porke kieren ke esto sea un descanso
		
		if(lasemana!="actual"){
			clickColumna22(hora, idturno);
			return;
		}
		
		di.style.background="red";
		di.innerHTML='P';
		estado='P';
		//alert('cambie los parametros');
	}else if(di.innerHTML=='P'){
		//dieron click porke kieren ke esto sea una de almuerzo
		di.style.background="blue";
		di.innerHTML='A';
		estado='A';
	}else if(di.innerHTML=='A'){
		//dieron click porke kieren ke esto sea una de trabajo
		di.style.background="white";
		di.innerHTML='X';
		estado='X';
		clickColumna22(hora, idturno);
	}else if(di.innerHTML=='X'){
		//dieron click porke kieren ke esto sea una de trabajo
		//verificamos si se quiere una actualizacion de horario
		if(lasemana!="actual"){
			//clickColumna22(hora, idturno);
			return;
		}
		var out=confirm("desea modificar el horario del turno con la hora actual("+hora+")?");
		if(out){
			guardarInformacionAjax("modificarHorarioTurno","&horasDescanso="+descansoSemana+"&dia=${dia}&idTurno="+idturno+"&hora="+hora3+"&nextState="+estado);
			return;
		}
		
		
		di.style.background="yellow";
		di.innerHTML='T';
		estado='T';
	} else if (di.innerHTML=='+'){
		if(lasemana!="actual"){
		
			return;
		}
		var out=confirm("desea modificar el horario del turno con la hora actual("+hora+")?");
		if(out){
			guardarInformacionAjax("modificarHorarioTurno","&horasDescanso="+descansoSemana+"&dia=${dia}&idTurno="+idturno+"&hora="+hora3+"&nextState="+estado);
			return;
		}
		
		di.innerHTML='-';
		estado='-';
	}
	
	
	
	var di2=document.getElementById("d"+idturno+"-"+hora);
	//alert("El nuevo valor de la hora: "+ di2.innerHTML);
	//return;
	
	var lapsoTiempo="${lapsoTiempo}";
	var div=60/lapsoTiempo;
	
	var minutos2="";
	var sep="";
	for(k=0; k<div;k++){
		var indice=k*lapsoTiempo;
		if(indice<=9){
			indice="0"+indice;
		}
		minutos2=minutos2+sep+indice;
		sep=",";
	}
	
	//var minutos2="00,05,10,15,20,25,30,35,40,45,50,55";
	var minutos=minutos2.split(",");
	
	var descansoSemana="";
	var descansoSabado="";
	var descansoDomingo="";

	for(i=6;i<=21;i++){
		var hora=i;
		if(i<=9)hora='0'+i;
		//traigo todos los divs para obtener los descansos
		for(j=0;j<div;j++){
			//obtengo el turno en semana
			var hora2=hora+":"+minutos[j];
			var divSemana=document.getElementById("d"+idturno+"-"+hora2);
			//var divSabado=document.getElementById("ds"+idturno+"-"+hora2);
			//var divDomingo=document.getElementById("dd"+idturno+"-"+hora2);
			
			if(divSemana.innerHTML=='P'){
				descansoSemana+=hora2+";";
			}
			
			if(divSemana.innerHTML=='A'){
				descansoSemana+="A"+hora2+";";
			}
		}
	}
	
	//alert("Descansos seleccionados: "+descansoSemana);
	//aca ya tengo los desncansos del dia (semana-sabado-domingo).
	//di.style.background="white";
	di.innerHTML="<img src='imagenes/imagenes-carga/loading3.gif' width='20' height='20'></img>";
	//di.innerHTML="";
	guardarInformacionAjax("guardarHoras","&horasDescanso="+descansoSemana+"&dia=${dia}&idTurno="+idturno+"&hora="+hora3+"&nextState="+estado);

}


//CODIGO AJAX
var http_request = false;
   function guardarInformacionAjax(accion,parametros) {
      http_request = false;
      if (window.XMLHttpRequest) { // Mozilla, Safari,...
         http_request = new XMLHttpRequest();
         if (http_request.overrideMimeType) {
         	// set type accordingly to anticipated content type
            //http_request.overrideMimeType('text/xml');
            http_request.overrideMimeType('text/html');
         }
      } else if (window.ActiveXObject) { // IE
         try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
            try {
               http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
         }
      }
      if (!http_request) {
         alert('Cannot create XMLHTTP instance');
         return false;
      }
      
      var url="";
      if(accion=="guardarHoras"){
		 var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=guardarHorasAjax"+parametros;
		 http_request.onreadystatechange = recuperarRespuesta;
      } else if (accion=="modificarHorarioTurno"){
      	 var url="${pageContext.request.contextPath}/action?accion=gestorReportes&operacion=modificarHorarioTurno"+parametros;
		 http_request.onreadystatechange = recuperarRespuestaHorario;
      }
      
      http_request.open('GET', url, true);
      http_request.send(null);
   }

function recuperarRespuestaHorario(){
	if (http_request.readyState == 4) {
         if (http_request.status == 200) {
            //alert(http_request.responseText);
            var result = http_request.responseText;
            //alert(result);
            var rta = result.split(";");
            var rta2=rta[0];
            var mensaje=rta[1];
            
            if(rta2=="ERROR" || rta2	=="WARNING"){
            	alert(mensaje);
            	return;
            }
            
            var horarioNuevo=rta[2];
            var idturno=rta[3];
            
            //si llego aca se hizo bien la transaccion, ahora se debe calcular de nuevo la extension del turno
			//alert(horarioNuevo+" - "+idturno);
			formatoTurno(horarioNuevo,idturno);

         } else {
            alert('There was a problem with the request.');
         }
      }
}

function recuperarRespuesta(){
	if (http_request.readyState == 4) {
         if (http_request.status == 200) {
            //alert(http_request.responseText);
            var result = http_request.responseText;
            var rta = result.split(";");
            var hora=rta[0];
            var idturno=rta[1];
            var estado=rta[2];
            var di2=document.getElementById("d"+idturno+"-"+hora);
            di2.innerHTML=estado;
            
     		if(di2.innerHTML=='P'){
				di2.style.background="red";
			}else if(di2.innerHTML=='A'){
				di2.style.background="blue";
			}else if(di2.innerHTML=='T'){
				di2.style.background="yellow";
			}

            actualizarTotales();
            //alert("Respuesta: "+"d"+idturno+"-"+hora+",estado: "+estado);
            //document.getElementById('myspan').innerHTML = result;            
         } else {
            alert('There was a problem with the request.');
         }
      }

}


</script>


</head>
<body>
<c:if test="${not empty tipoUsuario and tipoUsuario=='asesor'}">
	<jsp:include page="../headerAsesores.jsp" flush="true" />
</c:if>

<c:if test="${not empty tipoUsuario and tipoUsuario=='consultas'}">
	<jsp:include page="../headerConsultas.jsp" flush="true" />
</c:if>

<c:if test="${empty tipoUsuario}">
	<jsp:include page="../header.jsp" flush="true" />
</c:if>


<%--jsp:include page="../header${not empty tipoUsuario and tipoUsuario=='asesor'?'Asesores':''}.jsp" flush="true" /--%>
<%--jsp:include page="../header${not empty tipoUsuario and tipoUsuario=='consultas'?'Consultas':''}.jsp" flush="true" /--%>

<center><h2>Malla de Turnos</h2></center> 
<br>


<table align="left">
<tr>
<td align="center">
Seleccione un grupo:&nbsp;
<select id="selectGrupos" "<%-- ${not empty tipoUsuario and tipoUsuario=='asesor'?'disabled':''}--%>">
<option value="-1">Seleccione:</option>
<option value="todos" ${grupoSelected2=='todos'?'selected=selected':''}>Todos</option>
<c:forEach items="${listaGrupos}" var="grupo">
<option value="${grupo.id}" ${grupo.id==grupoSelected.id?'selected=selected':''}>${grupo.descripcion}</option>
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
<c:if test="${empty tipoUsuario or tipoUsuario!='asesor'}">
<option value="actual" ${semanaRequest=='actual'?'selected=selected':''}>Plantilla Actual</option>
</c:if>
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

<table align="left">
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
</table>


<br><br>


<table align="center" id="latabla">
<tbody>
<c:forEach items="${listaGruposAMostrar}" var="grupoIteracion">

<tr>
<td bgcolor="red" align="center" colspan="1000" ><font color="white"><b>${grupoIteracion.descripcion}</b></font></td>
</tr>
<c:set var="listaDatos" value="${grupoIteracion.elementosAsociados}" />

 <tr>
<%--c:if test="${not empty user.grupos_admin and fn:contains(user.grupos_admin,grupoIteracion.id) and empty grupoSelected2}"--%>
<c:if test="${semanaRequest =='actual'}">
<td bgcolor="#B5B5B5" align="center" rowspan="2" valign="bottom" width="200">&nbsp;Opcion&nbsp;</td>
</c:if>
<td bgcolor="#B5B5B5" align="center" rowspan="2" valign="bottom" width="200">&nbsp;Turno&nbsp;&nbsp;</td>
<td bgcolor="#B5B5B5" align="center" rowspan="2" valign="bottom" width="200">&nbsp;Probador&nbsp;&nbsp;</td>
<c:forEach begin="6" end="22" step="1" var="hora">
	<td bgcolor="#B5B5B5" align="center" colspan="${60/lapsoTiempo}" width="40">
	${hora<=9?'0':''}${hora}
	</td>
</c:forEach>

</tr>

<tr>
<c:forEach begin="6" end="21" step="1" var="hora">
	<c:set var="divi" value="${60/lapsoTiempo}" />
	<c:set var="sep" value="" />
	<c:set var="cadenaMinutos" value="" />
	<c:forEach begin="0" end="${divi-1}" step="1" var="minu">
		
		<c:set var="shows" value="${lapsoTiempo*minu}" />
		<c:set var="shows" value="${shows<=9?'0':''}${shows}" />
		<td bgcolor="#EDEDED" align="center">${shows}</td>
		<c:set var="cadenaMinutos" value="${cadenaMinutos}${sep}${shows}" />
		<c:set var="sep" value="," />
	</c:forEach>
</c:forEach>
</tr>

<%-- ACA ITERO CON LOS VALORES DE LA LISTA --%>

<c:forEach items="${listaDatos}" var="tupla" >
<c:set var="turno" value="${tupla[0]}" />

<c:if test="${dia=='semana'}">
<c:set var="horast" value="${turno.horas}" />
<c:set var="descansoSemanat" value="${turno.descansoSemana}" />
</c:if>

<c:if test="${dia=='sabado'}">
<c:set var="horast" value="${turno.horasSabado}" />
<c:set var="descansoSemanat" value="${turno.descansoSabado}" />
</c:if>

<c:if test="${dia=='domingo'}">
<c:set var="horast" value="${turno.horasDomingo}" />
<c:set var="descansoSemanat" value="${turno.descansoDomingo}" />
</c:if>



<tr id="d${turno.id2}">
<c:if test="${semanaRequest =='actual'}">
<td align="center" bgcolor="#EDEDED">
<c:if test="${not empty user.grupos_admin and fn:contains(user.grupos_admin,grupoIteracion.id)}">

<input type="button" value="..." onclick="javascript:editarTurno('${turno.id2}')">
</c:if>

</td>
</c:if>
<td align="center" bgcolor="#EDEDED">${empty turno?'SIN_TURNO':fn:replace(turno.id,' ','_')}</td>


<c:set var="nUsuario" value="${empty tupla[1]?'SIN_USUARIO':fn:replace(tupla[1],' ','_')}" />

<td align="center" bgcolor="#EDEDED">${nUsuario}</td>

<%-- En la pos 0 keda la horaINi y en la 1 la horafin --%>
<c:set var="horas" value="${fn:split(horast, '-')}" />
<%--c:set var="horas" value="${fn:split(turno.horas, '-')}" /--%>
<%-- Con esta variable controlo si ya llegue al final del turno para dejar de pintar --%>
<c:set var="cont" value="0" />
<c:set var="horaComparar" value="${horas[0]}" />
<c:set var="color" value="#FBFBFB" /><%-- color de hora normal --%>

<c:forEach begin="6" end="21" step="1" var="hora">
	<c:set var="hora2" value="${hora<=9?'0':''}${hora}" />
	<c:set var="cuartos" value="${fn:split(cadenaMinutos,',')}" /> 


	<c:forEach items="${cuartos}" var="quart">

		<%-- ESTE BLOQUE DE INTRUCCIONES ES PARA SABER DONDE COMIENZO Y TERMINO DE PINTAR EL TURNO[INI] --%>
		<c:set var="hora3" value="${hora2}:${quart}" />
		<%-- Con esto encuentro la hora inicial para empezar a pintar el turno--%>
		<c:if test="${horaComparar==hora3 and  cont=='0'}">
			<c:set var="horaComparar" value="${horas[1]}" />
			<c:set var="cont" value="1" />
		</c:if>
		
		<%-- Con esto encuentro la hora final para terminar de pintar el turno --%>
		<c:if test="${horaComparar==hora3 and cont=='1'}">
			<c:set var="horaComparar" value="${horas[1]}" />
			<c:set var="cont" value="2" />
		</c:if>
		
		<%-- ESTE BLOQUE DE INTRUCCIONES ES PARA SABER DONDE COMIENZO Y TERMINO DE PINTAR EL TURNO[END]--%>

		<c:set var="color" value="${cont=='0' or cont=='2'?'#FBFBFB':'yellow'}" /><%-- color de hora normal --%>		
	
		<%-- aca busco si la hora es de descanso o no --%>
		<c:set var="hour" value="${hora2}:${quart}" />
		<c:set var="mostrar" value="${cont=='1'?'T':'-'}" />
		<c:if test="${fn:contains(descansoSemanat,hour)}">
			<c:set var="color" value="red" /><%-- color de pausa --%>
			<c:set var="mostrar" value="P" />
		</c:if>
		
				<%-- para el almuerzo --%>
		<c:set var="hourLunch" value="A${hour}" />
		<c:if test="${fn:contains(descansoSemanat,hourLunch)}">
			<c:set var="color" value="blue" /><%-- color de pausa --%>
			<c:set var="mostrar" value="A" />
		</c:if>
		
		<td align="center" width="25%" onclick="javascript:clickColumna('${hour}','${turno.id2}');"><span title="${turno.id}"><div id="d${turno.id2}-${hour}" name="d${hour}" style="background:${color};">${mostrar}</div></span></td>

	</c:forEach>

</c:forEach>
</tr>

</c:forEach>
<!-- tr>
<td align="center" colspan="100" height="50" ></td>
</tr-->

</c:forEach>

<c:if test="${not empty grupoSelected}" >
<tr>

<td bgcolor="#B5B5B5" colspan="${semanaRequest =='actual'?'3':'2'}" align="center"><font color="black"><b>TOTAL EN DESCANSO</b></font></td>
<c:forEach begin="6" end="21" step="1" var="hora">
	<c:set var="hora2" value="${hora<=9?'0':''}${hora}" />
	<c:set var="cuartos" value="${fn:split(cadenaMinutos,',')}" />
	
	
	<c:forEach items="${cuartos}" var="quart">
		<c:set var="hora3" value="${hora2}:${quart}" />
		<td bgcolor="#EDEDED"><div id="desc${hora3}" ></div></td>
	</c:forEach>	
</c:forEach>
</tr>

<tr>
<td bgcolor="#B5B5B5" colspan="${semanaRequest =='actual'?'3':'2'}" align="center"><font color="black"><b>TOTAL RECURSO</b></font></td>
<c:forEach begin="6" end="21" step="1" var="hora">
	<c:set var="hora2" value="${hora<=9?'0':''}${hora}" />
	<c:set var="cuartos" value="${fn:split(cadenaMinutos,',')}" />
	
	
	<c:forEach items="${cuartos}" var="quart">
		<c:set var="hora3" value="${hora2}:${quart}" />
		<td bgcolor="#EDEDED"><div id="totalRec${hora3}" ></div></td>
	</c:forEach>	
</c:forEach>
</tr>
</c:if>
</tbody>
</table>

</body>
<script language="javascript">actualizarTotales();</script>
</html>

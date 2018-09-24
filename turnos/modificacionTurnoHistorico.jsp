<!-- modificacionTurnoHistorico.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="turno" value="${requestScope.turno}" />
<c:set var="historial" value="${requestScope.historial}" />

<c:set var="tipoRequest" value="${requestScope.tipoRequest}" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Modificar Turno</title>
<script type="text/javascript">

function validarCampos2(){

	var dias=document.getElementById("selectDias").value;
	var dias2=document.getElementById("selectDias").text;
	
	//var selectTipoTurno=document.getElementById("selectTipoTurno").value;
	//var selectTipoTurno2=document.getElementById("selectTipoTurno").text;
	
	//horario en semana del turno
	var horaIni=document.getElementById("horaIni").value;
	var minutoIni=document.getElementById("minutoIni").value;
	var horaFin=document.getElementById("horaFin").value;
	var minutoFin=document.getElementById("minutoFin").value;
	var idTurno=document.getElementById("idTurno").value;
	
	if (idTurno==''){
		alert("Ingrese un identificador para el turno");
		return;
	}
	
	horaIni=horaIni+":"+minutoIni;
	horaFin=horaFin+":"+minutoFin;
	var horaf=horaIni+"-"+horaFin;
	
	
	//horario el sabado del turno
	var horaInis=document.getElementById("horaInis").value;
	var minutoInis=document.getElementById("minutoInis").value;
	var horaFins=document.getElementById("horaFins").value;
	var minutoFins=document.getElementById("minutoFins").value;
	horaInis=horaInis+":"+minutoInis;
	horaFins=horaFins+":"+minutoFins;
	var horafs=horaInis+"-"+horaFins;
	
	
	//horario del turno el domingo
	var horaInid=document.getElementById("horaInid").value;
	var minutoInid=document.getElementById("minutoInid").value;
	var horaFind=document.getElementById("horaFind").value;
	var minutoFind=document.getElementById("minutoFind").value;
	horaInid=horaInid+":"+minutoInid;
	horaFind=horaFind+":"+minutoFind;
	var horafd=horaInid+"-"+horaFind;
	
	var labores=document.getElementById("labores").value;
		
	var wsabado="";
	var wdomingo="";
	
	if(dias=='L-V'){
		horafd="";
		horafs="";
	}
	
	if(dias=='L-S'){
		var wsabado="\nHorario sabado: "+horafs;
		var wdomingo="";
		horafd="";
	}else if(dias=='L-D'){
		var wsabado="\nHorario sabado: "+horafs;
		var wdomingo="\nHorario Domingo: "+horafd;
		
	}
		
	var conf=confirm("Esta es la configuracion del nuevo turno:"+
					"\nTurno: "+idTurno+
					"\nDias: "+dias2+
					"\nHorario semana: "+horaf+
					wsabado+wdomingo+
					"\nLabores: "+labores+
					"\nDesea Continuar?");
	if(conf){ 
		var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=doModificarTurnoHistorico";
		url=url+"&dias="+dias+"&horas="+horaf+"&labores="+labores+"&idHistorico=${historial.id}";
		url+="&horasSabado="+horafs+"&horasDomingo="+horafd+"&idTurnoTexto="+idTurno;
			
		location.href=url;
	}
	
}

function regresarInicioTurnos(){
	//location.href="${pageContext.request.contextPath}/action?accion=gestorTurnos";
	window.back();
}

function definirDescanso(){
	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=definirDescansoHistorico&idHistorico=${historial.id}";
	var wind=window.open(url, 'Turnos','scrollbars=yes,resizable=yes,hotkeys=yes,height=300,width=700,left=100,top=50,menubar=yes,toolbar=no');
	wind.focus();
}

function validarHoras(horaIni,horaFin,minutoIni,minutoFin){
	if(horaIni>horaFin){
		//aca hay un problema con las horas
		return 1;
	}
	
	if(horaIni==horaFin){
		if(minutoIni>minutoFin){
			//aca hay un problema con los minutos
			return 1;
		}
	}
	//la hora esta bien
	return 0;
}

</script>
</head>
<body>
<c:if test="${empty tipoRequest or tipoRequest!='popup'}">
<jsp:include page="../header.jsp" flush="true" />
</c:if>

<center>Modificar turno historico <font color='red'>${turno.id}</font> de la semana ${historial.semana}</center>

<p></p>
<br>
 
<table width="60%" align="center">
<tr>

<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Turno</td>
<td align="center" width="70%" bgcolor="#EDEDED"><input type="text" id="idTurno" value="${not empty turno?turno.id:''}"></td>
</tr>


<td align="center" width="30%" bgcolor="#B5B5B5">Dias</td>
<td align="center" width="70%" bgcolor="#EDEDED">
<select id="selectDias">
<option value="L-V" "${not empty turno and turno.dias=='L-V'?'selected=selected':''}">Lunes-Viernes</option>
<option value="L-S" "${not empty turno and turno.dias=='L-S'?'selected=selected':''}">Lunes-Sabado</option>
<option value="L-D" "${not empty turno and turno.dias=='L-D'?'selected=selected':''}">Lunes-Domingo</option>
</select>
</td>
</tr>

<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Horas en Semana</td>
<td align="center" width="70%" bgcolor="#EDEDED">
 
<c:set var="hours" value="${fn:split(turno.horas, '-')}" />

<c:set var="hours1" value="${fn:split(hours[0], ':')}" />
<c:set var="hours2" value="${fn:split(hours[1], ':')}" />


Hora inicial: 
<select id="horaIni">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours1[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
<select id="minutoIni">
<option value="00" ${hours1[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours1[1]=='30'?"selected=selected":""}>30</option>
</select>

<br>
Hora Final:&nbsp;

<select id="horaFin">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours2[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
 <select id="minutoFin">
<option value="00" ${hours2[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours2[1]=='30'?"selected=selected":""}>30</option>
</select>

</td>
</tr>

<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Horas Sabado</td>
<td align="center" width="70%" bgcolor="#EDEDED">
 
<c:set var="hours" value="${fn:split(turno.horasSabado, '-')}" />

<c:set var="hours1" value="${fn:split(hours[0], ':')}" />
<c:set var="hours2" value="${fn:split(hours[1], ':')}" />


Hora inicial: 
<select id="horaInis">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours1[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
<select id="minutoInis">
<option value="00" ${hours1[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours1[1]=='30'?"selected=selected":""}>30</option>
</select>

<br>
Hora Final:&nbsp;

<select id="horaFins">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours2[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
 <select id="minutoFins">
<option value="00" ${hours2[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours2[1]=='30'?"selected=selected":""}>30</option>
</select>
 
</td>
</tr>

<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Horas Domingo</td>
<td align="center" width="70%" bgcolor="#EDEDED">
 
<c:set var="hours" value="${fn:split(turno.horasDomingo, '-')}" />

<c:set var="hours1" value="${fn:split(hours[0], ':')}" />
<c:set var="hours2" value="${fn:split(hours[1], ':')}" />


Hora inicial: 
<select id="horaInid">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours1[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
<select id="minutoInid">
<option value="00" ${hours1[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours1[1]=='30'?"selected=selected":""}>30</option>
</select>

<br>
Hora Final:&nbsp;

<select id="horaFind">
<c:forEach begin="6" end="22" step="1" var="hora">
	<c:set var="h" value="${hora<=9?'0':''}${hora}" />
	<option value="${h}" "${not empty turno and hours2[0] == h ?'selected=selected':''}" >${h}</option>
</c:forEach>
</select>
 <select id="minutoFind">
<option value="00" ${hours2[1]=='00'?"selected=selected":""}>00</option>
<option value="30" ${hours2[1]=='30'?"selected=selected":""}>30</option>
</select>


</td>
</tr>

<c:if test="${not empty turno}">
<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Descansos</td>
<td align="center" width="70%" bgcolor="#EDEDED"><a href="javascript:definirDescanso();">Definir Descansos</a></td>
</tr>
</c:if>
<tr>
<td align="center" width="30%" bgcolor="#B5B5B5">Actividades</td>
<td align="center" width="70%" bgcolor="#EDEDED">
<textarea rows="3" cols="15" id="labores">${not empty turno?turno.labores:''}</textarea>
</td>
</tr>

<%-- con esto implemento el de modificar turno 
<tr>
<td></td><td></td>
</tr>

--%>
</table>

<center><input type="button" value="Modificar" onclick="javascript:validarCampos2();">
&nbsp;&nbsp;

<c:set var="javascript" value="regresarInicioTurnos" />

<c:if test="${not empty tipoRequest and tipoRequest=='popup'}">
<c:set var="javascript" value="window.close" />
</c:if>
<input type="button" value="cancelar" onclick="javascript:${javascript}();"></center>


</body>
</html>
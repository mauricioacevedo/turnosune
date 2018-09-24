<!-- definirDescansoHistorial.jsp -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="turno" value="${requestScope.turno}" />
<c:set var="historial" value="${requestScope.historial}" />
<c:set var="lapsoTiempo" value="${requestScope.lapsoTiempo}" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Definir descansos</title>

<script type="text/javascript">

function seleccion(hora,dia){
	
	var pre='';
	if(dia=='semana')
		post='';
	else if(dia=='sabado')
		pre="s";
	else if(dia=='domingo')
		pre="d";
	
	
	var di=document.getElementById("d"+pre+hora);
	
	//alert("me dieron click inner: "+di.innerHTML)



	if(di.innerHTML=='T'){
		//dieron click porke kieren ke esto sea un descanso
		di.style.background="red";
		di.innerHTML='P';
		//alert('cambie los parametros');
	}else if(di.innerHTML=='P'){
		//dieron click porke kieren ke esto sea una de almuerzo
		di.style.background="blue";
		di.innerHTML='A';
	}else if(di.innerHTML=='A'){
		//dieron click porke kieren ke esto sea una de trabajo
		di.style.background="yellow";
		di.innerHTML='T';
	}

	//di.style.background="yellow";
	//di.innerHTML=num;


}

function guardarHorario(){
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

	//var minutos2="00,15,30,45";
	var minutos=minutos2.split(",");
	
	var descansoSemana="";
	var descansoSabado="";
	var descansoDomingo="";
	
	for(i=6;i<=21;i++){
		var hora=i;
		if(i<=9)hora='0'+i;
		<!-- traigo todos los divs para obtener los descansos -->
		for(j=0;j<div;j++){
			//obtengo el turno en semana
			var hora2=hora+":"+minutos[j];
			var divSemana=document.getElementById("d"+hora2);
			var divSabado=document.getElementById("ds"+hora2);
			var divDomingo=document.getElementById("dd"+hora2);
			
			if(divSemana.innerHTML=='P'){
				descansoSemana+=hora2+";";
			}
			if(divSabado.innerHTML=='P'){
				descansoSabado+=hora2+";";
			}
			if(divDomingo.innerHTML=='P'){
				descansoDomingo+=hora2+";";
			}
			
			if(divSemana.innerHTML=='A'){
				descansoSemana+="A"+hora2+";";
			}
			if(divSabado.innerHTML=='A'){
				descansoSabado+="A"+hora2+";";
			}
			if(divDomingo.innerHTML=='A'){
				descansoDomingo+="A"+hora2+";";
			}
			
			
			
		}
		
	}
	
	var url="${pageContext.request.contextPath}/action?accion=gestorTurnos&operacion=doDefinirDescansoHistorico&idHistorico=${historial.id}";
	url+="&descansoSemana="+descansoSemana+"&descansoSabado="+descansoSabado+"&descansoDomingo="+descansoDomingo;
	
	location.href=url;
}

</script>
</head>
<body>
<center>Descansos para el turno ${turno.id}</center>

<table align="center">
<tr>
<td bgcolor="#B5B5B5" align="center" rowspan="3" valign="bottom">Semana</td>
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

<!-- semana-->

<tr>
<%-- En la pos 0 keda la horaINi y en la 1 la horafin --%>
<c:set var="horas" value="${fn:split(turno.horas, '-')}" />
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
		
		<%-- para la pausa --%>
		<c:if test="${fn:contains(turno.descansoSemana,hour)}">
			<c:set var="color" value="red" /><%-- color de pausa --%>
			<c:set var="mostrar" value="P" />
		</c:if>

		<%-- para el almuerzo --%>
		<c:set var="hourLunch" value="A${hour}" />
		<c:if test="${fn:contains(turno.descansoSemana,hourLunch)}">
			<c:set var="color" value="blue" /><%-- color de pausa --%>
			<c:set var="mostrar" value="A" />
		</c:if>
		
				
		
		<td align="center" width="25%" onclick="javascript:seleccion('${hour}','semana');"><div id="d${hour}" style="background:${color};">${mostrar}</div></td>

	</c:forEach>

</c:forEach>
</tr>


<!-- sabado-->

<tr>
<td bgcolor="#B5B5B5" align="center">Sabado</td>
<%--En la pos 0 keda la horaINi y en la 1 la horafin --%>
<c:set var="horas" value="${fn:split(turno.horasSabado, '-')}" />
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

		<%-- para la pausa --%>
		<c:if test="${fn:contains(turno.descansoSabado,hour)}">
			<c:set var="color" value="red" /><%-- color de pausa --%>
			<c:set var="mostrar" value="P" />
		</c:if>
		
		<%-- para el almuerzo --%>
		<c:set var="hourLunch" value="A${hour}" />
		<c:if test="${fn:contains(turno.descansoSabado,hourLunch)}">
			<c:set var="color" value="blue" /><%-- color de almuerzo --%>
			<c:set var="mostrar" value="A" />
		</c:if>
		
		<td align="center" width="25%" onclick="javascript:seleccion('${hour}','sabado');"><div id="ds${hour}" style="background:${color};">${mostrar}</div></td>

	</c:forEach>

</c:forEach>
</tr>


<!-- domingo-->

<tr>
<td bgcolor="#B5B5B5" align="center">Domingo</td>
<%--En la pos 0 keda la horaINi y en la 1 la horafin --%>
<c:set var="horas" value="${fn:split(turno.horasDomingo, '-')}" />

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
		
		<%-- para la pausa --%>
		<c:if test="${fn:contains(turno.descansoDomingo,hour)}">
			<c:set var="color" value="red" /><%-- color de pausa --%>
			<c:set var="mostrar" value="P" />
		</c:if>
		
		<%-- para el almuerzo --%>
		<c:set var="hourLunch" value="A${hour}" />
		<c:if test="${fn:contains(turno.descansoDomingo,hourLunch)}">
			<c:set var="color" value="blue" /><%-- color de almuerzo --%>
			<c:set var="mostrar" value="A" />
		</c:if>
		
		
		<td align="center" width="25%" onclick="javascript:seleccion('${hour}','domingo');"><div id="dd${hour}" style="background:${color};">${mostrar}</div></td>

	</c:forEach>

</c:forEach>
</tr>

</table>
<br>

<center>


<input type="button" value="Guardar" onclick="javascript:guardarHorario();">&nbsp;&nbsp;


<input type="button" value="Cerrar" onclick="javascript:window.close();"></center>

</body>
</html>
<!-- mensaje.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="mensaje" class="java.lang.String" scope="request" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- tipo es para diferenciar si es un mensaje en popup o en pantalla normal --%>
<jsp:useBean id="tipo" class="java.lang.String" scope="request" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mensaje de Sistema</title>
</head>
<body> 

</body>
</html>







<html>
<%-- 
<c:choose>
	<c:when test="${empty tipo or fn:contains(tipo, 'normal')}">
		<jsp:include page="../encabezado.jsp" flush="true" />
	</c:when>
</c:choose>
--%>

<!-- body text=black bgcolor="white" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0"-->
<body>
<br>
<center>Mensaje</center>
<br><br>
<center>${mensaje}</center>
<br><br>
<!-- >center>
<input type="button" name="atras" onclick="javascript:window.history.back();" value="regresar" class="boton">
</center-->

<center>
<c:choose>
	<c:when test="${empty tipo or fn:contains(tipo, 'normal')}"> 
	<input type="button" name="atras" onclick="javascript:window.history.back();" value="regresar" class="boton">
	</c:when>
	<c:otherwise>
	<input type="button" name="atras" onclick="javascript:window.close();" value="cerrar" class="boton">
	</c:otherwise>
</c:choose>
</center>
</body>
</html>

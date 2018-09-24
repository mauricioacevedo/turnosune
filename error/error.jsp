<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="error" class="java.lang.String" scope="request" />
<jsp:useBean id="tipo" class="java.lang.String" scope="request" />
<html>
<!-- tipo = "${tipo}" -->
<head>
</head>
<body>
<br>
<div align="center"><h1>Error</h1></div>
<br>
<br>
<div align="center">${error}</div>
<br>
<div align="center">
<c:choose>
	<c:when test="${tipo == ''}">
		<input type="button" name="atras" onclick="javascript:window.history.back();" value="regresar" class="boton">
	</c:when>
	<c:otherwise>
		<input type="button" name="atras" onclick="javascript:window.close();" value="cerrar" class="boton">
	</c:otherwise>
</c:choose>
</div>
</body>
</html>

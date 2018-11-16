<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Session Info</title>
</head>
<body>
	<h3>Session Info</h3>
	<%
		ZoneId zone = ZoneId.systemDefault();
		DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(zone);
		String sessionId = session.getId();
		long lastTime = session.getLastAccessedTime();
		long createTime = session.getCreationTime();
		long timeUsed = (lastTime - createTime) / 60000;
		int inActive = session.getMaxInactiveInterval();
		boolean isNew = session.isNew();

    String lastDate = df.format(Instant.ofEpochMilli(lastTime));
    String creaDate = df.format(Instant.ofEpochMilli(createTime));
	%>

	sessionId : <%=sessionId %> <br />
	LastAccessedTime : <%=lastDate %> <br />
	CreateTime : <%=creaDate %> <br />
	UsedTime : <%=timeUsed %> <br />
	SessionMaxTime : <%=inActive / 60 %>Min <br />
	IsNew : <%=isNew %> <br />
</body>
</html>

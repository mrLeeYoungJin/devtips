<%--
    Document   : index
    Created on : 18 Sep, 2012, 6:35:44 PM
    Author     : ramki
--%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<FONT size = 5 COLOR="#0000FF">
        Instance <%=InetAddress.getLocalHost()%> <br/><br/>
        </FONT>

        <hr/>

        <FONT size = 5 COLOR="#CC0000">
         <br/>
        Session Id : <%=sessionId %> <br/>
        Is it New Session : <%=isNew %><br/>
        Session Creation Date : <%=creaDate %><br/>
        Session Access Date : <%=lastDate %><br/><br/>
        </FONT>
        <b>Cart List </b><br/>
        <hr/>


        <ul>
        <%
                String bookName = request.getParameter("bookName");
                List<String> listOfBooks = (List<String>) request.getSession().getAttribute("Books");
                if (listOfBooks == null) {
                    listOfBooks = new ArrayList<String>();
                    request.getSession().setAttribute("Books", listOfBooks);
                }
                if (bookName != null) {
                    listOfBooks.add(bookName);
 		    request.getSession().setAttribute("Books", listOfBooks);
                }
                for (String book : listOfBooks) {
                    out.println("<li>"+book + "</li><br/>");
                }

        %>
        </ul>
        <hr/>
        <form action="index.jsp" method="post">
            Book Name <input type="text" name="bookName" />

            <input type="submit" value="Add to Cart"/>
        </form>
        <hr/>
    </body>
</html>

<%@page language="java" %>
<html>
<body>
<h1><font color="red">Session serviced by machine1</font></h1>
<table align="center" border="1">
  <tr>
  <td>
     Session ID
  </td>
  <td>
     <%= session.getId() %></td>
  </td>
  <% session.setAttribute("abc","abc");%>
  </tr>
  <tr>
  <td>
    Created on
  </td>
  <td>
    <%= session.getCreationTime() %>
  </td>
  </tr>
</table>
</body>
</html>

<%@ page import="java.io.Serializable" %>
<%@ page contentType="text/html; charset=euc-kr" %>

 <%
 class MyClass implements Serializable {
   int no = 0;
}
 %>
<HTML>
<HEAD>
    <TITLE>Session Clustering Test</TITLE>
</HEAD>
<BODY>
<h1>Session Clustering Test</h1>
<%
    MyClass myclass  = new MyClass();

    Integer ival = (Integer)session.getAttribute("_session_counter");

    if(ival==null) {
        ival = new Integer(1);
    }
    else {
      myclass.no = myclass.no + 1;
        ival = new Integer(ival.intValue() + 1);
    }
    session.setAttribute("_session_counter", myclass);
    System.out.println("here~~~~");
%>
Session Counter = [<b> <%= myclass.no %> </b>]<p>
<a href="./index.jsp">[Reload]</a>
<p>
Current Session ID : <%= request.getRequestedSessionId() %><br />
</BODY>
</HTML>

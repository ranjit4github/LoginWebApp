<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<br/>
<center>Welcome <h3><%=session.getAttribute("userid")%></h3></center>
<br/>
<img src="images/DevOps-Architecture.png">
<br/>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
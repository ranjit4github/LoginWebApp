<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<center>Welcome <h3><%=session.getAttribute("userid")%></h3></center>
<br/>
<center><img src="images/DevOps-Architecture.png"></center>
<br/>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
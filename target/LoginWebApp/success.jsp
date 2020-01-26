<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<center>Welcome <%=session.getAttribute("userid")%>
<h3>DevOps Class - Test2</h3>
<h4>16-01-2020</h4>
</center>

<br/>
<center><img src="images/DevOps-Architecture.png"></center>
<br/>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
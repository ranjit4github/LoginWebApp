<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<center>
    <h1>Welcome <%=session.getAttribute("userid")%></h1>
    <h2>DevOps World - V1.7 </h3>
    <h3>Happy Learning!</h4>
</center>

<br/>
<center><img src="images/DevOps-Architecture.png" width="60%"" height="60%"></center>
<br/>
<center><a href='logout.jsp'>Log out</a></center>
<%
    }
%>

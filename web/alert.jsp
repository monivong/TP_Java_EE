<%
    if( request.getAttribute("error-message") != null ) {
%>
    <div class="container">
        <div class="alert alert-danger fade in" style="opacity: 0.6">
             <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Erreur!</strong> <%=request.getAttribute("error-message")%>
        </div>
    </div>
<%
    }
    if( request.getAttribute("success-message") != null ) {
%>
    <div class="container">
        <div class="alert alert-success fade in" style="opacity: 0.6">
             <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>BRAVO !</strong> <%=request.getAttribute("success-message")%>
        </div>
    </div>
<%
    }
%>

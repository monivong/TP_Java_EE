<%
    if( request.getAttribute("message") != null ) {
%>
        <div class="alert alert-danger fade in" style="opacity: 0.6">
             <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Erreur!</strong> <%=request.getAttribute("message")%>
        </div>
<%
    }
%>

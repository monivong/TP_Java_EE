<%      
    String view = "login";
    if( request.getSession() != null) {
        /*
        HttpSession objetSession = request.getSession();
        String view;
        if (request.getParameter("page") == null)
            view = "main";
        */
        view = "main";
        if( request.getParameter("page") != null ) {//else {
            view = "404";            
            if( "login".equals( request.getParameter("page") ) )
                view = "main";
            else
                view = request.getParameter("page");
/* GLASSFISH ne gère pas les Switch..Case avec les String !! C'est dommage....
            switch(request.getParameter("page")) //Il faut rajouter les pages ici pour que la redirection fontionne
            {
                case "chercherUnCours":             view = "chercherUnCours";
                                                    break;
                case "consulterLaListeDesCours":    view = "consulterLaListeDesCours";
                                                    break;
                case "consulterUneEvaluation":      view = "consulterUneEvaluation";
                                                    break;
                case "evaluerUnLivre":              view = "evaluerUnLivre";
                                                    break;
                case "login":                       view = "main";
                                                    break;
                case "main":                        view = "main";
                                                    break;
                default:                            view = "404";
                                                    break;
            } 
            */            
        }
        if ( request.getSession().getAttribute("connected") == null)
            view = "login";
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>The book - <%=view%></title>
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="css/base.css" rel="stylesheet">
        <link href="css/login.css" rel="stylesheet">
<!--link href="css/<%--= view--%>.css" rel="stylesheet"-->        
<%-- view = view+".jsp";--%>
        <!-- Custom Fonts -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
        <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <!-- jQuery -->
        <script src="js/jquery.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>        
        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <jsp:include page="alert.jsp"/>
<!--jsp:include page="<%--= view --%>"/-->
        <jsp:include page="<%= view+".jsp" %>"/>
        <jsp:include page="footer.jsp"/>        
    </body>
</html>
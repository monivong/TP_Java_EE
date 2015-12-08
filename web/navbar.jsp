<%
HttpSession objetSession = request.getSession();
if (objetSession.getAttribute("connected") != null)
{
%>
<aside class="sidebar-left">
    <a class="company-logo" href="/TP_Java_EE/"><h1><i class="fa fa-home"></i></h1></a>

    <div class="sidebar-links">
            <a class="link-green" href="index.jsp?page=chercherUnCours"><i class="fa fa-search"></i><div class="hidden-xs hidden-sm">Chercher un cours</div></a>
            <a class="link-green" href="index.jsp?page=consulterLaListeDesCours"><i class="fa fa-book"></i><div class="hidden-xs hidden-sm">Consulter la liste des cours</div></a>
            <a class="link-green" href="index.jsp?page=consulterUneEvaluation"><i class="fa fa-briefcase"></i><div class="hidden-xs hidden-sm">Consulter une évaluation</div></a>
            <a class="link-green" href="index.jsp?page=evaluerUnLivre"><i class="fa fa-pencil-square-o"></i><div class="hidden-xs hidden-sm">Évaluer un livre</div></a>
            <a class="link-green" href="./controleurFrontal?action=logout"><i class="fa fa-sign-out"></i><div class="hidden-xs hidden-sm">Se déconnecter</div></a>
    </div>
</aside>
<aside class="sidebar-right">
    <img src="./images/mockingbird.png" class="img-responsive" />
</aside>
<script>
    $(function () {
        var links = $('.sidebar-links > a');
        links.on('click', function () {
                links.removeClass('selected');
                $(this).addClass('selected');
        })
    });
</script>
<%
}
%>
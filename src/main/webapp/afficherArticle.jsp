<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%
	if (session.getAttribute("panier")==null) {
		response.sendRedirect("./index.jsp");
	} else {
		CatalogueManager catalogueManager = (CatalogueManager) application
									.getAttribute("catalogueManager");
		String refArticle = request.getParameter("refArticle");
		Article article = catalogueManager.chercherArticleParRef(refArticle);
%>


<link href="css/test.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
var unique_price = parseFloat(<%= article.getPrix() %>) ;
var end_quantity = 1;
$(document).ready(function(){
    $("#quantity_input").on("input", function(){
        var value =  $(this).val();
        var quantity = parseInt(value, 10);
        end_quantity = quantity;
       $("#price").text(String(unique_price*quantity)+" €");
    });
});
function valid(){
        console.log(end_quantity) ;
        console.log("http://localhost:8080/tpv37/controlePanier.jsp?refArticle=<%=article.getRefArticle()%>&quantity="+end_quantity+"&commande=ajouterLigne");
        window.location = "http://localhost:8080/tpv37/controlePanier.jsp?refArticle=<%=article.getRefArticle()%>&quantity="+end_quantity+"&commande=ajouterLigne";
    }
</script>


<nav id="navigation" class="col-full" role="navigation">
	<ul id="main-nav" class="nav fl">
		<li id="menu-item-290"
			class="menu-item menu-item-type-custom menu-item-object-custom current-menu-item">
			<a href="<%=response.encodeURL("./afficheRecherche.jsp")%>">Rechercher
				un article</a>
		</li>
		<li id="menu-item-290"
			class="menu-item menu-item-type-custom menu-item-object-custom">
			<a href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier</a>
		</li>
	</ul>
</nav>

<div class="grid-container">
  <div class="ajout_panier">
      <button type="button" onClick=valid()>
          Ajouter au panier
      </button>
  </div>
  <div class="quantite">
    <input id="quantity_input" type="number" size="4" title="Qty" value="1" name="quantity" min="1" step="1">
  </div>
  <div class="prix">
    <h2 id="price"><%= article.getPrix() %> €</h2>
  </div>
  <div class="titre">
    <h1> <%= article.getTitre() %> </h1>
  </div>
  <div class="image">
    <img style="height:100%;" src="<% if (article.getImage().startsWith("http"))
                        out.print(article.getImage()) ;
                    else
                        out.print("./images/"+article.getImage()) ; %>" >

  </div>
</div>
<%
    }
%>
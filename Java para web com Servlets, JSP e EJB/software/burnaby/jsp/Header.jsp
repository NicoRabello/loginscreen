<%
  String base = (String) application.getAttribute("base");
  String imageUrl = (String) application.getAttribute("imageUrl");
%>

<TABLE WIDTH="740" CELLPADDING="0"
  HEIGHT="75" CELLSPACING="0" BORDER="0">
<TR>
  <TD ALIGN="left" BGCOLOR="F6F6F6">
    <FONT FACE="Verdana" SIZE="4">Burnaby e-Mall</FONT>
  </TD>
  <TD ALIGN="RIGHT" BGCOLOR="F6F6F6">
    <A HREF="<%=base%>?action=displayShoppingCart"><IMG 
      BORDER="0" SRC="<%=(imageUrl + "cart.gif")%>"></A>
    &nbsp;&nbsp;&nbsp;
  </TD>
</TR>
</TABLE>
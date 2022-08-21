<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="RegistroYSolucionDeIncidencias.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Contacto.</h2>
    <address>
        <strong>Mail:</strong>   <a href="mailto:Support@example.com">agustinmartinez729@gmail.com</a><br />
    </address>
<address>
        <strong>Telefono:</strong> 3584871818</address>
<address>
        Linkedin:
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://www.linkedin.com/in/agustin-nicolas-martinez-7518b6197/">Agustin Nicolas Martinez</asp:HyperLink>
    </address>
</asp:Content>

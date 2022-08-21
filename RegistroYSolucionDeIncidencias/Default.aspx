<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RegistroYSolucionDeIncidencias._Default" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <br />
<br />
<asp:Label ID="Label1" runat="server" Text="Título: "></asp:Label>
<br />
    <asp:TextBox ID="TextBox1" runat="server" Width="350px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1" ErrorMessage="* Campo requerido" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
<br />
<asp:Label ID="Label2" runat="server" Text="Descricpción:"></asp:Label>
<br />
    <asp:TextBox ID="TextBox2" runat="server" Height="70px" TextMode="MultiLine" Width="350px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="* Campo requerido" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
    <br />
    <asp:Label ID="Label4" runat="server" Text="Prioridad:"></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" Height="23px" Width="200px">
        <asp:ListItem Selected="True">Alta</asp:ListItem>
        <asp:ListItem>Media</asp:ListItem>
        <asp:ListItem>Baja</asp:ListItem>
    </asp:DropDownList>
<br />
<br />
<asp:Button ID="Button1" runat="server" Text="Registrar" OnClick="Button1_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Modificar" />
<br />
<br />
<asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Incidencias()"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label6" runat="server" Font-Size="X-Large" Text="Resueltas()"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderStyle="None" CellPadding="25" CellSpacing="10" DataKeyNames="id" DataSourceID="SqlDataSource1" EmptyDataText="No hay registros de datos para mostrar." Height="350px" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" OnRowDeleted="GridView1_RowDeleted" OnRowUpdating="GridView1_RowUpdating" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="875px" AllowPaging="True" PageSize="5">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="titulo" HeaderText="titulo" SortExpression="titulo" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion" />
            <asp:BoundField DataField="prioridad" HeaderText="prioridad" SortExpression="prioridad" />
            <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha" />
            <asp:BoundField DataField="estado" HeaderText="estado" SortExpression="estado" />
            <asp:ButtonField CommandName="Resolver" Text="Resolver" />
        </Columns>
        <RowStyle BorderStyle="None" />
    </asp:GridView>
    <br />
    <asp:Label ID="Label5" runat="server"></asp:Label>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IncidenciasConnectionString %>" DeleteCommand="DELETE FROM [incidencias] WHERE [id] = @id" InsertCommand="INSERT INTO [incidencias] ([titulo], [descripcion], [prioridad], [fecha], [estado]) VALUES (@titulo, @descripcion, @prioridad, GETDATE(), @estado)" ProviderName="<%$ ConnectionStrings:IncidenciasConnectionString.ProviderName %>" SelectCommand="SELECT [id], [titulo], [descripcion], [prioridad], [fecha], [estado] FROM [incidencias] ORDER BY [fecha] DESC">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="titulo" Type="String" />
            <asp:Parameter Name="descripcion" Type="String" />
            <asp:Parameter Name="prioridad" Type="String" />
            <asp:Parameter Name="estado" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="titulo" Type="String" />
            <asp:Parameter Name="descripcion" Type="String" />
            <asp:Parameter Name="prioridad" Type="String" />
            <asp:Parameter Name="estado" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCantidad" runat="server" ConnectionString="<%$ ConnectionStrings:IncidenciasConnectionString %>" SelectCommand="select count(id) as 'Cantidad' from Incidencias"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceResueltas" runat="server" ConnectionString="<%$ ConnectionStrings:IncidenciasConnectionString %>" ProviderName="<%$ ConnectionStrings:IncidenciasConnectionString.ProviderName %>" SelectCommand="  select count(id) as 'Resueltas' from incidencias where estado='Solucionada'"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSolucionar" runat="server" ConnectionString="<%$ ConnectionStrings:IncidenciasConnectionString %>" ProviderName="<%$ ConnectionStrings:IncidenciasConnectionString.ProviderName %>" UpdateCommand="update incidencias set estado='Solucionada' where id=@id">
        <UpdateParameters>
            <asp:Parameter Name="id" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

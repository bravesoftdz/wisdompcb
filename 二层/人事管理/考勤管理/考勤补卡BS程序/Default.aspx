<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>�������¹���ϵͳ</title>
</head>
<body>
    <form id="default" method="post" runat="server">
    <div align="center">
        <table id="Table2" style="height: 289px" cellspacing="1" cellpadding="1" width="98%"
            align="center" border="1">
            <tr>
                <td style="height: 60px" align="center" bgcolor="#cccccc">
                    <font size="6"><strong>���¹���ϵͳ</strong></font>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table id="Table1" style="width: 300px; height: 101px" cellspacing="1" cellpadding="1"
                        width="300" border="0">
                        <tr>
                            <td>
                                �û����
                            </td>
                            <td>
                                <asp:TextBox ID="Tbx_userID" runat="server" width="130"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ����
                            </td>
                            <td>
                                <asp:TextBox ID="Tbx_userpwd" runat="server" TextMode="Password" Width="130"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="Btn_login" runat="server" Text="��¼" Width="52px" 
                                    onclick="Btn_login_Click1"></asp:Button>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="Btn_Reset" runat="server" Text="����" Width="52px" 
                                    onclick="Btn_Reset_Click1"/>
                            </td>
                        </tr>
                    </table>
                    <div align="center">
                        <asp:Label ID="Lbl_message" runat="server"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <h1>
        </h1>
    </div>
    <div align="center">
    </div>
    <font face="����"></font>
    <br />
    <div align="center">
        <font face="����"></font>&nbsp;</div>
    </form>
</body>
</html>

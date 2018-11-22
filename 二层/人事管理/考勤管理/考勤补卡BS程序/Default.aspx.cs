using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class _Default : System.Web.UI.Page 
{
    private void Page_Load( object sender , System.EventArgs e )
    {
        // �ڴ˴������û������Գ�ʼ��ҳ��
    }

    
    protected void Btn_login_Click1( object sender , EventArgs e )
    {
        string username = Tbx_userID.Text;
        string pwd = Tbx_userpwd.Text;
        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(pwd))
        {
            Mgr.ShowAlert(this, "�û���������Ϊ��" );
            return;
        }

        if (!Mgr.CheckStr(username) || !Mgr.CheckStr(pwd))
        {
            Mgr.ShowAlert( this,"�����Ƿ��ַ�" );
            return;
        }

        if (Mgr.Login(this,Tbx_userID.Text, Tbx_userpwd.Text))
        {
            Response.Redirect( "Navigate.aspx");
        }
        else
        {
            //Lbl_message.Text = "�û������������";
        }
        
    }
    protected void Btn_Reset_Click1( object sender , EventArgs e )
    {
        Tbx_userID.Text = "";
        Tbx_userpwd.Text = "";
    }
}

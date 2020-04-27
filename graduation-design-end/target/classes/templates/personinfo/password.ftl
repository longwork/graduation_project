<html>
<head>
    <title>密码设置</title>
    <script src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body>
<div class="wrapper">
    <div style="position: fixed;top:25%;left:35%">
        <div class="easyui-panel" title="密码设置" style="width:400px;padding:30px 70px 20px 70px;">
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" id="oldPassword"  type="text" style="width:100%;height:40px;padding:12px"data-options="prompt:'请输入旧密码',iconCls:'icon-lock',iconWidth:38">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" id="newPassword" type="text" style="width:100%;height:40px;padding:12px" data-options="prompt:'请输入新密码',iconCls:'icon-lock',iconWidth:38">
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" id="rePassword" type="text" style="width:100%;height:40px;padding:12px" data-options="prompt:'再次输入新密码',iconCls:'icon-lock',iconWidth:38">
            </div>
            <div>
                <a onclick="changePassword()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:5px 0px;width:100%;">
                    <span style="font-size:14px;">确认修改</span>
                </a>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    function changePassword() {
        var oldPassword=$('#oldPassword').val();
        var newPassword=$('#newPassword').val();
        var rePassword=$("#rePassword").val();
        if(!oldPassword || !newPassword || !rePassword){
            $.messager.alert('密码提示','密码不能为空');
            return;
        }
        if(newPassword!=rePassword){
            $.messager.alert('密码提示','两次密码输入不一致');
            return;
        }
        $.ajax({
            url : '${request.contextPath}/user/changePassword',
            cache : false,
            type : 'post',
            data:{oldPassword:oldPassword,newPassword:newPassword},
            async : true,
            dataType : "json",
            success : function(result) {
                if (result.state==0) {
                   // window.location.href="/user/showPasswrd";
                    location.reload();
                }else {
                    $.messager.alert('修改密码提示',result.message);
                }
            }
        });
    }
</script>
</html>
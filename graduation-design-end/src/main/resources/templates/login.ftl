<html lang="en">
<head>
    <title>网络银行管理系统</title>
    <script src="/static/js/jquery-1.11.1.min.js"></script>
    <link href="/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5.4.2/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body>
<div class="wrapper" style="background: #607d8b4f">
    <div style="position: fixed;top:25%;left:35%">
        <div class="easyui-panel" title="登录页面" style="width:400px;padding:30px 70px 20px 70px;">
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" style="width:100%;height:40px;padding:12px" id="username"
                       data-options="prompt:'请输入用户名',iconCls:'icon-man',iconWidth:38"/>
            </div>
            <div style="margin-bottom:10px">
                <input class="easyui-textbox" id="password" type="password" style="width:100%;height:40px;padding:12px"
                       data-options="prompt:'请输入密码',iconCls:'icon-lock',iconWidth:38"/>
            </div>
            <div style="margin-bottom:20px">
                <select class="easyui-combobox" id="role" name="role" style="width:140px;height:30px;padding:12px">
                    <option value="普通用户">普通用户</option>
                    <option value="管理员">管理员</option>
                </select>
            </div>
            <div style="margin-bottom:10px">
                <input type="checkbox" checked="checked">
                <span>Remember me</span>
            </div>
            <div>
                <a onclick="login()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
                   style="padding:5px 0px;width:100%;">
                    <span style="font-size:14px;">登录</span>
                </a>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    function login() {
        var username = $('#username').val();
        var password = $('#password').val();
        var role = $("#role").find("option:selected").val();
        if (!username || !password) {
            $.messager.alert('登录提示', '用户名或密码不能为空');
            return;
        }
        $.ajax({
            url: '${request.contextPath}/user/login',
            cache: false,
            type: 'post',
            data: {username: username, password: password, role: role},
            async: true,
            dataType: "json",
            success: function (result) {
                if (result.state == 0) {
                    var account = result.data;
                    /*if(account.role=="管理员") {
                        window.location.href = "/toManagerIndex";
                    }else{*/
                    window.location.href = "/toIndex";
                    // }
                } else {
                    $.messager.alert('登录提示', '登录失败，' + result.message);
                }
            }
        });
    }
</script>
</html>
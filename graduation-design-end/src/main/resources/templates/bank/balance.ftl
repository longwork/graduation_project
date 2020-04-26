<html>
<head>
    <title>存款</title>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body style="margin-top:50px;overflow: hidden;">
    <table class="gridtable" style="width:600px;">
        <tr>
            <th  style="width:200px;">用户名</th>
            <td id="username"></td>
        </tr>
        <tr>
            <th style="width:200px;">账户余额</th>
            <td id="balance"></td>
        </tr>
        <tr>
            <th style="width:200px;">账户状态</th>
            <td id="status"></td>
        </tr>
    </table>

<script type="text/javascript">
    $(function () {
        $.ajax({
            url:'${request.contextPath}/user/getUsername',
            cache:false,
            type:'get',
            async : true,
            dataType:"json",
            success:function (result) {
                if(result.state==0){
                    var account=result.data;
                    var ye=(account.balance==null||account.balance=='')?0:account.balance;
                    $("#username").html(account.username);
                    $("#balance").html(ye+"元");
                    $("#status").html(account.status);
                }else{
                    $.messager.alert('存款操作','存款失败，'+result.message);
                }
            }
        });
    })
</script>
</body>
</html>

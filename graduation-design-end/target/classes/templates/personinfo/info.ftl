<html>
<head>
    <title>个人信息</title>
    <script src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body>
<div class="wrapper" style="padding-left: 20px">

    <div style="padding:10px 0;">
        <a href="javascript:void(0)" data-options="iconCls:'icon-edit'" class="easyui-linkbutton" onclick="update()" style="width:80px;">修改</a>
    </div>

    <div class="easyui-panel" title="个人信息" style="width:600px;padding-top:10px;padding-left: 20px">
        <div style="padding:10px 60px 20px 60px">
            <#--<form id="ff" method="post">-->
                <table cellpadding="5">
                    <tr hidden>
                        <td>id:</td>
                        <td><input type="text" name="id"></input></td>
                    </tr>
                    <tr style="width: 100px">
                        <td style="text-align: right">账户:</td>
                        <td><input type="text" name="accountid" required readonly></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">真实姓名:</td>
                        <td><input type="text" name="realname" required readonly></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">年龄:</td>
                        <td><input type="text" name="age" required readonly></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">性别:</td>
                        <td><#--<input class="easyui-textbox" type="text" name="sex" readonly ></input>-->
                            <select id="cc" name="sex" style="width:150px"></select>
                            <div id="sp">
                                <div style="color:#99BBE8;background:#fafafa;padding:5px;">选择性别</div>
                                <div style="padding:10px">
                                    <input type="radio" name="sex" value="0"/><span>男</span><br/>
                                    <input type="radio" name="sex" value="1"/><span>女</span><br/>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">地址:</td>
                        <td><input name="address" readonly></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">电话号码:</td>
                        <td><input name="telephone" required readonly></input></td>
                    </tr>
                </table>

                <div id="hiddenDiv" style="margin:20px 120px;" hidden>
                    <a href="javascript:void(0)" style="width: 80px" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="changeInfo()" >确定</a>
                    <a href="javascript:void(0)" style="width: 80px"  class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="notChange()" >取消</a>
                </div>

            <#--</form>-->
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    $(function(){
        $('#cc').combo({
            required:true,
            editable:false
        });
        $('#sp').appendTo($('#cc').combo('panel'));
        $('#sp input').click(function(){
            var v = $(this).val();
            var s = $(this).next('span').text();
            $('#cc').combo('setValue', v).combo('setText', s).combo('hidePanel');
        });
    });

    $(function () {
        $.ajax({
            url : '${request.contextPath}/user/getUser',
           // cache : false,
            type : 'post',
            data:{},
            async : true,
            dataType : "json",
            success : function(result) {
                if (result.state==0) {
                    var v=result.data.sex;
                    var s;
                    if(v==0){
                        s="男";
                    }else{
                        s="女";
                    }
                    $('#cc').combo('setValue', v).combo('setText', s).combo('hidePanel');
                    $('input[name="sex"][value="'+v+'"]').prop("checked",true);

                    $("input[name=id]").val(result.data.id);
                    $("input[name=accountid]").val(result.data.accountid);
                    $("input[name=realname]").val(result.data.realname);
                    $("input[name=age]").val(result.data.age);
                    $("input[name=address]").val(result.data.address);
                    $("input[name=telephone]").val(result.data.telephone);
                    /*$(' ').form('load',{
                        id:result.data.id,
                        accountid:result.data.accountid,
                        realname:result.data.realname,
                        age:result.data.age,
                        sex:result.data.sex,
                        cardid:result.data.cardid,
                        address:result.data.address,
                        telephone:result.data.telephone
                    });*/
                }else {
                    $.messager.alert('提示信息',"登录信息失效，请重新登录");
                }
            }
        })
    })


    function update() {
        $("input").attr("readonly",false);
        $("#hiddenDiv").attr("hidden",false);
    }

    function notChange() {
        $("input").attr("readonly",true);
        $("#hiddenDiv").attr("hidden",true);
    }

    function changeInfo() {
        var id=$("input[name=id]").val();
        var accountid=$("input[name=accountid]").val();
        var realname=$("input[name=realname]").val();
        var age=$("input[name=age]").val();
        var address=$("input[name=address]").val();
        var telephone=$("input[name=telephone]").val();
        var sexval=$('input[name="sex"]:checked').val();
        console.log(accountid+","+address+","+realname);
        $.ajax({
            url : '${request.contextPath}/user/updatePerson',
            //cache : false,
            type : 'post',
            data:{
                id:id,
                accountid:accountid,
                realname:realname,
                age:age,
                sex:sexval,
                address:address,
                telephone:telephone
            },
            async : true,
            dataType : "json",
            success : function(result) {
                if (result.state==0) {
                    location.reload();
                }else {
                    $.messager.alert('修改密码提示',result.message);
                }
            }
        });
    }
</script>
</html>
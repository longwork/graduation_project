<html>
<head>
    <title>开户</title>
    <script src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body>
<div class="wrapper" style="padding-left: 20px">

    <div class="easyui-panel" data-options="iconCls:'icon-ok'" title="开户" style="width:600px;padding-top:10px;padding-left: 20px">
        <div style="padding:10px 60px 20px 60px">
                <table cellpadding="3">
                    <tr style="width: 100px">
                        <td style="text-align: right">用户名:</td>
                        <td><input type="text" name="username" required class="easyui-textbox" data-options="prompt:'请输入用户名'"></input></td>
                    </tr>
                    <tr style="width: 100px">
                        <td style="text-align: right">开户密码:</td>
                        <td><input type="text" name="password" required class="easyui-textbox" data-options="prompt:'请输入开户密码'" ></input></td>
                    </tr>
                    <tr style="width: 100px">
                        <td style="text-align: right">开户金额:</td>
                        <td><input type="text" name="balance" required class="easyui-textbox" data-options="prompt:'请输入开户金额'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">姓名:</td>
                        <td><input type="text" name="realname" required class="easyui-textbox" data-options="prompt:'请输入姓名'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">年龄:</td>
                        <td><input type="text" name="age" required class="easyui-textbox" data-options="prompt:'请输入年龄'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">性别:</td>
                        <td>
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
                        <td style="text-align: right">家庭地址:</td>
                        <td><input name="address" class="easyui-textbox" data-options="prompt:'请输入家庭住址'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">电话号码:</td>
                        <td><input name="telephone" required class="easyui-textbox" data-options="prompt:'请输入电话号码'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">证件号码:</td>
                        <td><input name="cardid" required class="easyui-textbox" data-options="prompt:'请输入证件号码'" ></input></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">用户角色:</td>
                        <td><select class="easyui-combobox" id="role" name="role" style="width:140px;height:30px;padding:12px">
                            <option value="普通用户">普通用户</option>
                            <option value="管理员">管理员</option>
                        </select></td>
                    </tr>
                </table>
                <div id="hiddenDiv" style="margin:20px 120px;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  onclick="submitInfo()" style="width:120px">提交</a>
                </div>
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

    function submitInfo() {
        var realname=$("input[name=realname]").val();
        var age=$("input[name=age]").val();
        var address=$("input[name=address]").val();
        var telephone=$("input[name=telephone]").val();
        var sex=$('input[name="sex"]:checked').val();
        var username=$("input[name=username]").val();
        var password=$("input[name=password]").val();
        var cardid=$("input[name=cardid]").val();
        var balance=$("input[name=balance]").val();
        var role=$("#role").find("option:selected").val();

        $.ajax({
            url : '${request.contextPath}/person/submitInfo',
            //cache : false,
            type : 'post',
            data:{
                realname:realname,
                age:age,
                sex:sex,
                address:address,
                telephone:telephone,
                username:username,
                password:password,
                cardid:cardid,
                balance:balance,
                role:role
            },
            async : true,
            dataType : "json",
            success : function(result) {
                if (result.state==0) {
                    $.messager.show({
                        title:'开户操作',
                        msg:'开户成功',
                        timeout:3000,
                        showType:'slide',
                        style:{
                            right:'',
                            top:document.body.scrollTop+document.documentElement.scrollTop,
                            bottom:''
                        }
                    });
                    $("input").val("");
                }else {
                    $.messager.alert('开户信息提示',result.message);
                }
            }
        });
    }
</script>
</html>
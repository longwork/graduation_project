<html>
<head>
    <title>账户详情</title>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body style="overflow: hidden;">
<table class="easyui-datagrid" title="已启用账户详情表" style="width:100%;height:380px;margin-top:20px;margin-left:20px;" id="dg"
       data-options="rownumbers:true,singleSelect:true,pagination:true,iconCls:'icon-ok',url:'/person/getOpenPerson',multiSort:true,toolbar:'#tb'">
    <thead>
    <tr>
        <th data-options="field:'id',width:120,align:'center'">账户</th>
        <th data-options="field:'username',width:100,align:'center'">用户名</th>
        <th data-options="field:'balance',width:80,align:'center'">账户余额(元)</th>
        <th data-options="field:'realname',width:80,align:'center'">姓名</th>
        <th data-options="field:'address',width:150,align:'center'">地址</th>
        <th data-options="field:'cardid',width:150,align:'center'">身份证</th>
        <th data-options="field:'telephone',width:100,align:'center'">电话号码</th>
        <th data-options="field:'status',width:60,align:'center'">状态</th>
    </tr>
    </thead>
</table>
<div id="tb" style="padding:5px;height:auto">
    <div style="margin-bottom:5px">
        <a class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="openStatus(this)">启用</a>
        <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="openStatus(this)">冻结</a>
        <a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="removeInfo()">删除</a>
    </div>
</div>
<script type="text/javascript">
    function openStatus(obj) {
        var id=getSelected();
        var status=$(obj).text();
        if(!id){
            $.messager.alert("提示","请选中一行");
            return;
        }
        $.ajax({
            url : '${request.contextPath}/person/changeStatus',
            // cache : false,
            type : 'post',
            data:{id:id,status:status},
            async : true,
            dataType : "json",
            success : function(result) {
                if(result.state==0){
                    location.reload();
                }else{
                    $.messager.alert('修改操作','操作失败，'+result.message);
                }
            }
        })
    }

    function getSelected(){
        var row = $('#dg').datagrid('getSelected');
        if (row){
            return row.id;
        }
    }

    function removeInfo() {
        var id=getSelected();
        if(!id){
            $.messager.alert("提示","请选中一行");
            return;
        }
        $.ajax({
            url : '${request.contextPath}/person/deleteInfo',
            type : 'post',
            data:{id:id},
            async : true,
            dataType : "json",
            success : function(result) {
                if(result.state==0){
                    location.reload();
                }else{
                    $.messager.alert('删除操作','删除失败，'+result.message);
                }
            }
        })
    }
</script>


</body>
</html>

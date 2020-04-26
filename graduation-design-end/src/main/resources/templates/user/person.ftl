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
<table class="easyui-datagrid" title="账户详情表" style="width:100%;height:380px;margin-top:20px;margin-left:20px;" id="dg"
       data-options="rownumbers:true,singleSelect:true,pagination:true,iconCls:'icon-ok',url:'/person/getAllPerson',multiSort:true,toolbar:'#tb'">
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
        <a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="removeInfo(this)">删除</a>
        <a class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="upload(this)">导出</a>
        <a class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="openExportExcel(this)">导入</a>
    </div>
</div>
<div style="position:fixed;left:20%;top:20%;">
    <form id="form1" action="" method="post" enctype="multipart/form-data">
        <div id="export" class="easyui-panel" title="文件上传"  style="width:400px;padding:30px 70px 50px 70px">
            <div style="margin-bottom:10px">
                文件:<input class="easyui-filebox" name="file" id="upload" data-options="prompt:'请选择文件'" style="padding-left:8px;width:80%">
            </div>
            <div style="margin-bottom:10px">
                备注:<input name="description" class="easyui-textbox" style="padding-left:8px;width:80%">
            </div>
            <div style="margin-bottom:10px">
                <a style="color: red">文件格式:.xlsx/.xls</a>
            </div>
            <div>
                <input style="width:30%" type="button" value="上传" onclick="exportExcel()">
                <input style="width:30%" type="button" value="关闭" onclick="offExportExcel()">
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    $(function () {
        offExportExcel();
    });
    function openExportExcel() {
        $('#export').panel('open');
    }
    function offExportExcel() {
        $('#export').panel('close');
    }
    function exportExcel() {
        $("#form1").form('submit',{
            url:'${request.contextPath}/person/exportExcel',
            async : true,
            dataType : "json",
            success:function(data){
                if(data=="SUCCESS"){
                    $.messager.show({
                        title:'上传操作',
                        msg:'上传成功',
                        timeout:3000,
                        showType:'slide',
                        style:{
                            right:'',
                            top:document.body.scrollTop+document.documentElement.scrollTop,
                            bottom:''
                        }
                    });
                    $('#export').panel('close');
                }else{
                    $.messager.alert("上传失败,"+data);
                }
            }
        });
    }
    function openStatus(obj) {
        var id=getSelected();
        if(!id){
            $.messager.alert("提示","请选中一行");
            return;
        }
        var status=$(obj).text();
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

    function upload() {
        var form = $("<form>"); //定义一个form表单
        form.attr("style", "display:none");
        form.attr("target", "");
        form.attr("method", "get");
        form.attr("action", '${request.contextPath}/person/exportInfo');
        $("body").append(form); //将表单放置在web中
        form.submit(); //表单提交
    }

</script>


</body>
</html>

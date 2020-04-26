<html>
<head>
    <title>取款</title>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var day = new Date();
            day.setTime(day.getTime());
            var month=day.getMonth()+1;
            var d=day.getDate();
            var hour = day.getHours();
            var minute = day.getMinutes();
            var second = day.getSeconds();
            var today= day.getFullYear()+"-" + ("0"+month).slice(-2) + "-" + ("0"+d).slice(-2);
            //var today=("0"+d).slice(-2)+"/"+("0"+month).slice(-2)+"/"+day.getFullYear()+" "+hour+":"+minute+":"+second;
            //var today=d+"/"+month+"/"+day.getFullYear()+" "+hour+":"+minute+":"+second;
            $('#today').val(today);
        })
    </script>
</head>
<body style="margin-top:50px;overflow: hidden;">
    <table class="gridtable" style="width:800px;">
        <tr>
            <th>取款时间</th>
            <td>
                <input type="date" name="datetime" id="today" readonly/>
               <#-- <input class="easyui-datetimebox" value="22/3/2018 20:1:5" style="width:200px">-->
            </td>
        </tr>
        <tr>
            <th>取款金额</th>
            <td>
                <input type="text" name="trMoney"/>
            </td>
        </tr>
        <tr>
            <th></th>
            <td><a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="height: 31px; width: 80px;" onclick="save()">确认</a></td>
        </tr>
    </table>

<script type="text/javascript">
    //初始化日期

    //取款
    function save() {
        var datetime=$("[name=datetime]").val();
        var trMoney=$("[name=trMoney]").val();
        if(!trMoney){
            $.messager.alert('Warning','请输入取款金额');
            return;
        }
        $.ajax({
            url:'${request.contextPath}/trans/save',
            data:{datetime:new Date(datetime),trMoney:trMoney,type:"取款"},
            cache:false,
            type:'post',
            async : true,
            dataType:"json",
            success:function (result) {
                if(result.state==0){
                    $.messager.show({
                        title:'取款操作',
                        msg:'取款成功',
                        timeout:3000,
                        showType:'slide',
                        style:{
                            right:'',
                            top:document.body.scrollTop+document.documentElement.scrollTop,
                            bottom:''
                        }
                    });
                    $("input[name=trMoney]").val("");
                }else{
                    $.messager.alert('取款操作','取款失败，'+result.message);
                }
            }
        });
    }
</script>
</body>
</html>

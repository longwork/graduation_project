<html>
<head>
    <title>存款</title>
    <link href="${request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/gray/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
</head>
<body style="overflow: hidden;">
<table class="easyui-datagrid" title="账户交易明细详情表" style="width:900px;height:380px;margin-top:20px;margin-left:20px;" id="dg"
       data-options="rownumbers:true,singleSelect:true,pagination:true,iconCls:'icon-ok',multiSort:true,toolbar:'#tb'">
    <thead>
    <tr>
        <th data-options="field:'otherid',width:180,align:'center'">对方账户</th>
        <th data-options="field:'trMoney',width:120,align:'center'">交易金额(元)</th>
        <th data-options="field:'type',width:120,align:'center',formatter:formatType">交易类型</th>
        <th data-options="field:'datetime',width:300,align:'center',formatter:formatDate">交易日期</th>
    </tr>
    </thead>
</table>
<div id="tb" style="padding:5px;height:auto">
    <div>
        开始时间: <input class="easyui-datebox" style="width:100px" id="beginTime">
        结束时间: <input class="easyui-datebox" style="width:100px" id="endTime">
        交易类型:
        <select class="easyui-combobox" panelHeight="auto" style="width:100px" id="type">
            <option value="">全部</option>
            <option value="存款">存款</option>
            <option value="取款">取款</option>
            <option value="转账">转账</option>
        </select>
        <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="loadlist()">搜索</a>
    </div>
</div>
<script>
    $(function () {
        loadlist();
    });
    function loadlist() {
        var beginTime=$('#beginTime').val();
        var endTime=$('#endTime').val();
        var type=$('#type').find("option:selected").val();
        $.ajax({
            url:'${request.contextPath}/trans/getAllTrans',
            data:{beginTime:beginTime,endTime:endTime,type:type},
            cache:false,
            type:'post',
            async : true,
            dataType:"json",
            success:function (data) {
                $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
            }
        })
    }

    function pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{
                    pageNumber:pageNum,
                    pageSize:pageSize
                });
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }

    function formatType(val,row){
        if ("取款"==val){
            return '<span style="color:red;">'+val+'</span>';
        }else if ("转账"==val){
            return '<span style="color:blue;">'+val+'</span>';
        } else {
            return val;
        }
    }

    function formatDate(val,row) {
        if(val==null || val==''){
            return "";
        }else{
            return parseDate(val);
        }
    }

    function parseDate(long) {
        var date=new Date(long);
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        return year+'-'+("0"+month).slice(-2)+'-'+("0"+day).slice(-2)+' '+("0"+hour).slice(-2)+':'+("0"+minute).slice(-2)+':'+("0"+second).slice(-2);
    }
</script>


</body>
</html>

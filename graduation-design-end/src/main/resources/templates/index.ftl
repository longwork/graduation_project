<html>
<head>
    <meta charset="UTF-8">
    <title>Complex Layout - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/jquery-easyui-1.5.4.2/themes/icon.css">
    <script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/jquery-easyui-1.5.4.2/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="${request.contextPath}/static/ztree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${request.contextPath}/static/ztree/js/jquery.ztree.all-3.5.min.js"></script>
</head>
<body>
<div class="easyui-layout" style="width:100%;height:800px;">
    <div data-options="region:'north'" style="height:90px;">
        <span style="font-size: 30px; position: relative; left: 46px; bottom: -24px;font-weight: 600;width: 150px;overflow: hidden">网上银行业务系统</span>
        <div style=" float: right; margin: 40px 20px 8px 0;font-size: 16px;overflow: hidden">
            <a id="loginId" class="easyui-linkbutton" data-options="iconCls:'icon-man'" title="${Session["role"]}" style="width:100px;height: 30px;line-height: 30px;">
               ${Session["username"]}
            </a>
            <a  onclick="getLock()" class="easyui-linkbutton" title="锁屏" data-options="iconCls:'icon-lock'" style="width:60px;height: 30px;line-height: 30px;">锁屏</a>
            <a  href="/toLogin" class="easyui-linkbutton" title="注销" data-options="iconCls:'icon-redo'" style="width:60px;height: 30px;line-height: 30px;">注销</a>
        </div>
    </div>
    <div data-options="region:'west',split:true" title="<span class='glyphicon glyphicon-list'></span> 功能菜单" style="width:220px;height: auto;overflow: hidden">
        <ul id="tree" class="ztree" style="width: 100%; height: 100%; overflow: auto;"></ul>
    </div>
    <div data-options="region:'center',title:'内容',iconCls:'icon-ok'">
        <div id="tt" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
            <div title="首页" style="position: absolute;height: 600px;">
                <p style="font-size: 24px;color: #607d8b;margin-left:10%;overflow: hidden;height: 70px;margin-top: 90px;">《欢迎使用网上银行业务系统》</p>
                <p style="height: 236px;overflow: hidden;margin-left:10%;font-weight: 600">- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - </p>
                <div style="position: relative;bottom: 0px;width: 100%;background: #607d8b4f;height: 218px;">

                </div>
            </div>
        </div>
    </div>
    <div id="mm" class="easyui-menu" style="width: 150px;">
        <div name="1">刷新</div>
        <div name="2">关闭当前</div>
        <div name="3">全部关闭</div>
        <div name="4">关闭其他</div>
    </div>
</div>
<!-- 一键锁定屏幕解锁对话框 模态对话框 -->
<div id="dlg-lock" class="easyui-dialog" style="width:360px;height:120px;" data-options="closed: true,modal:true,title:''">
    <form id="lock_form">
        <div style="float:left;margin-top: 20px;">
            <label style="margin-right:5px;height:30px;font-size:12px;">解锁密码:</label>
            <input class="easyui-textbox" style="float:left;width:250px;height:30px;" type="password" id="unlock_passwd" data-options="required:true,prompt:'请输入解锁密码!'"/>
        </div>
        <div style="float:left;margin-left:115px;margin-top:10px;">
            <a href="javascript:void(0)" class="easyui-linkbutton c3" data-options="iconCls:'icon-ok'" style="float:left;width:80px;height:26px;" onclick="unlockSubmit();">提交</a>
        </div>
    </form>
</div>
</body>

<script type="text/javascript">

    /*$(document).keyup(function(event){
        switch(event.keyCode){
            case 27:
            {
                //检测按键：ESC,锁住网页
                //alert("ESC");
                $('#dlg-lock').dialog('open').dialog('center');
                $('#lock_form').form('clear');
            }
                break;
        }
    });*/
    //锁屏
    function getLock() {
        $('#dlg-lock').dialog('open').dialog('center');
        $('#lock_form').form('clear');
    }
    //解锁
    function unlockSubmit()
    {
        var passwd = document.getElementById('unlock_passwd').value;
        $.ajax({
            url: '/user/getLock',
            type: 'POST',
            dataType: 'json',
            data: {
                'password': passwd
            },
            success: function(result){
                if(result.state == 0){
                    $('#dlg-lock').dialog('close');
                }else{
                    $.messager.alert('解锁提示',result.message);
                }
            },
            error: function(){
                $.messager.alert("解锁出错！");
            }
        });
    }
    function getUsername() {
        $.ajax({
            url : '/user/getUsername',
            cache : false,
            type : 'get',
            async : true,
            dataType : "json",
            success : function(obj) {
                if (obj.data) {
                   //$("#loginId").html(obj.data.username);
                }else {
                    window.location.href="/toLogin";
                }
            }
        });
    }

    $(function () {
        getMenu();
        getUsername();
    });
    function addTab(title, href) {
        var tt = $('#tt');
        if (tt.tabs('exists', title)) {//如果tab已经存在,则选中并刷新该tab
            tt.tabs('select', title);
        } else {
            var content = '未实现';
            if (href) {
                content = '<iframe scrolling="auto" frameborder="0" src="' + href + '" ></iframe>';
            }
            tt.tabs('add', {
                title : title,
                closable : true,
                content : content
            });
            $("iframe").css({
                width : '100%',
                height : '100%'
            });
        }
    }

    function closeTab(menu, type) {
        var allTabs = $("#tt").tabs('tabs');
        var allTabtitle = [];
        $.each(allTabs, function(i, n) {
            var opt = $(n).panel('options');
            if (opt.closable)
                allTabtitle.push(opt.title);
        });
        var curTabTitle = $(menu).data("tabTitle");
        switch (type) {
            case "1": //刷新
                $("#tt").tabs('select', curTabTitle);
                var _refresh_ifram = $("#tt").tabs("getTab", curTabTitle).panel().find('iframe');
                _refresh_ifram.attr('src', _refresh_ifram.attr('src')).css({
                    width : '100%',
                    height : '100%'
                });

                break;
            case "2"://关闭当前
                $("#tt").tabs("close", curTabTitle);
                return false;
                break;
            case "3"://全部关闭
                for (var i = 0; i < allTabtitle.length; i++) {
                    $('#tt').tabs('close', allTabtitle[i]);
                }
                break;
            case "4"://除此之外全部关闭
                for (var i = 0; i < allTabtitle.length; i++) {
                    if (curTabTitle != allTabtitle[i])
                        $('#tt').tabs('close', allTabtitle[i]);
                }
                $('#tt').tabs('select', curTabTitle);
                break;
        }

    }

    var setting = {
        view : {
            dblClickExpand : true,
            showLine : true,
            selectedMulti : false
        },
        callback : {
            onClick : zTreeOnClick
        }
    };
    function zTreeOnClick(event, treeId, treeNode) {
        if(treeNode.parentId==null || treeNode.parentId===''){
            if(treeNode.children!=null && treeNode.children!==''){
                return;
            }
        }
        if (treeNode.action && treeNode.action != "") {
            addTab(treeNode.name, treeNode.action);
        }
    };

    $(function() {
        $('#tt').tabs({
            onContextMenu : function(e, title, index) {
                e.preventDefault();
                if (index > 0) {
                    $('#mm').menu('show', {
                        left : e.pageX,
                        top : e.pageY
                    }).data("tabTitle", title);
                }
            }
        });
        //右键菜单click
        $("#mm").menu({
            onClick : function(item) {
                closeTab(this, item.name);
            }
        });
        getMenu();
        $("#menu").on("click", "li", function() {
            $("li").removeClass("selected");
            $(this).addClass("selected");
        });
    });
    function getMenu() {
        $.ajax({
            url : '/menu',
            //cache : false,
            type : 'get',
            async : true,
            dataType : "json",
            success : function(data) {
                if (data) {
                    var zNodes = data;
                    var t = $("#tree");
                    t = $.fn.zTree.init(t, setting, zNodes);
                }
            }
        });
    }
</script>
</html>
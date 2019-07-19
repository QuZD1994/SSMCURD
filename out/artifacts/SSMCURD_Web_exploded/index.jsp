<%--
  Created by IntelliJ IDEA.
  User: QuLvT
  Date: 2019/7/14
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工信息</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <!--引入bootstrap样式-->
    <%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <%--<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>
</head>
<body>

<!-- 添加员工按钮的模态框 -->
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span id="helpBlock1" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@lzu.edu.cn">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked = checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改员工信息的模态框 -->
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span id="helpBlock3" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@lzu.edu.cn">
                            <span id="helpBlock4" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked = checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!--搭建显示页面-->
<div class="container">
    <!--显示标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--显示按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button id="emp_add_modal_btn" class="btn btn-primary">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord;
    var currentPage;//当前页
    //===================================显示模块========================================================
    //1.页面加载完成以后，直接去发送一个ajax请求，要到页面数据
    $(function(){
        to_Page(1);
    });

    function to_Page(pn){
        $.ajax({
            url:"${APP_PATH}/empslist",
            data:"pn="+pn,
            typt:"GET",
            success:function(result){
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析分页数据
                build_page_info(result);
                //分页条
                build_page_nav(result);
            }
        });
    }

    /**
     * 1.解析并显示员工数据
     */
    function build_emps_table(result){
        // 先清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        //每一个item 就是list里面的每一项 即每一行员工的数据
        $.each(emps, function(index, item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性 来表示当前员工的id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性 来表示当前删除的员工的id
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });

    }

    /**
     * 2.解析分页信息
     */
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+" 页, 总"+
            result.extend.pageInfo.pages+" 页, 总"+
            result.extend.pageInfo.total+" 条记录");

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    /**
     * 3.解析分页条
     */

    function build_page_nav(result){

        //page_nav_area
        //每次append之前都应该把之前的页面内容清空这样才能达到刷新的目的
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加翻页事件
            firstPageLi.click(function(){
                to_Page(1);
            });
            prePageLi.click(function () {
                var page = result.extend.pageInfo.pageNum - 1;
                to_Page(page);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            lastPageLi.click(function () {
                to_Page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                var page = result.extend.pageInfo.pageNum + 1;
                to_Page(page);
            });
        }


        //ul中添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function(index, item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_Page(item);
            });
            ul.append(numLi);
        });
        //ul中添加后一页和末页
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav中
        var navEle = $("<nav></nav>").append(ul);
        //把nav添加到导航条区域
        navEle.appendTo("#page_nav_area");
    }

    //===================================添加模块========================================================

    /**
     * 表单重置方法 清空表单
     */
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
    /**
     * 点击新增 打开模态框
     */

    $("#emp_add_modal_btn").click(function () {
        //打开模态框，清除原来的表单数据（表单重置）
        //包含表单的样式也要重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        $("#empAddModal").modal({
           backdrop:"static"
        });
    });

    /**
     *查出所有部门信息,并显示在下拉列表中
     */
    function getDepts(ele) {
        //在查找部门信息之前，先清空原来的
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            typt:"GET",
            success:function(result){
                //拿到部门数据
                //console.log(result);
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function (index, item) {
                    //attr("value", item.deptId) : 表示option的value 这里为部门编号
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    /**
     *校验结果的提示信息
     */

    function validate_add_form(){
        // 拿到要校验的数据, 使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //校验信息包装成一个新的方法
            //alert("用户名应该是2-5位中文或者6-16位英文和数字组合");
            //应该清空这个元素之前的样式

            show_validate_msg("#empName_add_input", "error", "用户名必须是2-5位中文或者6-16位英文和数字组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        //2.校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式错误");
            show_validate_msg("#email_add_input", "error", "邮箱格式错误");
            return false;
        }else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }
    /**
     *校验结果的提示信息
     */
    function show_validate_msg(ele, status, msg) {
        //应该清空这个元素之前的样式
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if (status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    /**
     * 校验用户名是否可用 用户名是否重复
    */
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用 this代表当前输入框#empName_add_input
        //success 返回两种状态Msg.success();  Msg.fail(); 100 代表成功
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    //如果用户名校验成功了  给保存按钮添加一个属性
                    $("#emp_save_btn").attr("ajax-va", "success");
                }else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    //保存应该无效
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    /**
     * 保存员工信息
     */
    $("#emp_save_btn").click(function () {
        //先对要提交给服务器的数据进行校验
        if (!validate_add_form()){
            return false;
        }

        //判断之前的ajax用户名检验是否成功，如果成功 检验用户名是否重复
        if ($("#emp_save_btn").attr("ajax-va") == "error"){
            return false;
        }

        //1.模态框中填写的表单数据提交给服务器保存
        //2.发送ajax请求保存员工
        //serialize()快速获取表单中填写的数据
        $.ajax({
            url:"${APP_PATH}/emp",
            //数据就是模态框中填写的数据
            data:$("#empAddModal form").serialize(),
            typt:"POST",
            success:function(result){
                //alert(result.msg);
                //员工保存成功
                if (result.code == 100){
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    //只要传入的页码足够大就可显示最后一页，此处将总记录数作为最大的页码
                    to_Page(totalRecord);
                }else {//此处自己敲代码时失败

                    //显示失败信息
                    console.log(result);
                    //有哪个字段的错误信息 就显示哪个字段的
                    // 校验失败，显示失败信息
                    if (result.extend.errorFields.email != undefined) {
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName != undefined) {
                        // 显示用户名错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //===================================更新模块========================================================
    //1.按钮创建之前就绑定了click,这样不符合逻辑 所以按钮点击事件绑定不上 编辑按钮是后来通过查数据库加载出来的 其加载顺序了script代码同时执行
    //解决：1）可以在创建按钮绑定事件
    //     2）使用on方法
    $(document).on("click", ".edit_btn", function () {
       //alert("edit");
        //1.查出部门信息，共显示部门下拉列表
        getDepts("#dept_update_select");
        //2.查出员工信息，并显示员工信息
        //当前点击按钮的id
        getEmp($(this).attr("edit-id"));
        //3.弹出模态框 把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    /**
     * 查询员工信息 并显示
     */
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name = gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    /**
     * 点击更新按钮 绑定点击事件 更新员工信息
     */
    $("#emp_update_btn").click(function () {
        //验证邮箱信息
        //2.校验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式错误");
            show_validate_msg("#email_update_input", "error", "邮箱格式错误");
            return false;
        }else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求 保存更新的员工数据
        //后台使用put 前端post 无法用serialize无put方法故+"&_method=PUT"
        //web.xml 配置了HttpPutFormContentFilter -解决页面直接发送PUT请求
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            //type:"POST",
            type:"PUT",
            //data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                //关闭模态框
                $("#empUpdateModal").modal('hide');
                //回到本页面
                to_Page(currentPage);
            }
        });
    });
    //===================================删除模块========================================================

    /**
     * 单个删除
     */

    $(document).on("click", ".delete_btn", function () {
        //1.弹出是否确认删除对话框  td:eq(2):第三个td
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if (confirm("确认删除【"+empName+"】吗？")) {
            //确认 发送ajax请求 删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页面
                    to_Page(currentPage);
                }
            });
        }
    });

    /**
     * 批量删除
     */
    //完成全选/全不选
    $("#check_all").click(function () {
        //attr获取checked总是undifined
        // dom原生的属性使用prop
        //自定义的属性使用attr
        //全选按钮的选择状态就是每一个都被选中
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    $(document).on("click", ".check_item", function () {
        //$("#check_all").prop("checked")
        //判断当前选中的元素是不是5个
        //alert($(".check_item:checked").length);
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //全部删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"), function () {
            //this表示当前遍历的元素
            //alert($(this).parents("tr").find("td:eq(2)").text());
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串 和后台一致 以"-"分割字符串
            del_ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empName多余的,del_ids多余的-
        empNames =  empNames.substring(0, empNames.length - 1);
        del_ids =  del_ids.substring(0, del_ids.length - 1);
        if (confirm("确认删除【"+empNames+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+del_ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页面
                    to_Page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>

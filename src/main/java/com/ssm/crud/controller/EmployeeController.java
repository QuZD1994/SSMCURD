package com.ssm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.bean.Msg;
import com.ssm.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;


import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工增删改查请求
 */
@Controller
public class EmployeeController {

    //自动装配service组件，查出员工的所有数据
    @Autowired
    EmployeeService employeeService;


    /**
     * 查询员工数据（分页查询）
     * 需要传入页的参数，即jsp页面传过来的 页, 默认第一页
     * model 中的数据是需要传给页面的
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){
        //这不是一个分页查询
        //List<Employee> emps = employeeService.getAll();
        //分页查询，引入PageHelper分页插件
        //在查询之前只需要调用PageHelper.startPage 传入页码以及分页每页大小
        //startPage紧跟的查询就是分页查询
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //用PageInfo对结果进行包装，只需将PageInfo交给页面，封装了详细的分页信息，包括查询出的数据
        //连续显示的页数为5
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

    //ResponseBody将PageInfo信息封装为json,浏览器就会收到json 数据
    //需要导入jackson包
    @RequestMapping("/empslist")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn, 5);// 后面紧跟的查询为分页查询
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);// 用pageInfo封装然后交给页面
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 员工保存
     * 1.支持JSR303校验
     * 2.导入Heberinate-validator
     *  @Valid:代表当保存的时候需要校验
     *  BindingResult:封装校验的结果
     * @return
     */
    @RequestMapping(value = "/emp")
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            //提取校验的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError: fieldErrors) {
                System.out.println("错误的字段名: " + fieldError.getField());
                System.out.println("错误信息: " + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检验用户名是否可用
     */
    @RequestMapping("checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName){
        //判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位英文和数字组合或者是2-5位中文");
        }
        //表达式校验成功了，这是在进行数据库是否重名的校验
        boolean b = employeeService.checkuser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * 根据id查询员工信息
     * @param id
     * @return
     * @PathVariable : id是从路径中取得的
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 员工更新
     * @param employee
     * @return
     * {empId} 需要和实体中的变量名一致，因为此处传的是employee对象
     *
     * 如果直接发送ajax=PUT请求
     * 封装的数据除了empId参数 其他的Employee中的属性全部为空 解决的方式为前端ajax请求中data后+"&_method=PUT"
     * data:$("#empUpdateModal form").serialize()+"&_method=PUT",
     * 问题：请求体中有数据 但是Employee对象封装不上
     * 原因：Tomcat：
     *              1.将请求体中的数据，封装一个map
     *              2.request.getParameter("empName")就会从这个map中取值
     *              3.SpringMVC封装POJO对象的时候，就会把POJO中每个属性的值，request.getParameter得到
     * 故：ajax不能直接发送PUT请求
     *      PUT请求，请求体中的数据request.getParameter拿不到
     *      Tomcat一看是PUT不会封装请求中的数据为map，只有POST形式的请求才封装请求体为map
     *
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 在web.xml中配置上HttpPutFormContentFilter
     * 它的作用:将请求体中的数据解析包装成一个map
     * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        //System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 员工删除
     * @param id
     * @return
     */
   /* @ResponseBody
    @RequestMapping(value = "/emp/{id}")
    public Msg deleteEmpById(@PathVariable("id") Integer id){
        employeeService.deleteEmpById(id);
        return Msg.success();
    }*/

    /**
     * 员工批量删除 单个批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}")
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if (ids.contains("-")){//批量删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String id:str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        }else {//单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }
        return Msg.success();
    }
}

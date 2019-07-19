package com.ssm.crud.test;


import com.github.pagehelper.PageInfo;
import com.ssm.crud.bean.Department;
import com.ssm.crud.bean.Employee;
import com.ssm.crud.dao.DepartmentMapper;
import com.ssm.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * 测试dao层的工作
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 导入Spring单元测试的包
 * @ContextConfiguration 指定Spring配置文件的位置
 * @RunWith(SpringJUnit4ClassRunner.class) 指定测试的是什么 此处为Spring测试，运行哪个单元测试
 * 直接autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    //自动装配，xml中定义了映射器扫描类
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCURD(){
        System.out.println(employeeMapper);
        //1.插入几个部门
        /*departmentMapper.insertSelective(new Department(null, "开发部"));
        departmentMapper.insertSelective(new Department(null, "测试部"));*/
        //2.插入员工
        //employeeMapper.insertSelective(new Employee(null, "jerry", "M", "jerry@163.com", 1));
        //2.批量插入员工，可以执行批量操作的sqlSession 或使用list

        /*for (int i = 0; i < 10; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            employeeMapper.insertSelective(new Employee(null, uid, "M", uid + "@163.com",1));
        }*/
        //EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        /*for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@163.com",1));
        }*/
        DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);

        List<Department> departmentList = departmentMapper.selectByExample(null);
        for (Department dept: departmentList) {
            System.out.println("部门id = " + dept.getDeptId() + " 部门名：" + dept.getDeptName());
        }

    }
}

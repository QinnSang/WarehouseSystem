package controller.system;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Company;
import pojo.Employee;
import service.CompanyService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    CompanyService companyService;

    @RequestMapping("/index")
    public String index(){
        return "system/company/index";
    }

    @RequestMapping("/query")
    @ResponseBody
    public  Map<String,Object> query(@ModelAttribute Company company, HttpSession session, Model model){
        Employee employee= (Employee) session.getAttribute("employee");
        System.out.println("============================="+employee.getRealName()+"=============================");
        PageInfo<Company> pageInfo=companyService.query(company);
        Map<String,Object> tableData =new HashMap<>();
        //这是layui数据表格要求返回的json数据格式
        tableData.put("code", 0);
        tableData.put("msg", "");
        //将全部数据的条数作为count传给前台（一共多少条）
        tableData.put("count", pageInfo.getTotal());
        //将分页后的数据返回（每页要显示的数据）
        tableData.put("data", pageInfo);
        return tableData;
    }

    @RequestMapping("/queryById/{companyId}")
    @ResponseBody
    public Company queryById(@PathVariable("companyId") Integer companyId, Model model){
        Company company=companyService.queryById(companyId);
        return company;
    }
}

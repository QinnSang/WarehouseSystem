package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Expense;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @RequestMapping("/index")
    public String index(){
        return "contract/index";
    }

    @RequestMapping("/toAdd")
    public String toAdd(Model model){
//        List<Expense> expense=new ArrayList<>();
//        expense.add(new Expense(1,"收费1"));
//        expense.add(new Expense(2,"收费2"));
//        model.addAttribute("expense", expense);
        return "contract/addContract";
    }

    @RequestMapping("/toEdit/{contractId}")
    public String toEdit(){
        return "contract/edit";
    }

}

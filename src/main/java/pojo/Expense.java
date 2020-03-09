package pojo;

public class Expense {

    private Integer expenseId;
    private String expenseName;

    public Expense(Integer expenseId, String expenseName) {
        this.expenseId = expenseId;
        this.expenseName = expenseName;
    }

    public Integer getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(Integer expenseId) {
        this.expenseId = expenseId;
    }

    public String getExpenseName() {
        return expenseName;
    }

    public void setExpenseName(String expenseName) {
        this.expenseName = expenseName;
    }
}

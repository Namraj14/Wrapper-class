public class DepartmentWrapper {

    public String departmentName;

    public List<EmployeeWrapper> employees;
}

public class EmployeeWrapper {

    public String employeeName;

    public String designation;
}

DepartmentWrapper dept =
    new DepartmentWrapper();

dept.departmentName = 'Sales';

dept.employees =
    new List<EmployeeWrapper>();

EmployeeWrapper emp =
    new EmployeeWrapper();

emp.employeeName = 'Raj';

emp.designation = 'Manager';

dept.employees.add(emp);

System.debug(dept);

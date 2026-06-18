public class StudentWrapper {

    public String studentName;

    public Integer marks;

    public Boolean isActive;
}

StudentWrapper student = new StudentWrapper();

student.studentName = 'Raj';
student.marks = 95;
student.isActive = true;

System.debug(student.studentName);
System.debug(student.marks);
System.debug(student.isActive);

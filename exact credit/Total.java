import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Total {
	
	public static void main(String[] args)
	{
		// connect to Oracle and input the data 
		try {
			 // create the Oracle DataSource and set the URL
			 OracleDataSource ods = new OracleDataSource();
			 ods.setURL("jdbc:oracle:thin:hr/hr@localhost:1521/XE");
			       
			 // connect to the database and turn off auto commit
			 OracleConnection ocon = (OracleConnection)ods.getConnection();
			 ocon.setAutoCommit(false);
			       
			 // create the statement and execute the query
			 Statement stmt = ocon.createStatement();
			 ResultSet rset = stmt.executeQuery("select employee_id, first_name, last_name, salary from employees");
			       
			 // print out the results for this query
			 System.out.println("employee_id, first_name, last_name, salary");
			 while(rset.next()) {
				 System.out.println(rset.getInt(1) + ",          " +
			                            rset.getString(2)  + ",  " +
			                            rset.getString(3)  + ",  " +
			                            rset.getDouble(4));
			      }
			       
		  } 
		  catch (SQLException e) {
			  System.out.println(e.getMessage());
		  }
		
		// calculate the total and average function
		try {
			 // create the Oracle DataSource and set the URL
			 OracleDataSource ods = new OracleDataSource();
			 ods.setURL("jdbc:oracle:thin:hr/hr@localhost:1521/XE");
			       
			 // connect to the database and turn off auto commit
			 OracleConnection ocon = (OracleConnection)ods.getConnection();
			 ocon.setAutoCommit(false);
			       
			 // create the statement and execute the query
			 Statement stmt = ocon.createStatement();
			 ResultSet rset = stmt.executeQuery("select salary from employees");
			       
			 // calculate the total of all employees' salaries
			  double total = 0; 			                  // the total salaries of all employees
			  int n = 0;                                      // the number of all employees
			  while(rset.next()) {
				  total += rset.getDouble(1);
				  n++;                                        // count the number of employees
			  }
			  
			  double averageSalary = 0;                       // the average salary of all employees   
			  averageSalary = total / n;
			  
			  // print out the result
			  System.out.println();
			  System.out.println("the total salaries of all employees: " + total );
			  System.out.println("Number of employees: " + n );
			  System.out.println("Average salary: " + averageSalary );
         } 
		 catch (SQLException e) {
			 System.out.println(e.getMessage());
	     }
        
    }
	
}

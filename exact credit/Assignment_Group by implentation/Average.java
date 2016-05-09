/* Program to create a 2D array, group by different column
 * and calculate the average of one single column. 
 * Programmer: Hong Zhang 
 * File: Average.java
 * */

public class Average {

	public static void main(String[] args){
		// create a 2D array to record employees' salaries 
		// which one column is employee's ID, 
		// one is current_salary,
		// one is min_salary
		// and the other one is max_salary. 
        int [][] salary = {
        	{1, 9000, 4200, 9000},
        	{2, 8200, 4200, 9000},
        	{3, 7700, 4200, 9000},
        	{4, 7800, 4200, 9000},
        	{5, 6900, 4200, 9000},
        	{6, 13000, 9000, 15000},
        	{7, 9000, 4000, 10000},
        	{8, 8300, 4200, 9000},
        	{9, 10000, 4500, 10500},
        	{10, 9500, 6000, 12000}
        };
        
        // print this array
        System.out.println("ID " + " Current " + "  Min " + "     Max");
        System.out.println("   " + " _salary " + "_salary " + " _salary");
        printArray(salary);
        
        // group this array according the different column
        System.out.println();
        System.out.print("Employee's ID: ");
        for (int index = 0; index < salary.length; index++) 
        	System.out.print(salary[index][0] + " ");
        
        System.out.println();
        System.out.println();
        System.out.print("Employee's Current Salary: ");
        for (int index = 0; index < salary.length; index++) 
        	System.out.print(salary[index][1] + " ");
        
        System.out.println();
        System.out.println();
        System.out.print("Employee's Min Salary: ");
        for (int index = 0; index < salary.length; index++) 
        	System.out.print(salary[index][2] + " ");
        
        System.out.println();
        System.out.println();
        System.out.print("Employee's Max Salary: ");
        for (int index = 0; index < salary.length; index++) 
        	System.out.print(salary[index][3] + " ");
        
        // calculate the total and average of employees' current salaries
        int total = 0; 
        double average = 0;
        System.out.println();
        System.out.println();
        System.out.print("The total of employees' current salaries: ");
        for (int index = 0; index < salary.length; index++) 
        	total += salary[index][1];
        System.out.println(total);
        average = total / salary.length;
        System.out.println();
        System.out.println("The average of employees' current salaries: " + average);
   
    		
	}        
        
	// print out elements of this array
	public static void printArray(int[][] matrix){
	    // loop for each row
		for (int row = 0; row < matrix.length; row++){
		    // loop for each column in row
			for (int col = 0; col < matrix[row].length; col++)
			    System.out.printf("%-3d   ", matrix[row][col]);
		    // newline at end of row
			System.out.print("\n");
		}
	} // end of printArray method

}

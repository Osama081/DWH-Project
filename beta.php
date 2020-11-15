<?php   
require_once  "vendor/fzaninotto/faker/src/autoload.php";

adding_salary();
// counting_years(2004,'00009-1761417-9');
function adding_salary(){
//     echo "HELLO WORLD";
     ini_set('memory_limit','1024m');
    
     $emp_array = filling_array_with_complete_row('employee');
     $job_title = filling_array_with_complete_row('job_title');
     $serverName = "OSAMAINAYAT";
     $connectionOptions = array("Database"=>"dwh");
     $conn = sqlsrv_connect($serverName, $connectionOptions);
     $j = 0 ;
        ini_set('max_execution_time',5600);
    foreach ($emp_array as $emp){
          
      
        $working = $emp['working_status'];
        $hire_date = date_format($emp['hire_date'], 'Y');
        $hire_date_month = date_format($emp['hire_date'],'m');
        $difference = 0 ;
        if ($working == 1) {
            $restricted_date = date('Y', strtotime('2013-01-01'));
            $difference = $restricted_date - $hire_date;
            
            $year_counter = 0;
            $month_counter = 1;
            $loop_counter = 1;
            $emp_cnic = $emp['employee_cnic'];

            $key = array_search($emp['job_title'], array_column($job_title, 'id'));
            $salary = $job_title[$key]['salary'];
            
            $hire_date = date_format($emp['hire_date'],'Y-m-d');
            $temp_date = date('Y',strtotime($hire_date));

            while ($loop_counter <= $difference){
               /**The lines Below Are added to increment according to Performance Reviews */
                $temp_year = $temp_date;
                echo "At Start of year".$temp_year."<br>";
                $this_year_reviews = counting_years($temp_date,$emp_cnic);
                $row =  $this_year_reviews;

                for ($i = 1 ;  $i<= 12 ; $i++){
                   $ending_date = date('Y-m-d',strtotime('+1 months',strtotime($hire_date)));
                    $query = "update salary set basic_salary=? where employee_id=? and effective_date=? and end_date=?";
                    $pre  = sqlsrv_prepare($conn,$query,array(&$salary,&$emp_cnic,&$hire_date,&$ending_date));
                    $results = sqlsrv_execute($pre);
                    $hire_date = date('Y-m-d',strtotime('+1 days',strtotime($ending_date)));
                    // echo "<br>".$query."<br>";
                    if(!$results){
                       die(print_r(sqlsrv_errors()));
                      
                    }

                }     
                    echo "Number of ratings:".$row['number_of_ratings']."<br>";
                    if($row['number_of_ratings'] > 0){
                        $increment_percentage = ($row['sum_of_ratings']/($row['number_of_ratings']*10))*100;
                     //   echo "INCREMENT  %  before    :".$increment_percentage."<br>";
                        if($increment_percentage > 50 ){
                            $increment_year = date('Y',strtotime($hire_date));     
                      //      echo "INCREMENT  YEAR :".$increment_year."<br>";
                        //    echo "INCREMENT  %    :".$increment_percentage."<br>";
                            $increment = ($increment_percentage/1000)*$salary;
                            $salary  += $increment;
                          //  echo "This year Increment = ".$increment."<br>";
                            //echo "This year Increment salaary = ".$salary."<br>";
                            //echo "This year Employee CNIC = ".$emp_cnic."<br>";
                            $incremenet_query = "insert into increments (employee_cnic , increment_year, increment, salary_after_increment) values (?, ? , ? ,?)";
                            $prep = sqlsrv_prepare($conn,$incremenet_query,array(&$emp_cnic, &$increment_year, &$increment_percentage,&$increment));
                          //  if(sqlsrv_execute($prep) == false){
                            //        die(print_r(sqlsrv_errors()));
                           // }

                        }
                   
                    }
                $loop_counter++;
                $year_counter++;
                echo "TEMP YEAR".$temp_year."<br>";
                echo "TEMP temp date".$temp_date."<br>";
                $temp_date = $temp_date;
               $temp_date++;
                // $temp_date =date('Y',strtotime('+1 years',strtotime($temp_date)));
                echo "TEMP YEAR After incrementing".$temp_date."<br>";
                echo "/************************//<br>";
            }
            }
//         echo "HI";
         
        }
    }

function counting_years($year,$emp_id){
    // $sql = "UPDATE Table_1
    // SET OrderQty = ?
    // WHERE SalesOrderID = ?";
    echo "YEAR IN COUNTING REVIEWS METHOD:".$year."<br>";
    $serverName = "OSAMAINAYAT";
    $connectionOptions = array("Database"=>"dwh");
    $conn = sqlsrv_connect($serverName, $connectionOptions);
// Initialize parameters and prepare the statement. 
// Variables $qty and $id are bound to the statement, $stmt.
// $qty = 0; $id = 0;
// $stmt = sqlsrv_prepare( $conn, $sql, array( &$qty, &$id));   
    $q = "exec updating_salary @year=?,@employee_cnic=?";
    $stmt = sqlsrv_prepare( $conn, $q, array( &$year, &$emp_id));
    // $query = "exec updating_salary @year=$year,@employee_cnic='$emp_id'";
   

    // echo $query;
   $result  = sqlsrv_execute($stmt);
//    echo $result;
    if($result == false){
        print_r(sqlsrv_errors());
        // die();
    }
    $row =  sqlsrv_fetch_array($stmt,SQLSRV_FETCH_ASSOC);
    // print_r($row);

    return $row;
}


function filling_array_with_complete_row($table){
    $serverName = "OSAMAINAYAT";
    $connectionOptions = array("Database"=>"dwh");
    $conn = sqlsrv_connect($serverName, $connectionOptions);
    $query = "select * from ".$table;
    $result = sqlsrv_query($conn,$query);
    $array =  array();//it is my array
    if (!$result){
        print_r(sqlsrv_errors());
        die();
    }
    while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC)){
        array_push($array,$row);
    }
    // print_r($array);
    return $array;
}

function deleting_last_fifty(){
  
}


?>
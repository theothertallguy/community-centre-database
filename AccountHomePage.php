<!--Test Oracle file for UBC CPSC304 2018 Winter Term 1
  Created by Jiemin Zhang
  Modified by Simona Radu
  Modified by Jessica Wong (2018-06-22)
  This file shows the very basics of how to execute PHP commands
  on Oracle.
  Specifically, it will drop a table, create a table, insert values
  update values, and then query for values

  IF YOU HAVE A TABLE CALLED "demoTable" IT WILL BE DESTROYED

  The script assumes you already have a server set up
  All OCI commands are commands to the Oracle libraries
  To get the file to work, you must place it somewhere where your
  Apache server can run it, and you must rename it to have a ".php"
  extension.  You must also change the username and password on the
  OCILogon below to be your ORACLE username and password -->

  <html>
    <head>
        <title>CPSC 304 PHP/Oracle Demonstration</title>
    </head>

    <body>

         <!--
        This is the HTML Design for Insert
         -->


        <h2>Insert New Account</h2>
        <form method="POST" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="insertQueryRequest" name="insertQueryRequest">
            AccountID: <input type="text" name="AccID"> <br /><br />
            Balance: <input type="text" name="Balance"> <br /><br />
            Created : <input type="text" name="DateOfCreation"> <br /><br />
            NextRenewal: <input type="text" name="NextRenewal"> <br /><br />
            AccountType: <input type="text" name="AccountType"> <br /><br />

            <input type="submit" value="Insert" name="insertSubmit"></p>
        </form>

        <hr>

        <h2>Update an Account</h2>
        <form method="POST" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
            Old AccountID: <input type="text" name="oldAccountID"><br>
            <!-- New AccountID: <input type="text" name="newAccountID"> -->
            New Balance: <input type="text" name="newBalance">
            New Created: <input type="text" name="newCreated">
            New NextRenewal: <input type="text" name="newNextRenewal">
            New AccountType: <input type="text" name="newAccountType">
            <input type="submit" value="Update" name="updateSubmit"></p>
        </form>



         <!--
        This is the HTML Design for Delete
         -->

        <h2>Delete an Account</h2>
        <form method="POST" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="deleteQueryRequest" name="deleteQueryRequest">
            Enter AccountID: <input type="text" name="AccountID"> <br /><br />



            <input type="submit" value="Delete" name="deleteSubmit"></p>
        </form>

        <hr>

        <!--
        This is the HTML Design for JoinAccount_Member
         -->

        <h2>Find All the Members Associated with an Account</h2>
        <!-- <p>The values are case sensitive and if you enter in the wrong case, the update statement will not do anything.</p> -->
        <form method="POST" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="joinQueryRequest" name="joinQueryRequest">
            Account : <input type="text" name="AccountID"> <br /><br />


            <input type="submit" value="Join" name="joinSubmit"></p>
        </form>

        <hr />

        <h2>Count the Total Number of Accounts</h2>
        <form method="GET" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="countTupleRequest" name="countTupleRequest">
            <input type="submit" name="countTuples" value="Count"></p>
        </form>

        <h2>Display the Tuples in Account</h2>
        <form method="GET" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="displayTupleRequest" name="displayTupleRequest">
            <input type="submit" name="displayTuples" value="Display"></p>
        </form>



        <h2>Group by Account Type and find the max Balance for each type</h2>
        <form method="GET" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="groupRequest" name="groupRequest">
            <input type="submit" name="groupTuples" value="Group By"></p>
        </form>

        <h2>Group by Account Type and find the max Balance for each type, assuming each account type has more than 1 account</h2>
        <form method="GET" action="AccountHomePage.php"> <!--refresh page when submitted-->
            <input type="hidden" id="havingRequest" name="havingRequest">
            <input type="submit" name="havingTuples" value="Group By"></p>
        </form>







        <?php
		//this tells the system that it's no longer just parsing html; it's now parsing PHP

        $success = True; //keep track of errors so it redirects the page only if there are no errors
        $db_conn = NULL; // edit the login credentials in connectToDB()
        $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

        function debugAlertMessage($message) {
            global $show_debug_alert_messages;

            if ($show_debug_alert_messages) {
                echo "<script type='text/javascript'>alert('" . $message . "');</script>";
            }
        }

        function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
            //echo "<br>running ".$cmdstr."<br>";
            global $db_conn, $success;

            $statement = OCIParse($db_conn, $cmdstr);
            //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
                echo htmlentities($e['message']);
                $success = False;
            }

            $r = OCIExecute($statement, OCI_DEFAULT);
            if (!$r) {
                echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
                echo htmlentities($e['message']);
                $success = False;
            }

			return $statement;
		}

        function executeBoundSQL($cmdstr, $list) {
            /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
		See the sample code below for how this function is used */

			global $db_conn, $success;
			$statement = OCIParse($db_conn, $cmdstr);

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn);
                echo htmlentities($e['how ']);
                $success = False;
            }

            foreach ($list as $tuple) {
                foreach ($tuple as $bind => $val) {
                    //echo $val;
                    //echo "<br>".$bind."<br>";
                    OCIBindByName($statement, $bind, $val);
                    unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
				}

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                    echo htmlentities($e['message']);
                    echo "<br>";
                    $success = False;
                }
            }
        }

        function printResult($result , $AccountID) { //prints results from a select statement
            echo "<h4>All Members below are associated with Account: $AccountID </h4>";
            echo "<table>";
            echo "<tr><th>MemberName</th><th>MemberID</th></tr>";

            while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
                echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td></tr>"; //or just use "echo $row[0]"
            }

            echo "</table>";
        }

        function connectToDB() {
            global $db_conn;

            // Your username is ora_(CWL_ID) and the password is a(student number). For example,
			// ora_platypus is the username and a12345678 is the password.
            $db_conn = OCILogon("ora_eric2108", "a12804357", "dbhost.students.cs.ubc.ca:1522/stu");

            if ($db_conn) {
                debugAlertMessage("Database is Connected");
                return true;
            } else {
                debugAlertMessage("Cannot connect to Database");
                $e = OCI_Error(); // For OCILogon errors pass no handle
                echo htmlentities($e['message']);
                return false;
            }
        }

        function disconnectFromDB() {
            global $db_conn;

            debugAlertMessage("Disconnect from Database");
            OCILogoff($db_conn);
        }



        # Functions

        function handleInsertRequest() {
            global $db_conn;

            //Getting the values from user and insert data into the table
            $tuple = array (
                ":bind1" => $_POST['AccID'],
                ":bind2" => $_POST['Balance'],
                ":bind3" => $_POST['DateOfCreation'],
                ":bind4" => $_POST['NextRenewal'],
                ":bind5" => $_POST['AccountType']
            );

            $alltuples = array (
                $tuple
            );

            executeBoundSQL("insert into Account values (:bind1, :bind2,:bind3,:bind4, :bind5)", $alltuples);
            OCICommit($db_conn);
        }


        function handleDeleteRequest() {
            global $db_conn;


           $AccountToDelete = $_POST['AccountID'];


            executePlainSQL("DELETE FROM Account WHERE AccountID = '" . $AccountToDelete ."'"  );
            OCICommit($db_conn);
        }


        function handleJoinRequest() {
            global $db_conn;


            $AccountID = $_POST['AccountID'];

            $result = executePlainSQL("SELECT Member_Belongs_To.Name, Member_Belongs_To.MemberID FROM Member_Belongs_To INNER JOIN Account ON Account.AccountID= '" . $AccountID . "' AND Member_Belongs_To.AccountID= '" . $AccountID . "'");

            printResult($result,$AccountID);

            OCICommit($db_conn);
        }


        function handleCountRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT Count(*) FROM Account");

            if (($row = oci_fetch_row($result)) != false) {
                echo "<br> The number of tuples in demoTable: " . $row[0] . "<br>";
            }
        }

        function handleDisplayRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT * FROM Account");
            echo "<h4>  &emsp;ID&emsp;Balance&emsp;DateOfCreation&emsp;NextRenewal&emsp;AccountType</h4>";
            while(($row = oci_fetch_row($result)) != false) {
                echo $row[0] . "&emsp; " . $row[1] . "&emsp; " . $row[2] . "&emsp; " . $row[3] . "&emsp; " . $row[4] . "<br>";
            }
        }

        function handleGroupRequest() {
            global $db_conn;
            $result = executePlainSQL("SELECT AccountType , MAX(Balance) FROM Account GROUP BY AccountType");

            echo "<h4>Balance&emsp;Account Type</h4>";
            while(($row = oci_fetch_row($result)) != false) {
                echo $row[0] . "&emsp;" . $row[1] . "<br>";
            }
            }

            function handlehavingRequest() {
                global $db_conn;
                $result = executePlainSQL("SELECT AccountType , MAX(Balance) FROM Account GROUP BY AccountType HAVING COUNT(*) > 1");

                echo "<h4>Balance&emsp;Account Type</h4>";
                while(($row = oci_fetch_row($result)) != false) {
                    echo $row[0] . "&emsp;" . $row[1] . "<br>";
                }
                }

                function handleUpdateRequest() {
                  global $db_conn;

                  $oldAccountID = $_POST['oldAccountID'];
                  // $newAccountID = $_POST['newAccountID'];
                  $newBalance = $_POST['newBalance'];
                  $newCreated = $_POST['newCreated'];
                  $newNextRenewal = $_POST['newNextRenewal'];
                  $newAccountType = $_POST['newAccountType'];
                  executePlainSQL("UPDATE Account SET BALANCE='".$newBalance."'WHERE AccountID='" .$oldAccountID. "'");
                  executePlainSQL("UPDATE Account SET CREATED='".$newCreated."'WHERE AccountID='" .$oldAccountID. "'");
                  executePlainSQL("UPDATE Account SET NEXTRENEWAL='".$newNextRenewal."'WHERE AccountID='" .$oldAccountID. "'");
                  executePlainSQL("UPDATE Account SET AccountType='".$newAccountType."'WHERE AccountID='" .$oldAccountID. "'");

                  OCICommit($db_conn);
                }

        // HANDLE ALL POST ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handlePOSTRequest() {
            if (connectToDB()) {
                if (array_key_exists('insertQueryRequest', $_POST)) {
                    handleInsertRequest();
                } else if (array_key_exists('deleteQueryRequest', $_POST)) {
                    handleDeleteRequest();
                } else if (array_key_exists('joinQueryRequest', $_POST)) {
                    handleJoinRequest();
                } else if (array_key_exists('updateQueryRequest', $_POST)) {
                    handleUpdateRequest();
                }

                disconnectFromDB();
            }
        }

        // HANDLE ALL GET ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handleGETRequest() {
            if (connectToDB()) {
                if (array_key_exists('countTuples', $_GET)) {
                    handleCountRequest();
                } else if (array_key_exists('displayTuples', $_GET)) {
                    handleDisplayRequest();
                } else if (array_key_exists('groupTuples', $_GET)) {
                    handleGroupRequest();
                } else if (array_key_exists('havingTuples', $_GET)) {
                    handlehavingRequest();
                }

                disconnectFromDB();
            }
        }

        if (isset($_POST['updateSubmit'])|| isset($_POST['insertSubmit']) || isset($_POST['deleteSubmit']) || isset($_POST['joinSubmit'])) {
                handlePOSTRequest();
            } else if (isset($_GET['groupRequest']) || isset($_GET['havingRequest']) || isset($_GET['countTupleRequest']) || isset($_GET['displayTupleRequest'])) {
                handleGETRequest();
            }
		?>
	</body>
</html>

<form action="project-name-please-change-this-to-our-project-name.php" method="post">

Which columns of the Account table would you like to see?<br />
<input type="checkbox" name="formAcct[]" value="AccountID" />Account ID<br />
<input type="checkbox" name="formAcct[]" value="Balance" />Account Balance<br />
<input type="checkbox" name="formAcct[]" value="Created" />Date Of Creation<br />
<input type="checkbox" name="formAcct[]" value="NextRenewal" />Date of Next Renewal<br />
<input type="checkbox" name="formAcct[]" value="AccountType" />Account Type<br />

<input type="submit" name="projectionRequest" value="Projection" />

</form>


function handleUpdateRequest() {
    global $db_conn;

    $proj = $_POST['formAcct'];
    $colToGet = "";

    if (empty($proj)) {
        echo("Please choose some columns to view.");
    }
    
    else {
        $N = count($proj);

        for($i=0; $i < ($N - 1); $i++)
            {
                  $colToGet = $colToGet . $proj[$i] . ", ";
            }

        $colToGet = $colToGet . $proj[$N - 1];
    }

    // this SHOULD WORK pls
    executePlainSQL("SELECT " . $colToGet . " FROM Account");
    OCICommit($db_conn);
}


<?php
 
class DbOperation
{
    //Database connection link
    private $con;
 
    //Class constructor
    function __construct()
    {
        //Getting the DbConnect.php file
        require_once dirname(__FILE__) . '/DbConnect.php';
 
        //Creating a DbConnect object to connect to the database
        $db = new DbConnect();
 
        //Initializing our connection link of this class
        //by calling the method connect of DbConnect class
        $this->con = $db->connect();
    }
 


 function getUser($login, $password){


    $realpaswrd = MD5($password);

 $stmt = $this->con->prepare("SELECT email, password FROM connexion_u where email=? and password = ?");
 $stmt->bind_param("ss",  $login, $realpaswrd);

 $stmt->execute();
 $stmt->bind_result($email1, $password1);
 $user  = array();
 
 
 while($stmt->fetch()){
 $user['email'] = $email1; 
 $user['password'] = $password1; 
 
 }
 
 return $user; 
}
}
 

 ?>
<!doctype html>
<html>
<body>
<title>Lista produktów</title>
<?php
$servername = "localhost";
$username = "root";
$password = "12345678";
$dbname = "mydb";

// Create connection
$mysqli = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
} 
//$query = "SELECT imię, nazwisko FROM dane_osobowe";
$results=mysqli_query($mysqli, "SELECT * FROM produkt");
echo "<center><h1><b>Lista produktów</b></h1></center>";
echo    "<center><table width='475' border='1' cellspacing='0' cellpadding='0'>
	<tr><td width='100'><b>Nazwa</b></td><td width='45'><b>Liczba</td></b><td width='150'><b>Dzial</b></td><td width='50'><b>Cena netto</b></td></tr>
	</table></center>";
while ($txt = mysqli_fetch_assoc($results)){
	echo    "<center><table width='475' border='1' cellspacing='0' cellpadding='0'>
	<tr><td width='100'>".$txt['nazwa']."</td><td width='45'>".$txt['liczba']."</td><td width='150'>".$txt['dzial']."</td><td width='50'>".$txt['cena_netto']."</td></tr>
	</table></center>";
}

?>
</body>
</html>
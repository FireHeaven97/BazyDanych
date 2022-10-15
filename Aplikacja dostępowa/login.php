<!doctype html>
<html>
  <head>
    <title>Logowanie z wykorzystaniem MySQL</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <form action="login.php" method="post">
      Login<input type="text" name="login" />
      Hasło<input type="password" name="haslo" />
      <input type="submit" name="logowanie"  value="Zaloguj" />
    </form>
    <br />
  
  <?php
    //jeżeli nie ma wysłanych danych, to zakończ skrypt
    if (!isset($_POST['login']) || !isset($_POST['haslo'])) exit;
    $login=trim($_POST['login']);
    $haslo=trim($_POST['haslo']);
    if (empty($login) || empty($haslo)) 
    {
      echo 'Brak loginu lub hasła!';
      exit;
    }
    $mysql=mysqli_connect('localhost','root','12345678');
    //połączenie z MySQL
    if (!$mysql)
    {
      echo 'Brak połączenia z MySQL!';
      exit;
    }
    $baza=mysqli_select_db($mysql,'mydb');
    //wybór potrzebnej bazy
    if (!$baza)
    {
      echo 'Brak połączenia z bazą uzytkowników!';
      exit;
    }
    //$haslo=sha1($haslo);//zaszyfrowanie hasła
    //znajdowanie pasującego wiersza
    $zapytanie="select * from uzytkownik where login='$login' and haslo='$haslo'";
    $wynik=mysqli_query($mysql,$zapytanie);
    if (!$wynik)
    {
      echo 'Błąd w wykonaniu zaytania!';
      exit;
    }
    $wiersz=mysqli_fetch_row($wynik);
    $ile_znaleziono=$wynik->num_rows;
    if ($ile_znaleziono>0) echo 'Jesteś zalogowany'; 
    else echo 'Podałeś błędny login lub hasło!';    
  ?>
</html>
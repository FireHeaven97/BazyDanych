<!doctype html>
<html>
  <head>
    <title>Wynik rejestracji</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <h1>Wynik rejestracji</h1>
    <?php
      $login = trim($_POST['login']);
      $haslo = trim($_POST['haslo']);

      if (!$login || !$haslo)
      {
        echo 'Brak wszystkich danych, wróć do poprzedniej strony i spóbuj ponownie!';
        exit;
      }
      if (!get_magic_quotes_gpc())
      {
        $login = addslashes($login);
        $haslo = addslashes($haslo);	
      }
      @ $db = new mysqli('localhost','root','12345678','mydb');
      
      if (mysqli_connect_errno())
      {
        echo 'Połączenie z bazą nie powiodło się. Spóbuj ponownie';
        exit;
      }
      $db->query('SET NAMES utf8');
      $db->query('SET CHARACTER_SET utf8_unicode_ci');
      $zapytanie = "insert into uzytkownik(login, haslo, administrator,dane_osobowe_id_dane_osobowe)  values ('".$login."', '".$haslo."', '0', '1')";
      $wynik = $db->query($zapytanie);
      if ($wynik) echo 'Liczba rekordów dodanych do bazy:'.$db->affected_rows;
    ?> 
  </body>
</html>
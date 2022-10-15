<!doctype html>
<html>
  <head>
    <title>Wyszukiwanie produktów</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <h1>Wyszukiwanie produktów</h1>
    <form action="results.php" method="post">
      Wyszukaj według:
      <select name="metoda">
       <option value="Nazwa" />Nazwa
       <option value="Liczba" />Liczba
       <option value="Dzial" />Dzial
	   <option value="Cena netto" />Cena netto
      </select>
      <br /><br />
      Szukane wyrażenie:
      <input type="text" name="wyrazenie" />
      <input type="submit" name="wyszukaj" />
    </form>
  </body>
</html>
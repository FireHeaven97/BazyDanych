create user 'klient'
	identified by '1234';
grant SELECT on mydb.produkt to 'klient';
grant SELECT on mydb.vat to 'klient';
grant SELECT on mydb.faktura to 'klient';
grant SELECT on mydb.kategoria to 'klient';
grant SELECT, CREATE, UPDATE, DELETE on mydb.dane_osobowe to 'klient';
grant SELECT, CREATE, UPDATE, DELETE on mydb.adres to 'klient';
grant SELECT, UPDATE on mydb.uzytkownik to 'klient';
grant SELECT, CREATE, UPDATE on mydb.transakcja to 'klient';
grant SELECT, UPDATE, DELETE on mydb.koszyk to 'klient';
grant SELECT, CREATE, UPDATE on mydb.płatność to 'klient';
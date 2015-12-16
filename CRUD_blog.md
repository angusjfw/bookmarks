CREATE

`INSERT INTO "students" (NAME) VALUES ( 'Garry Bernhardt');`

READ

`SELECT * FROM students;`

```
 id |  name
----+--------
  1 | Garry Bernhardt
(1 row)
```

UPDATE

`UPDATE "students" SET NAME = 'Kal-el of Krypton' WHERE ID = 1;`

(READ again)

```
 id |  name
----+--------
  1 | Kal-el Son of Krypton
(1 row)
```

DELETE

`DELETE FROM "students" WHERE ID = 1;`

(READ again)

```
id | name
----+------
(0 rows)
```
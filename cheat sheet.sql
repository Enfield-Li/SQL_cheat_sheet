official: https://www.postgresql.org/docs/14/index.html
cheat sheet: https://www.sqltutorial.org/sql-cheat-sheet/

DROP SCHEMA public CASCADE;

Pg: (mockaroo) 
	\l ie. List all db
	\c ie. Connect db 
	\d ie. List table 
    \d t ie. list all c
    \! cls clear screen
	Select * from “user” where username = '';
	Create database dbName;
	Drop database dbName;
    drop table t;

create table car (
	id serial not null,
	make VARCHAR(100) not null,
	model VARCHAR(50) not null,
	price numeric(19,2) not null
    PRIMARY KEY(id),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

insert into car values (1, 'Lexus', 'ES', '74104.46');
insert into car (id, make, model, price) values (1, 'Lexus', 'ES', '74104.46');

update data: (3:01:36) 
update t set c = 'something' where id = 1;

delete data: 
(2:54:45) delete from t where c1 = '' and c2 = ''; 

change COLUMN name:
ALTER TABLE t ADD COLUMN new_column_name data_type constraint;

insert file into db: 
\i /Users/admin/Desktop/...sql;

select * from t;
select c, c2 from t;

as:
select v.c1 as name1, v.c2 as "junk.name2" from t v;
select v.c1 as name1, v.c2 as "junk.name2" from t v;

order by: (sort) 
select c from t order by c1, c2, c3 asc/desc;

distinct:
select distinct c from t order by c asc/desc;

where: 
select c from t where c = '';

and/or:
select c from t where c = '' and (c = '' or c = '');

operators:
select 1 >= 2; return F
select 1 >= 1; return T

limit, offset, fetch:
select c from t limit num;
select c from t offset num limit num; // start from offset to limit
sql standard using fetch:
select c from t offset num fetch first num row only;

in: 
select c from t where c = '' or c = '' or c = '';
select c from t where c in ('', '', '');
select c from t where c in ('', '', '') order by c asc/desc;

between: 
select c from t where c between '' and '';

like/ilike: (ilike: case insensitive)
select c from t where c like '%_'; // % means any character eg: %@gmail.% match @gmail. _ means match single character

aggregate functions: 
https://www.postgresql.org/docs/current/functions-aggregate.html

group by: (1:43:10)
select c1, count(*) from t group by c1 order by c1;

group by having:
select c1, count(*) from t group by c1 having count(*) > num order by c1 asc/desc;

min/max/avg: (1:55:40)
select max/min/avg(c) from t;
select c1, round(max/min/avg(c2)) from t group by c1;

select c1, c2, round(max/min/avg(c3)) from t group by c1, c2;
select c1, round(max/min/avg(c2)) from t group by c1 order by max/min/avg(c2);

Sum: (1:59:48) 
select sum(c) from t;
select c1, sum(c2) from t group by c1;
select c1, sum(c2) from t group by c1 order by sum(c2) asc/desc;

Arithmetic Operators: (2:01:55)
select 10 + 2; return 12
select c1, c2, round(c3 * .10, 2) from t;
round(original, num1) num1 = decimal

Alias: (2:09:43) 
select c1, c2, round(c3 * .10, 2) as someName from t;

Coalesce: (2:12:32) 
select coalesce(null, null, num) as someName; return first non null value
select coalesce(c, 'not provided') as someName; when returning the null value === 'not provided'

NULLIF: (2:16:15) 
select nullif(num1, num1); if num1 === num1 return null

Timestamps And Dates Course: (2:20:21) 
select now();
select now()::date;
select now()::time;
select ( now() + interval '10 months')::date/time;

example: 
    create table time_measure (
        time1 Timestamp without time zone not null,
        time2 date not null
    )
    insert into time_measure(time1, time2) values (now(), '2020-03-03');

Extracting Fields From Timestamp: (2:25:58)
select extract(year/day/month/dow from now());

Age Function: (2:27:28) 
select c1, c2, date_of_birth, AGE(now(), date_of_birth) as age from t;

Primary Keys: (2:29:24) 
drop constraint and add constraint
alter table t drop constraint c;
alter table t add primary key ( c ); 
alter table t RENAME COLUMN c TO new_c;

Unique Constraints: (2:40:55) 
alter table person add constraint new_c unique(c1, c2);
alter table t add unique (c);
alter table t drop constraint c;

Check Constraints: (2:49:15) 
alter table t add constraint constraint_name check (c1 = '1' or c1 = '2');
alter table t add constraint constraint_name check (c1 > num);

On Conflict Do Nothing: (3:05:55) 
when insert + on Conflict (c/id/email) do nothing;

Upsert: (3:11:09) 
override exsiting data otherwise insert a new row
when insert + on Conflict (c) do update set c1 = excluded.c1;
when insert + on Conflict (id) do update set email = excluded.email;


Updating Foreign Keys Columns: (3:25:04)
create table person (
    id serial not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    gender varchar(7) not null,
    email varchar(100),
    date_of_birth date not null,
    country_of_birth varchar(50) not null,
    car_id bigint references car(id),
    unique(car_id)
);
create table car(
    id serial not null primary key,
    make varchar(100) not null,
    model varchar(100) not null,
    price numeric(19,2) not null
);
insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('first', 'dude', 'male', null, '1990-01-01', 'China');
insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('first', 'gal', 'female', null, '1990-01-02', 'China');
insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth) values ('first', 'noCar', 'female', null, '1990-01-03', 'China');
insert into car (make, model, price) values ('some brand', 'modelS', '99999');
insert into car (make, model, price) values ('some brand2', 'modelY', '99998');

update person set car_id = 2 where id = 1;
meaning: set person_id_1.car_id = 2;
res same as: insert into person (first_name, last_name, gender, email, date_of_birth, country_of_birth, car_id) values ('first', 'dude', 'male', null, '1990-01-01', 'China', 2);

Joins: (3:29:30)
select t1.c, t2.c from t1 join t2 using (c) where...;
select t1.c, t2.c from t1 join t2 on t2.c = t1.c where...;

Exporting Query Results to CSV: (3:47:27) 
\copy() to '/route/name.csv' delimiter '.' csv header;

Serial & Sequences: (3:50:42) 
\d c

Extensions: (3:57:18) 
select * from pg_available_extensions;

Understanding UUID Data Type: (3:59:39) 
create extension if not exists "uuid-ossp";
select uuid_generate_v4();

UUID As Primary Keys: (4:05:54) 

https://www.youtube.com/watch?v=HXV3zeQKqGY&t=1467s
union: (2:53:53) 
select t1.c1, t1.c3 from t1 union select t2.c2, t2.c3  from t2 union...;
select t1.c1, t1.c3  from t1 union select t2.c2, t2.c3  from t2;


Nested Queries:(3:11:49)
vs
join:
select t1.c1 from t1 where t1.c2 in (select t2.c2 from t2 where c3 > num);
select employee.first_name from employee where employee.emp_id in (select works_with.emp_id from works_with where works_with.total_sales > 20000);
select employee.emp_id, employee.first_name, works_with.total_sales from employee join works_with using (emp_id) where works_with.total_sales > 20000;
select employee.emp_id, employee.first_name, works_with.total_sales from employee join works_with on works_with.emp_id = employee.emp_id where works_with.total_sales > 20000;

On Delete: (3:21:52) 
Triggers: (3:30:05) 

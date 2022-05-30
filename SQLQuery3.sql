﻿create database [Library1]
use  [Library1]
create table Books(

Id int primary key identity,
[Name] nvarchar(100) check(len([Name])>=2) not null,
[PageCount] int check([PageCount]>=10)
)

create table Authors(
Id int primary key identity,
[Name] nvarchar(30) not null,
Surname nvarchar(30) not null

)

alter table Books
add Author_Id  int foreign key  references Authors(Id)


create table AuthorBooks(
Id int primary key identity,
Authors_Id int foreign key references Authors(Id)
)


insert into Books
values('Руководсво по эксплуатации W211', 50),
('chernobyl',80),
('The Rise of Evil',200),
('Harry Potter',210),
(N'Məlikməmmədin nağılları',20)

insert into Authors
values('Daimler','Benz'),
('Johan', 'Renck'),
('John' ,'Pielmeier'),
('Joanne' ,'Rowling'),
(N'Məmməd','Məlikli')

insert into Books
values('Lord of Rings',150)

create view vw_BookAuthor

as select * from(

select Books.Id,Books.[Name],Books.[PageCount], Authors.[Name] +' '+Authors.Surname as FullName
from Books
join Authors
on Books.Author_Id=Authors.Id
)
as AuthorAndBooks

select * from vw_BookAuthor

create procedure usp_FindBooks
@Name nvarchar(30)

as 
select Books.Id,Books.[Name],Books.[PageCount], a.[Name]+' '+a.Surname as AuthorFullName from Books
join Authors as a
on Books.Author_Id=a.Id
where a.[Name] =@Name
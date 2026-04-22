create database userManager;
use userManager;

create table users(
	userId int primary key auto_increment,
    fullName varchar(255) not null,
    email varchar(255) unique,
    phoneNumber int 
);

alter table users
modify phoneNumber varchar(15);
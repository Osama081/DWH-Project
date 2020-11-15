use project;

create table employee_type(
				id int not null identity primary key,
				employee_type_name varchar(15)
);

create table employee (
			employee_cnic varchar(25) not null primary key,
			f_name varchar(10),
			l_name varchar(10),
			job_title varchar(15),
			birth_date date,
			hire_date date,
			gendre varchar(6),
			employee_type_name int foreign key references employee_type(id)
);

alter table employee alter column f_name varchar(25);
alter table employee alter column l_name varchar(25);



create table  Hr_Manager (
				id int not null identity primary key,
				employee_cnic int,
				years_of_experience float(6),
				employee_id varchar(25) foreign key references employee(employee_cnic)
				);

create table region(
			region_id int not null identity primary key,
			region_description varchar(50) 
);

create table territory
(	
			territory_id int not null identity primary key,
			emp_id varchar(25) foreign key references employee (employee_cnic),
			territory_description varchar(50),
			region_id int foreign key references region(region_id)
 );

  create table skills(
			skill_id int not null identity primary key,
			skill_description varchar(20),
			employee_id varchar(25) foreign key references employee(employee_cnic)
			);
create table client(
			client_cnic varchar(25) primary key,
			f_name varchar(15) not null,
			l_name varchar(15) not null,
			email varchar(35) not null,
			city varchar(30),
			country varchar(30),
			phone_number varchar,
			zip_code int
		);
create table performance_reviews(
			performance_review_id int  not null identity primary key,
			employee_id varchar(25) foreign key references employee(employee_cnic),
			date_of_review date,
			client_id  varchar(25) foreign key references client(client_cnic),
			reviewed_by_manager varchar(25) foreign key references employee(employee_cnic),
			comments_by_reviewer varchar(40),
			comments_by_manager varchar(40)
);
create table deduction_type(
			deduction_type_id int not null identity primary key,
			deduction_type varchar(50),
			deduction_description  varchar(200)
	);
create table deduction(
				deduction_id int not null primary key identity,
				employee_id varchar(25) foreign key references employee(employee_cnic),
				deduction_type_id int foreign key references deduction_type(deduction_type_id),
				deduction_effective_date date,
				deduction_end_date date,
				deduction_amount float,
				last_deduction_date date,
				approved_by_manager int foreign key references Hr_Manager(id)
		);
create table salary(
				salary_id int not null identity primary key,
				employee_id varchar(25) foreign key references employee(employee_cnic),
				basic_salary float not null,
				effective_date date,
				end_date date,
				approved_by_manager int foreign key references Hr_Manager(id)
		);
create table allowance_type(
				allowance_type_id int not null identity primary key,
				allowance_type varchar(30),
				allowance_desciption varchar(200)
		);
create table allowance(
			allowance_id int not null identity primary key,
			employee_id varchar(25) foreign key references employee(employee_cnic),
			allowance_type_id int foreign key references allowance_type(allowance_type_id)
		    ,effective_date date,
			end_date date,
			allowance_amount float,
			approved_by_manager int foreign key references Hr_Manager(id)
		);
create table employee_job_assignment(
					
					job_id int not null identity primary key,
					employee_id varchar(25) foreign key references employee(employee_cnic),
					date_started date,
					date_finished date,
					assignment_details varchar(300),
					job_by_client varchar(25) foreign key references client(client_cnic)			
		);
create table bill_type(
			bill_type_id int not null primary key identity,
			bill_type_name varchar(20),
		);

create table bill_payments(
				bill_id int not null primary key identity,
				bill_type_id int foreign key references bill_type(bill_type_id)	,	
				bill_amount float,
				bill_paid_by int foreign key references hr_manager(id)
		);
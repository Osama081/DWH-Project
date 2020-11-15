use project;
create table  Hr_Manager (
				id int not null identity primary key,
				employee_cnic int,
				years_of_experience float(6)
				
				);
				alter table hr_manager add  employee_id int not null;
				alter table hr_manager add foreign key (employee_id) references employee(employee_cnic);




create table employee_type(
				id int not null identity primary key,
				employee_type_name varchar(15)
);

			insert into employee_type (employee_type_name) values ('full_time');
			insert into employee_type (employee_type_name) values ('part_time');
			insert into employee_type (employee_type_name) values ('casual');
			insert into employee_type (employee_type_name) values ('fixed_term');
			insert into employee_type (employee_type_name) values ('shift_worker');
			insert into employee_type (employee_type_name) values ('daily_hire');
			insert into employee_type (employee_type_name) values ('weekly_hire');
			select * from employee_type;


create table employee (
			employee_cnic int not null primary key,
			f_name varchar(10),
			l_name varchar(10),
			job_title varchar(15),
			birth_date date,
			hire_date date,
			gendre varchar(6),
			employee_type_name int foreign key references employee_type(id)
)
create table region(
			region_id int not null identity primary key,
			region_description varchar(50) 
);
create table territory(	
			territory_id int not null identity primary key,
			emp_id int foreign key references employee (employee_cnic),
			territory_description varchar(50),
			region_id int foreign key references region(region_id)
 );
 create table skills(
			skill_id int not null identity primary key,
			skill_description varchar(20),
			employee_id int foreign key references employee(employee_cnic)
			);

create table performance_reviews(
			performance_review_id int  not null identity primary key,
			employee_id int foreign key references employee(employee_cnic),
			date_of_review date,
			client_id  int foreign key references client(client_cnic),
			reviewed_by_manager int foreign key references employee(employee_cnic),
			comments_by_reviewer varchar(40),
			comments_by_manager varchar(40)

);

create table client(
			client_cnic int primary key,
			f_name varchar(15) not null,
			l_name varchar(15) not null,
			email varchar(35) not null,
			city varchar(30),
			country varchar(30),
			phone_number int,
			zip_code int
		);




select * from employee_type left join employee on  employee_type.id  =  employee.employee_type_name;





create table deduction_type(
			deduction_type_id int not null identity primary key,
			deduction_type varchar(50),
			deduction_description  varchar(200)
	);
	drop table deduction_type;

		insert into deduction_type (deduction_type,deduction_description) values ('Health Insurance Premium','Tax deduction is available under Section 80D, for health insurance paid for spouse, your children and self. The deduction viable is Rs. 30,000 for senior citizens and Rs. 25,000 for youngsters.');
		insert into deduction_type (deduction_type,deduction_description) values ('Charity Gifts','');
		insert into deduction_type (deduction_type,deduction_description) values ('Paying the baby Sitters','');
		insert into deduction_type (deduction_type,deduction_description) values ('Life Time Leanring','');
		insert into deduction_type (deduction_type,deduction_description) values ('Infrastructure Bonds','');
		insert into deduction_type (deduction_type,deduction_description) values ('Bank Fixed Deposits','Under the Section 80C, if you invest in fixed deposits of bank account for at least 5 years, then you are eligible for tax deduction. But, the interest earned on FD is taxable. Total deduction in this section is up to Rs 1.5 Lakhs.');
		insert into deduction_type (deduction_type,deduction_description) values ('Life Insurance Premium','When you pay premium for life insurance policy for spouse, child, or self, then amount received during maturity of the same policy is non-taxable (under section 80C). The deductions may be subject to terms and conditions as per the policy. Total deduction in this section is up to Rs 1.5 Lakhs.');
		insert into deduction_type (deduction_type,deduction_description) values ('Retirement Saving Plans','Investing in NPS (National Pension Scheme), LIC or other insurance company provided retirement plans make you eligible for getting tax deductions up to Rs. 1.5 lakh.');
		insert into deduction_type (deduction_type,deduction_description) values ('Home Loan EMIs','EMIs or Equated monthly instalments paid to clear off principal amount on home loan gets you tax deductions under the section 80C. Exemption is up to Rs 2 lakhs on interest payable.');


		select * from deduction;



		create table deduction(
		
				deduction_id int not null primary key identity,
				employee_id int foreign key references employee(employee_cnic),
				deduction_type_id int foreign key references deduction_type(deduction_type_id),
				deduction_effective_date date,
				deduction_end_date date,
				deduction_amount float,
				last_deduction_date date
		);
		
				alter table deduction add approved_by_manager int;
				alter table deduction add foreign key (approved_by_manager) references hr_manager(id);

		drop table deduction;
	
		create table salary(
				salary_id int not null identity primary key,
				employee_id int foreign key references employee(employee_cnic),
				basic_salary float not null,
				effective_date date,
				end_date date
		);

		alter table salary add approved_by_manager int;
		alter table salary add foreign key (approved_by_manager) references hr_manager(id);

		create table allowance_type(
				allowance_type_id int not null identity primary key,
				allowance_type varchar(30),
				allowance_desciption varchar(200)
		);

		create table allowance(
		
			allowance_id int not null identity primary key,
			employee_id int foreign key references employee(employee_cnic),
			allowance_type_id int foreign key references allowance_type(allowance_type_id)
		    ,effective_date date,
				end_date date,
				allowance_amount float

		);

		alter table allowance add approved_by_manager int;
		alter table allowance add foreign key (approved_by_manager) references hr_manager(id);

		select * from client;
		create table employee_job_assignment(
					
					job_id int not null identity primary key,
					employee_id int foreign key references employee(employee_cnic),
					date_started date,
					date_finished date,
					assignment_details varchar(300),
					job_by_client int foreign key references client(client_cnic)
					
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
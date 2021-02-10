BEGIN TRANSACTION;

drop table if exists departments;
drop table if exists dept_locations;
drop table if exists employees;
drop table if exists projects;
drop table if exists works_on;
drop table if exists dependents;


CREATE TABLE employees (
      fname text  not null,
      minit text NOT NULL, 
      lname text NOT NULL,
      ssn integer primary key not null,
      bdate date not null, 
      address text not null, 
      sex text not null, 
      salary real not null,
      superssn text,
      dno integer
      );

      insert into employees values('John', 'B', 'Smith', '123456789', '9-Jan-55', '731 Fondern', 'M', 30000, '333445555' , 5 );
      insert into employees values('Franklin', 'T', 'Wong', '333445555', '8-Dec-45', '638 Voss', 'M', 40000, '888665555' , 5 );
      insert into employees values('Alicia', 'J', 'Zeleaya', '999887777', '19-Jul-58', '3321 Castle', 'F', 25000, '987987987' , 4);
      insert into employees values('Jennifer', 'S', 'Wallace', '987654321', '20-Jun-31', '291 Berry', 'F', 43000, '888665555' , 4 );
      insert into employees values('Ramesh', 'K', 'Narayan', '666884444', '15-Sep-52', '975 Fire Oak', 'M', 38000, '333445555' , 5 );
      insert into employees values('Joyce', 'A', 'English', '453453453', '31-Jul-62', '5631 Rice', 'F', 25000, '333445555' , 5 );
      insert into employees values('Ahmad', 'V', 'Jabber', '987987987', '29-Mar-59', '980 Dallas', 'M', 25000, '987654321' , 4 );
      insert into employees (
      fname ,
      minit, 
      lname,
      ssn,
      bdate, 
      address, 
      sex, 
      salary,
      dno 
      )  values('James', 'E', 'Borg', '888665555', '10-Nov-37', '450 Stone', 'M', 55000 , 1 );


      CREATE TABLE departments(
      dname text  not null,
      dnumber integer primary key not null, 
      mgrssn text NOT NULL,
      mgrstartdate text date not NULL
      );

      insert into departments values('Research', 5, '333445555', '22-May-78' );
      insert into departments values('Administration', 4, '987654321', '1-JAn-85' );
      insert into departments values('HeadQuarters', 1, '888665555', '19-Jun-71' );

      CREATE TABLE dept_locations(
      dnumber integer not null,
      dlocation text not null,
      primary key (dnumber, dlocation )
      );

      insert into dept_locations values(1, 'Houstan' );
      insert into dept_locations values(4, 'Stafford' );
      insert into dept_locations values(5, 'Bellaire' );
      insert into dept_locations values(5, 'Sugarland' );
      insert into dept_locations values(5, 'Houstan' );

      CREATE TABLE projects(
      pname text  not null,
      pnumber text primary key not null, 
      plocation text NOT NULL,
      dnum text NOT NULL
      );

      insert into projects values( 'ProductX', 1, 'Bellaire', 5);
      insert into projects values( 'ProductY', 2, 'Sugarland', 5);
      insert into projects values( 'ProductZ', 3, 'BelHoustanlaire', 5);
      insert into projects values( 'Computerization', 10, 'Staffort', 4);
      insert into projects values( 'Reoganization', 20, 'Houstan', 1);
      insert into projects values( 'NewBenefits', 30, 'Stafford', 4);

      CREATE TABLE works_on(
            essn text  not null,
      pno integer not null,
      hours real,
      primary key ( essn,  pno)
      );

      insert into works_on values( '123456789',1, 32.50 );
      insert into works_on values( '123456789',2, 7.50 );
      insert into works_on values( '666884444',3, 40.00 );
      insert into works_on values( '453453453',1, 20.00 );
      insert into works_on values( '453453453',2, 20.00 );
      insert into works_on values( '333445555',2, 10.00 );
      insert into works_on values( '333445555',3, 10.00 );
      insert into works_on values( '333445555',10, 10.00 );
      insert into works_on values( '333445555',20, 10.00 );
      insert into works_on values( '999887777',30, 30.00 );
      insert into works_on values( '999887777',10, 10.00 );
      insert into works_on values( '987987987',10, 35.00 );
      insert into works_on values( '987987987',30, 5.00 );
      insert into works_on values( '987654321',30, 20.00 );
      insert into works_on values( '987654321',20, 15.00 );
      insert into works_on (essn, pno) values( '888665555',20);

      CREATE TABLE dependents(
      essn text not null,
      d_name integer not null,
      sex text NOT NULL,
      bdate date not null,
      relationship not null,
      primary key (essn, d_name)
      );

      insert into dependents values( '33344555', 'Alice', 'F', '5-Apr-76', 'DAUGHTER' );
      insert into dependents values( '33344555', 'Theaodore', 'F', '25-Oct-73', 'SON' );
      insert into dependents values( '33344555', 'Joy', 'F', '3-May-48', 'SPOUSE' );
      insert into dependents values( '987654321', 'Abner', 'M', '29-Feb-32', 'SPOUSE' );
      insert into dependents values( '123456789', 'Michael', 'M', '1-Jan-78', 'SON' );
      insert into dependents values( '123456789', 'Alice', 'F', '31-Jan-78', 'DAUGHTER' );
      insert into dependents values( '123456789', 'Elizabeth', 'F', '5-May-57', 'SPOUSE' );


      COMMIT;
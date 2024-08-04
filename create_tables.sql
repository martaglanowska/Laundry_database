--create tables

CREATE TABLE fabrics (
fabric_id NUMBER,	
fabric_type VARCHAR2(40) CONSTRAINT fabr_type_nn NOT NULL,
color_category VARCHAR2(9) CONSTRAINT fsbr_col_cat_nn NOT NULL,
spin_speed NUMBER(4),
CONSTRAINT fabrics_pk PRIMARY KEY(fabric_id),
CONSTRAINT fabr_col_cat_ch CHECK(color_category IN ('white','light','dark')));

CREATE TABLE programs (
program_no NUMBER,
fabric_id NUMBER,
washing_time NUMBER(3) CONSTRAINT prog_wash_time_nn NOT NULL,
temperature NUMBER CONSTRAINT prog_temp_nn NOT NULL,
additional_rinsing CHAR(1) CONSTRAINT prog_add_rins_nn NOT NULL,
CONSTRAINT programs_pk PRIMARY KEY(program_no),
CONSTRAINT prog_fabr_id_fk FOREIGN KEY (fabric_id) REFERENCES fabrics(fabric_id),
CONSTRAINT prog_wash_time_ch CHECK(washing_time > 0),
CONSTRAINT prog_temp_ch CHECK(temperature > 0 AND temperature < 100),
CONSTRAINT prog_add_rins_ch CHECK(additional_rinsing IN ('y','n')));

CREATE TABLE machines (
machine_no NUMBER,
manufacturer VARCHAR2(50) CONSTRAINT mach_manu_nn NOT NULL,
energy_class VARCHAR2(4),
annual_power_cons NUMBER(3),
noise_level NUMBER(2),
purchase_date DATE,
CONSTRAINT machines_pk PRIMARY KEY(machine_no),
CONSTRAINT mach_ener_cl_ch CHECK(energy_class IN ('A','B','C','D','E','F')),
CONSTRAINT mach_ann_pow_cons_ch CHECK(annual_power_cons > 0),
CONSTRAINT mach_noise_lev_ch CHECK(noise_level > 0));

CREATE TABLE services (
service_id NUMBER,
program_no NUMBER,
machine_no NUMBER,
max_load_capacity NUMBER(3,1) CONSTRAINT serv_max_load_nn NOT NULL,
price NUMBER(5,2) CONSTRAINT serv_price_nn NOT NULL,
CONSTRAINT services_pk PRIMARY KEY(service_id),
CONSTRAINT serv_prog_no_fk FOREIGN KEY (program_no) REFERENCES programs(program_no),
CONSTRAINT serv_machine_no_fk FOREIGN KEY (machine_no) REFERENCES machines(machine_no),
CONSTRAINT serv_price_ch CHECK(price >= 0));

CREATE TABLE customers (
customer_id CHAR(6),
first_name VARCHAR2(40) CONSTRAINT cust_f_name_nn NOT NULL,
surname VARCHAR2(50) CONSTRAINT cust_surname_nn NOT NULL,
pesel CHAR(11) CONSTRAINT cust_pesel_nn NOT NULL,
birth_date DATE CONSTRAINT cust_birth_date_nn NOT NULL,
sex CHAR(1) CONSTRAINT cust_sex_nn NOT NULL,
phone_no VARCHAR2(15),
bank_account_no CHAR(26) CONSTRAINT cust_bank_acc_no_nn NOT NULL,
CONSTRAINT customers_pk PRIMARY KEY(customer_id),
CONSTRAINT cust_name_surname_ch CHECK(first_name = INITCAP(first_name) AND surname = INITCAP(surname)),
CONSTRAINT cust_pesel_u UNIQUE(pesel),
CONSTRAINT cust_pesel_ch CHECK(SUBSTR(pesel,1,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,2,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,3,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,4,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,5,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,6,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,7,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,8,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,9,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,10,1) BETWEEN '0' AND '9'
			AND SUBSTR(pesel,11,1) BETWEEN '0' AND '9'),
CONSTRAINT cust_sex_ch CHECK(sex IN ('f','m')));

CREATE TABLE visits (
visit_id NUMBER,
customer_id CHAR(6),
date_time TIMESTAMP CONSTRAINT vis_date_time_nn NOT NULL,
visit_rating VARCHAR2(9),
whether_invoice CHAR(1) CONSTRAINT vis_whet_inv_nn NOT NULL,
CONSTRAINT visits_pk PRIMARY KEY(visit_id),
CONSTRAINT vis_cust_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT vis_rating_ch CHECK(visit_rating IN ('very good','good','average','bad','very bad')),
CONSTRAINT vis_whet_inv_ch CHECK(whether_invoice IN ('y','n')));

CREATE TABLE washes (
wash_id NUMBER,
visit_id NUMBER,
service_id NUMBER,
additional_powder CHAR(1) CONSTRAINT wash_add_powd_nn NOT NULL,
free_drying CHAR(1) CONSTRAINT wash_free_dry_nn NOT NULL,
CONSTRAINT washes_pk PRIMARY KEY(wash_id),
CONSTRAINT wash_visit_id_fk FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
CONSTRAINT wash_serv_id_fk FOREIGN KEY (service_id) REFERENCES services(service_id),
CONSTRAINT wash_add_powd_ch CHECK(additional_powder IN ('y','n')),
CONSTRAINT wash_free_dry_ch CHECK(free_drying IN ('y','n')));

CREATE TABLE complaints (
complaint_id NUMBER,
wash_id NUMBER,
submission_date DATE CONSTRAINT comp_subm_date_nn NOT NULL,
submission_method VARCHAR2(8),
complaint_category VARCHAR2(11),
complaint_description VARCHAR2(150),
whether_considered CHAR(1) CONSTRAINT comp_whet_cons_nn NOT NULL,
CONSTRAINT complaints_pk PRIMARY KEY(complaint_id),
CONSTRAINT comp_wash_id_fk FOREIGN KEY (wash_id) REFERENCES washes(wash_id),
CONSTRAINT comp_sub_meth_ch CHECK(submission_method IN ('directly','email','website')),
CONSTRAINT comp_comp_cat_ch CHECK(complaint_category IN ('equipment','price','cleanliness','service','additions','failure','other')),
CONSTRAINT comp_whet_cons_ch CHECK(whether_considered IN ('y','n')));


--populate Fabrics table

CREATE SEQUENCE fabrics_seq
INCREMENT BY 1
START WITH 1;

INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'cotton', 'white', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'cotton', 'light', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'cotton', 'dark', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'delicates', 'white', 600);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'delicates', 'light', 600);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'delicates', 'dark', 600);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'synthetics', 'white', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'synthetics', 'light', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'synthetics', 'dark', 800);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'duvet', 'white', 1000);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'duvet', 'light', 1000);
INSERT INTO fabrics VALUES(fabrics_seq.nextval, 'duvet', 'dark', 1000);

--populate Machines table

INSERT INTO machines VALUES(1, 'Samsung', 'A', 98, 72, to_date('14/06/2019', 'dd/mm/yyyy'));
INSERT INTO machines VALUES(2, 'Electrolux', 'B', 100, 74, to_date('25/01/2020', 'dd/mm/yyyy'));
INSERT INTO machines VALUES(3, 'Indesit', 'F', 142, 76, to_date('05/11/2018', 'dd/mm/yyyy'));
INSERT INTO machines VALUES(4, 'Whirlpool', 'B', 104, 78, to_date('05/11/2018', 'dd/mm/yyyy'));
INSERT INTO machines VALUES(5, 'Samsung', 'C', 126, 72, to_date('11/09/2019', 'dd/mm/yyyy'));
INSERT INTO machines VALUES(6, 'Bosch', 'A', 98, 71, to_date('09/02/2020', 'dd/mm/yyyy'));

--populate Programs and Services tables

CREATE SEQUENCE programs_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE services_seq
INCREMENT BY 1
START WITH 1;

--machine 1
INSERT INTO programs VALUES(programs_seq.nextval, 1, 120, 60, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 3, 110, 40, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 5, 90, 30, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 8, 120, 60, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 8, 120, 30, 'n');

INSERT INTO services VALUES(services_seq.nextval, 1, 1, 7, 20); --program, maszyna, max_load, price
INSERT INTO services VALUES(services_seq.nextval, 2, 1, 7.5, 15.5);
INSERT INTO services VALUES(services_seq.nextval, 3, 1, 5, 12.7);
INSERT INTO services VALUES(services_seq.nextval, 4, 1, 4, 18.95);
INSERT INTO services VALUES(services_seq.nextval, 5, 1, 4, 18);

--machine 2
INSERT INTO programs VALUES(programs_seq.nextval, 10, 130, 90, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 11, 140, 90, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 12, 130, 60, 'n');

INSERT INTO services VALUES(services_seq.nextval, 6, 2, 11, 32.5);
INSERT INTO services VALUES(services_seq.nextval, 7, 2, 11, 32.5);
INSERT INTO services VALUES(services_seq.nextval, 8, 2, 11, 28.25);

--machine 3
INSERT INTO programs VALUES(programs_seq.nextval, 1, 90, 50, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 2, 90, 50, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 3, 90, 30, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 8, 75, 60, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 9, 75, 60, 'y');

INSERT INTO services VALUES(services_seq.nextval, 9, 3, 9, 23);
INSERT INTO services VALUES(services_seq.nextval, 10, 3, 9, 21.5);
INSERT INTO services VALUES(services_seq.nextval, 11, 3, 9, 23);
INSERT INTO services VALUES(services_seq.nextval, 12, 3, 8.5, 19);
INSERT INTO services VALUES(services_seq.nextval, 13, 3, 8.5, 19.95);

--machine 4
INSERT INTO programs VALUES(programs_seq.nextval, 4, 110, 40, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 5, 110, 40, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 6, 110, 30, 'n');
INSERT INTO programs VALUES(programs_seq.nextval, 7, 45, 50, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 8, 45, 50, 'y');
INSERT INTO programs VALUES(programs_seq.nextval, 9, 45, 50, 'y');

INSERT INTO services VALUES(services_seq.nextval, 14, 4, 6, 14);
INSERT INTO services VALUES(services_seq.nextval, 15, 4, 6, 14.9);
INSERT INTO services VALUES(services_seq.nextval, 16, 4, 6, 15.8);
INSERT INTO services VALUES(services_seq.nextval, 17, 4, 6.5, 13);
INSERT INTO services VALUES(services_seq.nextval, 18, 4, 6.5, 13.7);
INSERT INTO services VALUES(services_seq.nextval, 19, 4, 6.5, 14.5);

--machine 5
INSERT INTO services VALUES(services_seq.nextval, 1, 5, 11.5, 28);
INSERT INTO services VALUES(services_seq.nextval, 3, 5, 11.5, 29);
INSERT INTO services VALUES(services_seq.nextval, 6, 5, 10, 34);
INSERT INTO services VALUES(services_seq.nextval, 8, 5, 10, 36);

--machine 6
INSERT INTO services VALUES(services_seq.nextval, 12, 6, 5.5, 16.9);
INSERT INTO services VALUES(services_seq.nextval, 13, 6, 5.5, 16.9);
INSERT INTO services VALUES(services_seq.nextval, 17, 6, 4, 13);
INSERT INTO services VALUES(services_seq.nextval, 18, 6, 4, 13);
INSERT INTO services VALUES(services_seq.nextval, 19, 6, 4, 13.5);

--populate Customers table

CREATE SEQUENCE customers_seq
INCREMENT BY 1
START WITH 111111;

INSERT INTO customers VALUES(customers_seq.nextval, 'Jan', 'Kowalski', '99031253942', to_date('12/03/1999', 'dd/mm/yyyy'), 'm', '342489973', '24168748775118088207973823');
INSERT INTO customers VALUES(customers_seq.nextval, 'Alicja', 'Tracz', '76071509449', to_date('15/07/1976', 'dd/mm/yyyy'), 'f', '0048547998342', '77060524110908338264468672');
INSERT INTO customers VALUES(customers_seq.nextval, 'Wojciech', 'Sosnowski', '58122478773', to_date('24/12/1958', 'dd/mm/yyyy'), 'm', '0048282654331', '49755920503653097837358920');
INSERT INTO customers VALUES(customers_seq.nextval, 'Jakub', 'Kot', '76101908736', to_date('19/10/1976', 'dd/mm/yyyy'), 'm', '748102808', '73717708129256561435071506');
INSERT INTO customers VALUES(customers_seq.nextval, 'Mariola', 'Zimnicka', '88071335781', to_date('13/07/1988', 'dd/mm/yyyy'), 'f', '614896044', '97797181846922144521910961');

--populate Visits table

CREATE SEQUENCE visits_seq
INCREMENT BY 1
START WITH 1;

INSERT INTO visits VALUES(visits_seq.nextval, 111111, TO_TIMESTAMP('10-Sie-21 14:10:10'), 'good', 'n');
INSERT INTO visits VALUES(visits_seq.nextval, 111111, TO_TIMESTAMP('12-Sie-21 8:12:00'), 'average', 'y');
INSERT INTO visits VALUES(visits_seq.nextval, 111111, TO_TIMESTAMP('01-Wrz-21 12:46:08'), 'very good', 'n');
INSERT INTO visits VALUES(visits_seq.nextval, 111114, TO_TIMESTAMP('03-Wrz-21 13:14:08'), 'very good', 'n');
INSERT INTO visits VALUES(visits_seq.nextval, 111112, TO_TIMESTAMP('03-Wrz-21 16:40:10'), 'bad', 'y');
INSERT INTO visits VALUES(visits_seq.nextval, 111111, TO_TIMESTAMP('05-Wrz-21 09:32:00'), 'average', 'y');
INSERT INTO visits VALUES(visits_seq.nextval, 111114, TO_TIMESTAMP('05-Wrz-21 10:46:08'), 'good', 'n');
INSERT INTO visits VALUES(visits_seq.nextval, 111113, TO_TIMESTAMP('05-Wrz-21 13:50:49'), 'bad', 'n');
INSERT INTO visits VALUES(visits_seq.nextval, 111111, TO_TIMESTAMP('10-Wrz-21 15:47:30'), 'very good', 'y');

--populate Washes table

CREATE SEQUENCE washes_seq
INCREMENT BY 1
START WITH 1;

INSERT INTO washes VALUES(washes_seq.nextval, 1, 3, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 1, 12, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 1, 21, 'y', 'n');

INSERT INTO washes VALUES(washes_seq.nextval, 2, 7, 'n', 'n');

INSERT INTO washes VALUES(washes_seq.nextval, 3, 23, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 3, 24, 'n', 'y');

INSERT INTO washes VALUES(washes_seq.nextval, 4, 4, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 4, 8, 'y', 'n');

INSERT INTO washes VALUES(washes_seq.nextval, 5, 15, 'n', 'n');
INSERT INTO washes VALUES(washes_seq.nextval, 5, 20, 'n', 'n');
INSERT INTO washes VALUES(washes_seq.nextval, 5, 11, 'n', 'y');

INSERT INTO washes VALUES(washes_seq.nextval, 6, 9, 'y', 'n');
INSERT INTO washes VALUES(washes_seq.nextval, 6, 23, 'n', 'n');

INSERT INTO washes VALUES(washes_seq.nextval, 7, 3, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 7, 27, 'n', 'y');

INSERT INTO washes VALUES(washes_seq.nextval, 8, 15, 'n', 'n');

INSERT INTO washes VALUES(washes_seq.nextval, 9, 7, 'y', 'n');
INSERT INTO washes VALUES(washes_seq.nextval, 9, 10, 'n', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 9, 21, 'y', 'y');
INSERT INTO washes VALUES(washes_seq.nextval, 9, 27, 'y', 'n');

--populate Complaints table

CREATE SEQUENCE complaints_seq
INCREMENT BY 1
START WITH 1;

INSERT INTO complaints VALUES(complaints_seq.nextval, 4, to_date('15/08/2021', 'dd/mm/yyyy'), 'email', 'price', 'Expensive duvet washing.', 'y');
INSERT INTO complaints VALUES(complaints_seq.nextval, 10, to_date('04/09/2021', 'dd/mm/yyyy'), 'website', 'additions', 'Washing powder ran out. I paid for the full service even though I was forced to use my own detergent.', 'y');
INSERT INTO complaints VALUES(complaints_seq.nextval, 11, to_date('04/09/2021', 'dd/mm/yyyy'), 'email', 'additions', 'During my visit washing powder ran out. It would be great if you could make discounts in such situations.', 'n');
INSERT INTO complaints VALUES(complaints_seq.nextval, 13, to_date('07/09/2021', 'dd/mm/yyyy'), 'directly', 'price', 'Expensive duvet washing.', 'y');
INSERT INTO complaints VALUES(complaints_seq.nextval, 13, to_date('07/09/2021', 'dd/mm/yyyy'), 'directly', 'failure', 'The clothes dryer was broken.', 'y');
INSERT INTO complaints VALUES(complaints_seq.nextval, 16, to_date('08/09/2021', 'dd/mm/yyyy'), 'website', 'equipment', 'Small capacity washing machine.', 'n');
INSERT INTO complaints VALUES(complaints_seq.nextval, 16, to_date('08/09/2021', 'dd/mm/yyyy'), 'website', 'service', 'There was no one who could help me operate the washing machine.', 'n');

--commit changes

COMMIT;

CREATE TABLE fabrics (
fabric_id NUMBER,	
fabric_type VARCHAR2(40) CONSTRAINT fabr_type_nn NOT NULL,
color_category VARCHAR2(9) CONSTRAINT fsbr_col_cat_nn NOT NULL,
spin_speed NUMBER(4),
CONSTRAINT fabrics_pk PRIMARY KEY(fabric_id),
CONSTRAINT fabr_col_cat_ch CHECK(color_category IN ('white','delicates','resistant')));

CREATE TABLE programs (
program_no NUMBER,
fabric_id NUMBER,
washing_time NUMBER(3) CONSTRAINT prog_wash_time_nn NOT NULL,
temperature NUMBER CONSTRAINT prog_temp_nn NOT NULL,
additional_rinsing CHAR(3) CONSTRAINT prog_add_rins_nn NOT NULL,
CONSTRAINT programs_pk PRIMARY KEY(program_no),
CONSTRAINT prog_fabr_id_fk FOREIGN KEY (fabric_id) REFERENCES fabrics(fabric_id),
CONSTRAINT prog_wash_time_ch CHECK(washing_time > 0),
CONSTRAINT prog_temp_ch CHECK(temperature > 0 AND temperature < 100),
CONSTRAINT prog_add_rins_ch CHECK(additional_rinsing IN ('yes','no')));

CREATE TABLE machines (
machine_no NUMBER,
manufacturer VARCHAR2(50) CONSTRAINT mach_manu_nn NOT NULL,
energy_class VARCHAR2(4),
annual_power_cons NUMBER(3),
noise_level NUMBER(2),
purchase_date DATE,
CONSTRAINT machines_pk PRIMARY KEY(machine_no),
CONSTRAINT mach_ann_pow_cons_ch CHECK(annual_power_cons > 0),
CONSTRAINT mach_noise_lev_ch CHECK(noise_level > 0),
CONSTRAINT mach_ener_cl_ch CHECK(energy_class IN ('A','A+','A++','A+++','B','C','D')));

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
CONSTRAINT cust_sex_ch CHECK(sex IN ('F','M')));

CREATE TABLE visits (
visit_id NUMBER,
customer_id CHAR(6),
date_time DATE CONSTRAINT vis_date_time_nn NOT NULL,
visit_rating VARCHAR2(12),
whether_invoice CHAR(3) CONSTRAINT vis_whet_inv_nn NOT NULL,
CONSTRAINT visits_pk PRIMARY KEY(visit_id),
CONSTRAINT vis_cust_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT vis_rating_ch CHECK(visit_rating IN ('very good','good','average','bad','very bad')),
CONSTRAINT vis_whet_inv_ch CHECK(whether_invoice IN ('yes','no')));

CREATE TABLE washes (
wash_id NUMBER,
visit_id NUMBER,
service_id NUMBER,
additional_powder CHAR(3) CONSTRAINT wash_add_powd_nn NOT NULL,
free_drying CHAR(3) CONSTRAINT wash_free_dry_nn NOT NULL,
CONSTRAINT washes_pk PRIMARY KEY(wash_id),
CONSTRAINT wash_visit_id_fk FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
CONSTRAINT wash_serv_id_fk FOREIGN KEY (service_id) REFERENCES services(service_id),
CONSTRAINT wash_add_powd_ch CHECK(additional_powder IN ('yes','no')),
CONSTRAINT wash_free_dry_ch CHECK(free_drying IN ('yes','no')));

CREATE TABLE complaints (
complaint_id NUMBER,
wash_id NUMBER,
submission_date DATE CONSTRAINT comp_subm_date_nn NOT NULL,
submission_method VARCHAR2(10),
complaint_category VARCHAR2(8),
complaint_description VARCHAR2(150),
whether_considered CHAR(3) CONSTRAINT comp_whet_cons_nn NOT NULL,
CONSTRAINT complaints_pk PRIMARY KEY(complaint_id),
CONSTRAINT comp_wash_id_fk FOREIGN KEY (wash_id) REFERENCES washes(wash_id),
CONSTRAINT comp_sub_meth_ch CHECK(submission_method IN ('directly','email','website')),
CONSTRAINT comp_comp_cat_ch CHECK(complaint_category IN ('equipment','price','cleanliness','service','additions','failure','other')),
CONSTRAINT comp_whet_cons_ch CHECK(whether_considered IN ('yes','no')));

COMMIT;

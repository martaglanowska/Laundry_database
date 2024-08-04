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
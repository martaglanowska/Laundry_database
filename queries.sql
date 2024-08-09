--Display a list of individual visits on which at least one free drying service was performed.

SELECT
    v.visit_id "Visit ID",
    COUNT(w.wash_id) "Number of drying services"
FROM
    visits v
    JOIN washes w ON w.visit_id = v.visit_id
WHERE
    w.free_drying = 'y'                           --filter before aggregation
GROUP BY
    v.visit_id
HAVING
    COUNT(w.wash_id) > 0                         --filter after aggregation
ORDER BY
    2 DESC;

--Display the name of the highest temperature program for individual washing machines.

SELECT
    s.machine_no,
    p.program_no,
    p.temperature
FROM
    services s
    JOIN programs p ON p.program_no = s.program_no
WHERE
    p.temperature = (
        SELECT
            MAX(pr.temperature)               --WHERE clause - maximum internal value of individual groups
        FROM
            programs pr
            JOIN services se ON pr.program_no = se.program_no
        WHERE
            s.machine_no = se.machine_no
    )
ORDER BY
    s.machine_no;

--Display the category of complaints that received the most complaints in 2021, along with the number of those complaints.

CREATE OR REPLACE VIEW catcomplaintno AS                        --view with aggregated data
    SELECT
        complaint_category,
        COUNT(complaint_id) complaints_no
    FROM
        complaints
    WHERE
        TO_CHAR(submission_date, 'yyyy') = '2021'
    GROUP BY
        complaint_category;

SELECT
    *
FROM
    catcomplaintno;

SELECT
    complaint_category,
    complaints_no
FROM
    catcomplaintno
WHERE
    complaints_no = (
        SELECT
            MAX(complaints_no)
        FROM
            catcomplaintno
    );
                        
--For each person who used the laundry in 2021, display the comment in the form of "Mr Kowalski Jan, number of complaints in May - 8".

SELECT
    DECODE(c.sex, 'm', 'Mr', 'f', 'Mrs')
    || ' '
    || c.surname
    || ' '
    || c.first_name
    || ', number of complaints in '
    || DECODE(EXTRACT(MONTH FROM v.date_time),'1','January','2','February','3','March','4','April','5','May','6','June','7','July','8','August','9','September','10','October','11','November','12','December')
    || ' - '
    || COUNT(co.complaint_id) information
FROM
    complaints co
    JOIN washes w ON co.wash_id = w.wash_id
    JOIN visits v ON w.visit_id = v.visit_id
    JOIN customers c ON v.customer_id = c.customer_id
WHERE
    EXTRACT(YEAR FROM v.date_time) = '2021'
GROUP BY
    c.surname,
    c.first_name,
    c.sex,
    EXTRACT(MONTH FROM v.date_time)
ORDER BY
    EXTRACT(MONTH FROM v.date_time),
    COUNT(co.complaint_id);

--Display a list of visits, the customer's name and surname, the date of the complaint and the category of the complaint, and even display washes for which no complaint was filed.

SELECT
    v.visit_id "Visit ID",
    w.wash_id "Wash ID",
    INITCAP(cu.surname) "Surname",
    INITCAP(cu.first_name) "Name",
    co.submission_date "Submission date",
    co.complaint_category "Category"
FROM
    visits v
    LEFT JOIN washes w ON v.visit_id = w.visit_id
    LEFT JOIN complaints co ON co.wash_id = w.wash_id
    JOIN customers cu ON v.customer_id = cu.customer_id
ORDER BY
    1 ASC;

--Display the most frequently used washing machine.

--first approach (HAVING and nested query)
SELECT
    s.machine_no,
    COUNT(w.wash_id)
FROM
    washes w
    JOIN services s ON w.service_id = s.service_id
GROUP BY
    s.machine_no
HAVING
    COUNT(w.wash_id) = (
        SELECT
            MAX(COUNT(wa.wash_id))       --maximum value over the aggregated groups
        FROM
            washes wa
            JOIN services se ON wa.service_id = se.service_id
        GROUP BY
            se.machine_no
    );

--second aproach (WHERE clause on VIEW)
CREATE OR REPLACE VIEW machinewashesno AS
    SELECT
        s.machine_no,
        COUNT(w.wash_id) wash_no           --alias required
    FROM
        washes w
        JOIN services s ON w.service_id = s.service_id
    GROUP BY
        s.machine_no;

SELECT
    *
FROM
    machinewashesno;

SELECT
    *
FROM
    machinewashesno
WHERE
    wash_no = (
        SELECT
            MAX(wash_no)
        FROM
            machinewashesno
    );

--Calculate the bills paid by individual customers, indicate the number of washes done and the average fee for one wash. Display how many free drying services have been performed and how much would the additional profit be if this service cost a symbolic fee of 5.5.

CREATE OR REPLACE VIEW bills AS
    SELECT
        c.first_name
        || ' '
        || c.surname "Name and surname",
        SUM(s.price) "Bills paid",
        COUNT(w.wash_id) "Number of washes done",
        ROUND(SUM(s.price) / COUNT(w.wash_id),2) "Average fee per wash",
        SUM(CASE WHEN w.free_drying = 'y' THEN 1 ELSE 0 END) "Number of free dryings done",
        SUM(CASE WHEN w.free_drying = 'y' THEN 1 ELSE 0 END) * 5.5 "Potential additional profit"
    FROM
        customers c
        JOIN visits v ON c.customer_id = v.customer_id
        JOIN washes w ON v.visit_id = w.visit_id
        JOIN services s ON w.service_id = s.service_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.surname
    ORDER BY
        "Bills paid" DESC;

SELECT
    *
FROM
    bills;

SELECT
    SUM("Bills paid") "Total profit",
    SUM("Potential additional profit") "Total potential additional profit",
    SUM("Bills paid") + SUM("Potential additional profit") "Total potential profit"
FROM
    bills;

--Check, if the level of satisfaction is higher when using free additions.

SELECT
    v.visit_rating "Rating",
    SUM(CASE WHEN w.additional_powder = 'y' THEN 1 ELSE 0 END) "Number of additional powder bags",
    SUM(CASE WHEN w.free_drying = 'y' THEN 1 ELSE 0 END) "Number of free dryings"
FROM
    washes w
    JOIN visits v ON w.visit_id = v.visit_id
GROUP BY
    v.visit_rating
ORDER BY
    "Number of additional powder bags" DESC,
    "Number of free dryings" DESC;

SELECT
    "Rating",
    "Number of additional powder bags" + "Number of free dryings" "Free additions used"
FROM (
    SELECT
        v.visit_rating "Rating",
        SUM(CASE WHEN w.additional_powder = 'y' THEN 1 ELSE 0 END) "Number of additional powder bags",
        SUM(CASE WHEN w.free_drying = 'y' THEN 1 ELSE 0 END) "Number of free dryings"
    FROM
        washes w
        JOIN visits v ON w.visit_id = v.visit_id
    GROUP BY
        v.visit_rating
    )
ORDER BY
    "Free additions used" DESC;

--Display how many days after the visits complaints were received.

SELECT
    v.date_time,
    c.submission_date,
    EXTRACT(DAY FROM c.submission_date) - EXTRACT(DAY FROM(CAST(v.date_time AS DATE))) "Days difference"
FROM
    visits v
    JOIN washes w ON v.visit_id = w.visit_id
    JOIN complaints c ON w.wash_id = c.wash_id;
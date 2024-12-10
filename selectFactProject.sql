SELECT
    r.id_project AS project_id,
    r.id_performer AS performer_id,
    p.customer AS customer_id,
    ag.id AS agreement_id,
    a.id AS account_id,
    r.date AS report_date,
    r.hours_worked,
    (r.hours_worked * pe.time_rate * pe.allowance_factor) AS total_payment,
    ((r.hours_worked * pe.time_rate * pe.allowance_factor) * 1.4) AS total_cost
FROM Reports r
JOIN Performer pe ON r.id_performer = pe.id
JOIN Project p ON r.id_project = p.id
JOIN Customer c ON p.customer = c.id
JOIN Agreement ag ON ag.customer = c.id
JOIN account a ON a.id_agreement = ag.id
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM account a_inner
        WHERE a_inner.id_agreement = ag.id
          AND a_inner.status_of_payment = 'Unpaid'
          AND DATEDIFF(MONTH, ag.date, GETDATE()) <= 3
    )
    AND NOT EXISTS (
        SELECT 1
        FROM Reports r_inner
        WHERE r_inner.id_performer = r.id_performer
          AND r_inner.date = r.date
        GROUP BY r_inner.id_performer, r_inner.date
        HAVING SUM(r_inner.hours_worked) > 10
    )
    AND r.hours_worked <= 10;
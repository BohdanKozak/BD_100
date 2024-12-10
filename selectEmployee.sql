SELECT 
    e.id AS employee_id,                                
    CONCAT(dp.surname, ' ', dp.name, ' ', dp.father_name) AS full_name,
    dp.date_of_birth,                                   
    dp.place_of_birth,                                  
    dp.passport_data,                                   
    e.report_number,                                    
    e.home_address
FROM Employees e
JOIN data_Passport dp
    ON e.id_passport = dp.id
CREATE OR REPLACE VIEW employee_salary_analysis AS
WITH department_avg AS (
  SELECT
    department_id,
    ROUND(AVG(salary)) AS department_avg_salary
  FROM
    employees
  GROUP BY
    department_id
)
SELECT
  d.name AS department_name,
  e.name AS employee_name,
  e.salary,
  da.department_avg_salary,
  RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS salary_rank_in_department
FROM
  employees e
  JOIN departments d ON e.department_id = d.id
  JOIN department_avg da ON e.department_id = da.department_id
ORDER BY
  d.name,
  salary_rank_in_department;
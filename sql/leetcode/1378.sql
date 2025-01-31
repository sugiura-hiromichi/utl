select eu.unique_id, e.name
from employees as e
left join employeeuni as eu using (id)
;

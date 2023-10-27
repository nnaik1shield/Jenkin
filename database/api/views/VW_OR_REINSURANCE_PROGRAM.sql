 CREATE OR REPLACE VIEW VW_OR_REINSURANCE_PROGRAM("PROGRAM_ID", "PROGRAM_NAME") AS 
  select p.program_id,
       p.program_name
from program_product pp,
     program p
where
     pp.program_program_id = p.program_id
     and 
     pp.reinsurance_tf = 'T'
group by p.program_id,p.program_name;
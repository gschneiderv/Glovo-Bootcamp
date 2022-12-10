 
--join trademark table and group table to obtain the names
create table vehicles_kc.trademark_group
as select  t2.id_group , t2.name as name_trademark,  bg.name as name_group, id_trademark  
	 from vehicles_kc.trademark t2  
		left join vehicles_kc.business_group bg    
		on  t2.id_group =bg.id_group ;

--join the above table with the model table:


create table vehicles_kc.trademark_group_model
as select  id_model , cm.name as name_model, name_trademark, name_group
	 from vehicles_kc.car_model cm   
		left join vehicles_kc.trademark_group tg  
		on  cm.id_trademark =tg.id_trademark;


	
--join color and insurance and select columns that were asked:  
	

select name_model, name_trademark, name_group, dt_purchase ,registration_plate ,c."name" as name_color, km_tot ,ci."name" as name_insurance, num_insurance 
from vehicles_kc.vehicle v  
left join vehicles_kc.trademark_group_model mt 
on v.id_model = mt.id_model
left join color c
on c.id_color = v.id_color
left join car_insurance ci 
on ci.id_insurance = v.id_insurance;



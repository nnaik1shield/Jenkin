create or replace FORCE view vw_bi_event_subscription_log
as
select
	object_id
from
	(select
		object_id,
		row_number() over (partition by object_id order by time_stamp desc) rn
	from
		bi_event_subscription_log
	where
		status is null
	and
		object_type_id in (2365146,
						2365346,
						3204946,
						2364946,
						2365246,
						63,
						2240405,
						2359401,
						309,
						3203646,
						3201546,
						2288705,
						629,
						2276904,
						62,
						2297706,
						3331746,
						2365046,
						12,
						24,
						3345646,
						3336746,
						3342246,
						3337146,
						3396246,
						3355448,
						3336846,
						3351946,
						3337746,
						3395946,
						3484348,
						3336946,
						3337046)
					    )
where rn = 1;

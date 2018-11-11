-- 1 ----------------------------------------
select *
from subscriptions
limit 100;
-- There are two different segments

-- 2
-- January 2017
-- February 2017
-- March 2017

-- 3 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
)
select *
from months;

-- 4 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
)
select *
from cross_join
limit 100;

-- 5 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
),
status as (
	select
  	id,
  	startDate as month,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
    	      or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive87,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
            or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive30
  from cross_join
)
select *
from status
limit 100;

-- 6 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
),
status as (
	select
  	id,
  	startDate as month,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled87,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
    	      or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive87,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled30,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
            or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive30
  from cross_join
)
select *
from status
limit 100;

-- 7 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
),
status as (
	select
  	id,
  	startDate as month,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled87,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
    	      or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive87,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled30,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
            or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive30
  from cross_join
),
statusAggregate as (
	select
  	month,
  	sum(isCancelled87) as sumCancelled87,
  	sum(isActive87) as sumActive87,
  	sum(isCancelled30) as sumCancelled30,
  	sum(isActive30) as sumActive30
  from status
  group by 1
  order by 1
)
select *
from statusAggregate;

-- 8 ----------------------------------------
with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
),
status as (
	select
  	id,
  	startDate as month,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled87,
  	case
  		when
  					(segment = 87)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
    	      or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive87,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled30,
  	case
  		when
  					(segment = 30)
  			and (subscription_start < startDate)
  			and ((subscription_end >= startDate)
            or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive30
  from cross_join
),
statusAggregate as (
	select
  	month,
  	sum(isCancelled87) as sumCancelled87,
  	sum(isActive87) as sumActive87,
  	sum(isCancelled30) as sumCancelled30,
  	sum(isActive30) as sumActive30
  from status
  group by 1
  order by 1
),
rawChurn as (
	select
		month,
 		(1.0 * sumCancelled87 / sumActive87) as rawChurn87,
  	(1.0 * sumCancelled30 / sumActive30) as rawChurn30
	from statusAggregate
	group by 1
	order by 1
)
select
	month as 'Month',
  (round(rawChurn87, 4) * 100) as 'Percent Churn (87)',
  (round(rawChurn30, 4) * 100) as 'Percent Churn (30)'
from rawChurn
group by 1
order by 1;
-- Segment 30 has a lower churn rate


-- 9 ----------------------------------------
-- This code could be modified by removing
-- the hard-coded segments and instead using
-- more abstract methods of showing segments.

-- The following code does just that. It does
-- the desired job of including an unknown
-- number of segments in the final query.

with months as (
	select
  	'2017-01-01' as startDate,
  	'2017-01-31' as endDate
  union
  select
  	'2017-02-01' as startDate,
  	'2017-02-28' as endDate
  union
  select
  	'2017-03-01' as startDate,
  	'2017-03-31' as endDate
),
cross_join as (
	select *
  from subscriptions
  cross join months
),
status as (
	select
  	segment,
  	startDate as month,
  	case
  		when
  					(subscription_start < startDate)
  			and (subscription_end
  						between startDate
  						and endDate)
  		then 1
  		else 0
  	end as isCancelled,
  	case
  		when
  					(subscription_start < startDate)
  			and ((subscription_end >= startDate)
    	      or (subscription_end is null))
  		then 1
  		else 0
  	end as isActive
  from cross_join
),
statusAggregate as (
	select
  	segment,
  	month,
  	sum(isCancelled) as sumCancelled,
  	sum(isActive) as sumActive
  from status
  group by 1,2
  order by 1
),
rawChurn as (
	select
  	segment,
		month,
 		(1.0 * sumCancelled / sumActive) as decChurn
	from statusAggregate
	group by 1,2
	order by 1
)
select
	segment as 'Segment',
	month as 'Month',
  (round(decChurn, 4) * 100) as 'Percent Churn'
from rawChurn
group by 1,2
order by 1;
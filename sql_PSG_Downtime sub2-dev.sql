
select 
x.OpsDate
,x.WorkCenter
,x.UserID
,x.Code
,lc.LocDesc
,dt.DTDesc
,datepart(HH,hc.HourDesc) as OpsHour
,(x.Duration*c.AvgCrew)/60.0 as DurTime
from (
select 
d.OpsDate
,d.WorkCenter
,d.OrderNumber
,d.UserID
,d.Code
,left(d.code,2) as LocCode
,right(left(d.code,4),2) as DTCode
,right(left(d.code,6),2) as HourCode
,case when 
ISNUMERIC(replace(replace(substring(d.code,7,9),char(13),''),char(10),''))=0 then 0 else replace(replace(substring(d.code,7,9),char(13),''),char(10),'')
end as Duration


from vOPS_CoatingLines_DT_Data d ) x left join dim_CoatingLines_LocCodes lc on lc.LocCode=x.LocCode
										left join dim_CoatingLines_DTCodes dt on dt.DTCode=x.DTCode
											left join dim_CoatingLines_HourCodes hc on hc.HourCode=x.HourCode
											 LEFT OUTER JOIN
                         dbo.vOPS_CrewAverage AS c ON c.OpsDate = x.OpsDate AND c.workcenter = x.WorkCenter
						 where lc.LocDesc is not null 
						 and dt.DTDesc is not null
						 and hc.HourDesc is not null

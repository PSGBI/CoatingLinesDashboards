
select 
x.*
,lc.LocDesc
,dt.DTDesc
,hc.HourDesc
,x.Duration as DurTime
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
,SUBSTRING(d.code,7,9) as Duration


from vOPS_CoatingLines_DT_Data d ) x left join dim_CoatingLines_LocCodes lc on lc.LocCode=x.LocCode
										left join dim_CoatingLines_DTCodes dt on dt.DTCode=x.DTCode
											left join dim_CoatingLines_HourCodes hc on hc.HourCode=x.HourCode
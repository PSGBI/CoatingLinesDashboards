

--this is the PBI root query fro down hours


select
x.OpsDate,
x.WorkCenter,
x.OpHour,
CONCAT(x.opsdate,wc.WorkCenterNum,x.ophour) as DWH,
x.DT_Reason,
x.DT_Comment,
x.DT_Duration,
CONCAT(x.opsdate,concat('Hour-',x.ophour)) as [Date-Hour],
concat('Hour-',x.ophour) as [Operations Hour],
d.DepartmentCode,
d.DepartmentDesc
from
(
select 
h.OpsDate,h.WorkCenter,h.OpHour,h.DT_Reason,h.DT_Comment,sum(h.DT_Duration) as DT_Duration
 from vOPS_DTbyhour h 
 group by h.OpsDate,h.WorkCenter,h.OpHour,h.DT_Reason,h.DT_Comment) x left join PSG_Hub.dbo.dim_ReportingWorkCenters wc on wc.WorkCenterNum=x.WorkCenter
			left join PSG_Hub.dbo.dim_ReportingDepartments d on d.DepartmentID=wc.DepartmentID
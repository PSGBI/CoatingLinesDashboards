use PSG_Hub;

select 
x.OpsDate
,x.workcenter
,datepart(HOUR,isnull(h.HourDesc,x.LineStop)) as OpHour
,CONCAT(x.OpsDate,x.workcenter,datepart(HOUR,isnull(h.HourDesc,x.LineStop))) as DWH
,dt.DTDesc as DT_Reason
,'Code Used' as DT_Comment
,case 
	when 
,x.DTMin as DT_Duration
,CONCAT(x.opsdate,concat(' Hour-',datepart(HOUR,isnull(h.HourDesc,x.LineStop)))) as [Date-Hour]
,CONCAT('Hour-',datepart(HOUR,isnull(h.HourDesc,x.LineStop))) as [Operations Hour]
,d.DepartmentCode
,d.DepartmentDesc
from
(

select 

OpsDate
,workcenter
,stop_reason
,stop_comment
,left(stop_comment,2) as LocCode
,right(left(stop_comment,4),2) as ReasonCode
,right(left(stop_comment,6),2) as HourCode
,stop as LineStop
,case 
	when stop_comment is null or stop_comment='' then 1 else  SUBSTRING(stop_comment,7,4) end as DTMin


from vops_SeamlessToHour where workcenter in ('57301','57302','57303','57304','57305','57306') and OpsDate>='20181112'
 and stop_comment <> '' and LEN(stop_comment) < 10

 ) x left join dim_CoatingLines_DTCodes dt on dt.DTCode=x.ReasonCode
			left join dim_CoatingLines_HourCodes h on h.HourCode=x.HourCode
				left join dim_CoatingLines_LocCodes l on l.LocCode=x.LocCode
					left join PSG_Hub.dbo.dim_ReportingWorkCenters wc on wc.WorkCenterNum=x.WorkCenter
					left join PSG_Hub.dbo.dim_ReportingDepartments d on d.DepartmentID=wc.DepartmentID

				



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
	when stop_comment is null or stop_comment='' then '1' else  SUBSTRING(stop_comment,7,4) end as DTMin


from vops_SeamlessToHour where workcenter in ('57301','57302','57303','57304','57305','57306') and OpsDate>='20181112'
 --and stop_comment <> '' and LEN(stop_comment) < 10
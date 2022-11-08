select 
    "Region Name" as region_name
    , "RegionType" as region_type
    , "Indicator Name" as indicator_name
    , "Indicator Unit" as indicator_unit 
    , "Date" as date_valued_at
    , "Value" as value
from dh_datastack_raw.REAL_ESTATE_ATLAS."ZRHVI2020JUL"

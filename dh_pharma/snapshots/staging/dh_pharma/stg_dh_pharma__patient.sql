{% snapshot stg_patient %}

{{
    config(
      target_database='DH_PHARMA',
      target_schema='DH_PHARMA_STG',
      unique_key='Patient_ID',

      strategy='check',
      check_cols='all',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('dh_pharma', 'patient') }}

{% endsnapshot %}
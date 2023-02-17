{% snapshot int_dh_pharma__physicians %}

{{
    config(
      target_database='DH_PHARMA',
      target_schema='DH_PHARMA_INT',
      unique_key='Physician_ID',

      strategy='check',
      check_cols='all',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ref('stg_dh_pharma__physicians')}}

{% endsnapshot %}
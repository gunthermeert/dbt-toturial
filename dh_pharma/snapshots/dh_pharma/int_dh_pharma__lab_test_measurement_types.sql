{% snapshot int_dh_pharma__lab_test_measurement_types %}

{{
    config(
      target_database='DH_PHARMA',
      target_schema='DH_PHARMA_INT',
      unique_key='Lab_Test_Measurement_Type_ID',

      strategy='check',
      check_cols='all',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ref('stg_dh_pharma__lab_test_measurement_types')}}

{% endsnapshot %}
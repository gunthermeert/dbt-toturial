{% snapshot employee_snapshot %}

{{
    config(
      target_database='DH_DATASTACK_ANALYTICS',
      target_schema='snapshot',
      unique_key="national_insurance_nbr||'-'||first_name",

      strategy='timestamp',
      updated_at='update_ts',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ source('dh_datastack', 'employee') }}

{% endsnapshot %}

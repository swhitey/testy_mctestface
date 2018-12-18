
#### The following is a template for reproducing bugs.
# We keep each bug self-contained by creating a model with the bug number in it, followed by a small description. For example, 19606_postgres_blank_timezone.

# If you need a special dialect to repro your bug, check the Connection panel.
# If you don't see your desired dialect there, check https://github.com/looker/helltool/blob/master/test/test_databases.yml

# Make sure any explores you use are hidden to keep the explore menu from getting cluttered.
# You can visit any explores mentioned in this model file by clicking the down arrow next to the model name on the top bar.

# Rather than relying on a particular dataset, it can be convenient to set your own data. Hence we use a derived table.
# You can SELECT values that are the required datatype. If you need multiple rows, then you can UNION ALL together multiple SELECT statements.

# When writing a bug make sure to always provide enough information and to always use the filebaug template. If the instance is on-prem no access
# then grab the fileabug template from another instance. For some ideas on what info is required see this post
# https://dig.looker.com/t/bugs-looker-a-brief-guide/1203
#some change

connection: "thelook_snowflake"

explore: test {
  hidden: no # IMPORTANT - keep explores hidden to avoid clutter
}

datagroup: foo {
  sql_trigger: select count(*) from ${test.SQL_TABLE_NAME} ;;
}

view: test  {
  derived_table: {
    sql:
      SELECT 'foo' as some_string, 1 as some_num, '2017-12-31' as some_date
      UNION ALL
      SELECT 'bar' as some_string, 2 as some_num, '2017-12-30' as some_date
      UNION ALL
      SELECT 'bar' as some_string, 3 as some_num, '2017-12-29' as some_date
      UNION ALL
      SELECT 'bar' as some_string, 4 as some_num, '2017-12-28' as some_date
      ;;
    sql_trigger_value: select current_date ;;
  }

  dimension: some_string {
    type: string
    hidden: yes
  }

  dimension: some_num {
    type: number
  }

  dimension_group: some_date {
    type: time
  }

  measure: count {
    type: count
  }
}

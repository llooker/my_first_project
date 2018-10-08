view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }


  dimension: time_since_signup {
    type: number
    sql: DATEDIFF('days', ${users.created_date}, ${order_items.created_date} ) ;;
  }

  dimension: ordered_within_30_days {
    type: yesno
    sql:  ${time_since_signup} <= 30  ;;
  }

  measure: users_who_ordered_withing_30_days_1 {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: ordered_within_30_days
      value: "yes"
    }
  }

  measure: users_who_ordered_withing_30_days_2 {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: time_since_signup
      value: "<= 30"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, order_items.count]
  }
}

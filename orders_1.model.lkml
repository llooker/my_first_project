connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: users {
  join: order_items {
    type: left_outer
    sql_on:  ${users.id} = ${order_items.user_id}  ;;
    relationship: one_to_many
  }
}

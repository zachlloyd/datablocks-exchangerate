connection: "bq-looker-datablocks"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

datagroup: default {
  max_cache_age: "48 hours"
  sql_trigger: select * from exchangerate.forex_real ;;
}

# explore: forex {}
#
# explore: forex_real {}

explore: forex_historical_real {
  label: "Exchange Rates"
}

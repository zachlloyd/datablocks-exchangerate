view: bq_forex_historical_real {
  derived_table: {
    sql: select x.day
, (case when x.AUD_USD is null then
    (case when lag(x.AUD_USD, 1) over (order by x.day) is null then
      lag(x.AUD_USD, 2) over (order by x.day)
      Else lag(x.AUD_USD, 1) over (order by x.day) End)
    Else x.AUD_USD End) as AUD_USD
, (case when x.CHF_JPY is null then
    (case when lag(x.CHF_JPY, 1) over (order by x.day) is null then
      lag(x.CHF_JPY, 2) over (order by x.day)
      Else lag(x.CHF_JPY, 1) over (order by x.day) End)
    Else x.CHF_JPY End) as CHF_JPY
, (case when x.EUR_CHF is null then
    (case when lag(x.EUR_CHF, 1) over (order by x.day) is null then
      lag(x.EUR_CHF, 2) over (order by x.day)
      Else lag(x.EUR_CHF, 1) over (order by x.day) End)
    Else x.EUR_CHF End) as EUR_CHF
, (case when x.EUR_GBP is null then
    (case when lag(x.EUR_GBP, 1) over (order by x.day) is null then
      lag(x.EUR_GBP, 2) over (order by x.day)
      Else lag(x.EUR_GBP, 1) over (order by x.day) End)
    Else x.EUR_GBP End) as EUR_GBP
, (case when x.EUR_JPY is null then
    (case when lag(x.EUR_JPY, 1) over (order by x.day) is null then
      lag(x.EUR_JPY, 2) over (order by x.day)
      Else lag(x.EUR_JPY, 1) over (order by x.day) End)
    Else x.EUR_JPY End) as EUR_JPY
, (case when x.EUR_USD is null then
    (case when lag(x.EUR_USD, 1) over (order by x.day) is null then
      lag(x.EUR_USD, 2) over (order by x.day)
      Else lag(x.EUR_USD, 1) over (order by x.day) End)
    Else x.EUR_USD End) as EUR_USD
, (case when x.GBP_CHF is null then
    (case when lag(x.GBP_CHF, 1) over (order by x.day) is null then
      lag(x.GBP_CHF, 2) over (order by x.day)
      Else lag(x.GBP_CHF, 1) over (order by x.day) End)
    Else x.GBP_CHF End) as GBP_CHF
, (case when x.GBP_JPY is null then
    (case when lag(x.GBP_JPY, 1) over (order by x.day) is null then
      lag(x.GBP_JPY, 2) over (order by x.day)
      Else lag(x.GBP_JPY, 1) over (order by x.day) End)
    Else x.GBP_JPY End) as GBP_JPY
, (case when x.GBP_USD is null then
    (case when lag(x.GBP_USD, 1) over (order by x.day) is null then
      lag(x.GBP_USD, 2) over (order by x.day)
      Else lag(x.GBP_USD, 1) over (order by x.day) End)
    Else x.GBP_USD End) as GBP_USD
, (case when x.NZD_USD is null then
    (case when lag(x.NZD_USD, 1) over (order by x.day) is null then
      lag(x.NZD_USD, 2) over (order by x.day)
      Else lag(x.NZD_USD, 1) over (order by x.day) End)
    Else x.NZD_USD End) as NZD_USD
, (case when x.USD_CAD is null then
    (case when lag(x.USD_CAD, 1) over (order by x.day) is null then
      lag(x.USD_CAD, 2) over (order by x.day)
      Else lag(x.USD_CAD, 1) over (order by x.day) End)
    Else x.USD_CAD End) as USD_CAD
, (case when x.USD_CHF is null then
    (case when lag(x.USD_CHF, 1) over (order by x.day) is null then
      lag(x.USD_CHF, 2) over (order by x.day)
      Else lag(x.USD_CHF, 1) over (order by x.day) End)
    Else x.USD_CHF End) as USD_CHF
, (case when x.USD_JPY is null then
    (case when lag(x.USD_JPY, 1) over (order by x.day) is null then
      lag(x.USD_JPY, 2) over (order by x.day)
      Else lag(x.USD_JPY, 1) over (order by x.day) End)
    Else x.USD_JPY End) as USD_JPY

from
(WITH
      splitted AS (SELECT *
        FROM
          UNNEST( SPLIT(RPAD('',
                1 + DATE_DIFF(CURRENT_DATE(), DATE("1999-01-01"), DAY),
                '.'),''))),
        with_row_numbers AS (
        SELECT
          ROW_NUMBER() OVER() AS pos, *
        FROM splitted), calendar_day AS (
        SELECT
          cast(DATE_ADD(DATE("1999-01-01"), INTERVAL (pos - 1) DAY) as timestamp)AS day
        FROM with_row_numbers)
      SELECT *
      FROM calendar_day
      left join (
      SELECT
        cast(forex.exchange_date as timestamp) AS forex_exchange_date,
        forex.AUD_USD  AS AUD_USD,
        forex.CHF_JPY  AS CHF_JPY,
        forex.EUR_CHF  AS EUR_CHF,
        forex.EUR_GBP  AS EUR_GBP,
        forex.EUR_JPY  AS EUR_JPY,
        forex.EUR_USD  AS EUR_USD,
        forex.GBP_CHF  AS GBP_CHF,
        forex.GBP_JPY  AS GBP_JPY,
        forex.GBP_USD  AS GBP_USD,
        forex.NZD_USD  AS NZD_USD,
        forex.USD_CAD  AS USD_CAD,
        forex.USD_CHF  AS USD_CHF,
        forex.USD_JPY  AS USD_JPY
      FROM `looker-datablocks.exchangerate.forex`  AS forex
      Group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
      Union All
      SELECT
        cast(forex_real.exchange_date as timestamp) AS forex_exchange_date,
        1/(forex_real.AUD*(1/forex_real.USD))  AS AUD_USD,
        1/(forex_real.CHF*(1/forex_real.JPY))  AS CHF_JPY ,
        forex_real.CHF  AS EUR_CHF,
        forex_real.GBP AS EUR_GBP,
        forex_real.JPY  AS EUR_JPY,
        forex_real.USD  AS EUR_USD,
        forex_real.CHF*(1/forex_real.GBP)  AS GBP_CHF,
        forex_real.JPY*(1/forex_real.GBP)  AS GBP_JPY,
        forex_real.USD*(1/forex_real.GBP)  AS GBP_USD,
        1/(forex_real.NZD*(1/forex_real.USD))  AS NZD_USD,
        forex_real.CAD *(1/forex_real.USD) AS USD_CAD,
        forex_real.CHF *(1/forex_real.USD) AS USD_CHF,
        forex_real.JPY *(1/forex_real.USD) AS USD_JPY
      FROM `looker-datablocks.exchangerate.forex_real_full`  AS forex_real
      Group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
) as forex
    on forex.forex_exchange_date = calendar_day.day) as x
    order by day desc
       ;;
    datagroup_trigger: default
  }

  dimension_group: forex_exchange {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.day ;;
  }

  dimension: aud_usd {
    label: "AUD/USD"
    description: "1 Australian Dollar = X US Dollars"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.AUD_USD ;;
    hidden: yes
  }

  dimension: chf_jpy {
    label: "CHF/JPY"
    description: "1 Swiss Franc = X Japanese Yen"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.CHF_JPY ;;
    hidden: yes
  }

  dimension: eur_chf {
    label: "EUR/CHF"
    description: "1 Euro = X Swiss Francs"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.EUR_CHF ;;
    hidden: yes
  }

  dimension: eur_gbp {
    label: "EUR/GBP"
    description: "1 Euro = X Great British Pounds"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.EUR_GBP ;;
    hidden: yes
  }

  dimension: eur_jpy {
    label: "EUR/JPY"
    description: "1 Euro = X Japanese Yen"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.EUR_JPY ;;
    hidden: yes
  }

  dimension: eur_usd {
    label: "EUR/USD"
    description: "1 Euro = X US Dollars"
    type:  number
    sql: ${TABLE}.EUR_USD ;;
    hidden: yes
  }

  dimension: gbp_chf {
    label: "GBP/CHF"
    description: "1 Great British Pound = X Swiss Francs"
    type:  number
    sql: ${TABLE}.GBP_CHF ;;
    hidden: yes
  }

  dimension: gbp_jpy {
    label: "GBP/JPY"
    description: "1 Great British Pound = X Japanese Yen"
    type:  number
    sql: ${TABLE}.GBP_JPY ;;
    hidden: yes
  }

  dimension: gbp_usd {
    label: "GBP/USD"
    description: "1 Great British Pound = X US dollars"
    type:  number
    sql: ${TABLE}.GBP_USD ;;
    hidden: yes
  }

  dimension: nzd_usd {
    label: "NZD/USD"
    description: "1 New Zealand Dollar = X US dollars"
    type:  number
    sql: ${TABLE}.NZD_USD ;;
    hidden: yes
  }

  dimension: usd_cad {
    label: "USD/CAD"
    description: "1 US dollar = X Canadian dollars"
    type:  number
    sql: ${TABLE}.USD_CAD ;;
    hidden: yes
  }

  dimension: usd_chf {
    label: "USD/CHF"
    description: "1 US dollar = X Swiss Francs"
    type:  number
    sql: ${TABLE}.USD_CHF ;;
    hidden: yes
  }

  dimension: usd_jpy {
    label: "USD/JPY"
    description: "1 US dollar = X Japanese Yen"
    type:  number
    sql: ${TABLE}.USD_JPY ;;
    hidden: yes
  }

  ################################### measures to plot on graph ###################################

  measure: audusd {
    label: "AUD/USD"
    description: "1 Australian Dollar = X US Dollars"
    value_format_name: decimal_4
    type:  max
    sql: ${aud_usd} ;;
  }

  measure: chfjpy {
    label: "CHF/JPY"
    description: "1 Swiss Franc = X Japanese Yen"
    value_format_name: decimal_4
    type:  max
    sql: ${chf_jpy};;
  }

  measure: eurchf {
    label: "EUR/CHF"
    description: "1 Euro = X Swiss Francs"
    value_format_name: decimal_4
    type:  max
    sql: ${eur_chf} ;;
  }

  measure: eurgbp {
    label: "EUR/GBP"
    description: "1 Euro = X Great British Pounds"
    value_format_name: decimal_4
    type:  max
    sql: ${eur_gbp} ;;
  }

  measure: eurjpy {
    label: "EUR/JPY"
    description: "1 Euro = X Japanese Yen"
    value_format_name: decimal_4
    type:  max
    sql: ${eur_jpy};;
  }

  measure: eurusd {
    label: "EUR/USD"
    description: "1 Euro = X US Dollars"
    value_format_name: decimal_4
    type:  max
    sql: ${eur_usd} ;;
  }

  measure: gbpchf {
    label: "GBP/CHF"
    description: "1 Great British Pound = X Swiss Francs"
    value_format_name: decimal_4
    type:  max
    sql: ${gbp_chf};;
  }

  measure: gbpjpy {
    label: "GBP/JPY"
    description: "1 Great British Pound = X Japanese Yen"
    value_format_name: decimal_4
    type:  max
    sql: ${gbp_jpy} ;;
  }

  measure: gbpusd {
    label: "GBP/USD"
    description: "1 Great British Pound = X US dollars"
    value_format_name: decimal_4
    type:  max
    sql: ${gbp_usd} ;;
  }

  measure: nzdusd {
    label: "NZD/USD"
    description: "1 New Zealand Dollar = X US dollars"
    value_format_name: decimal_4
    type:  max
    sql: ${nzd_usd};;
  }

  measure: usdcad {
    label: "USD/CAD"
    description: "1 US dollar = X Canadian dollars"
    value_format_name: decimal_4
    type:  max
    sql: ${usd_cad} ;;
  }

  measure: usdchf {
    label: "USD/CHF"
    description: "1 US dollar = X Swiss Francs"
    value_format_name: decimal_4
    type:  max
    sql: ${usd_chf} ;;
  }

  measure: usdjpy {
    label: "USD/JPY"
    description: "1 US dollar = X Japanese Yen"
    value_format_name: decimal_4
    type: max
    sql: ${usd_jpy} ;;
  }


}

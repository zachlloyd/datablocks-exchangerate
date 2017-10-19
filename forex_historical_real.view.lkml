view: forex_historical_real {
  derived_table: {
    sql: SELECT
        forex.exchange_date AS forex_exchange_date,
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
      Union All
      SELECT
        forex_real.exchange_date AS exchange_date,
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
      FROM exchangerate.forex_real  AS forex_real
       ;;
    datagroup_trigger: default
  }

  dimension: forex_exchange_date {
    type: date
    sql: ${TABLE}.forex_exchange_date ;;
  }

  dimension: aud_usd {
    label: "AUD/USD"
    description: "1 Australian Dollar = X US Dollars"
    value_format_name: decimal_4
    type:  number
    sql: ${TABLE}.AUD_USD ;;
  }

  dimension: chf_jpy {
    label: "CHF/JPY"
    description: "1 Swiss Franc = X Japanese Yen"
    type:  number
    sql: ${TABLE}.CHF_JPY ;;
  }

  dimension: eur_chf {
    label: "EUR/CHF"
    description: "1 Euro = X Swiss Francs"
    type:  number
    sql: ${TABLE}.EUR_CHF ;;
  }

  dimension: eur_gbp {
    label: "EUR/GBP"
    description: "1 Euro = X Great British Pounds"
    type:  number
    sql: ${TABLE}.EUR_GBP ;;
  }

  dimension: eur_jpy {
    label: "EUR/JPY"
    description: "1 Euro = X Japanese Yen"
    type:  number
    sql: ${TABLE}.EUR_JPY ;;
  }

  dimension: eur_usd {
    label: "EUR/USD"
    description: "1 Euro = X US Dollars"
    type:  number
    sql: ${TABLE}.EUR_USD ;;
  }

  dimension: gbp_chf {
    label: "GBP/CHF"
    description: "1 Great British Pound = X Swiss Francs"
    type:  number
    sql: ${TABLE}.GBP_CHF ;;
  }

  dimension: gbp_jpy {
    label: "GBP/JPY"
    description: "1 Great British Pound = X Japanese Yen"
    type:  number
    sql: ${TABLE}.GBP_JPY ;;
  }

  dimension: gbp_usd {
    label: "GBP/USD"
    description: "1 Great British Pound = X US dollars"
    type:  number
    sql: ${TABLE}.GBP_USD ;;
  }

  dimension: nzd_usd {
    label: "NZD/USD"
    description: "1 New Zealand Dollar = X US dollars"
    type:  number
    sql: ${TABLE}.NZD_USD ;;
  }

  dimension: usd_cad {
    label: "USD/CAD"
    description: "1 US dollar = X Canadian dollars"
    type:  number
    sql: ${TABLE}.USD_CAD ;;
  }

  dimension: usd_chf {
    label: "USD/CHF"
    description: "1 US dollar = X Swiss Francs"
    type:  number
    sql: ${TABLE}.USD_CHF ;;
  }

  dimension: usd_jpy {
    label: "USD/JPY"
    description: "1 US dollar = X Japanese Yen"
    type:  number
    sql: ${TABLE}.USD_JPY ;;
  }

}

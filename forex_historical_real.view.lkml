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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: forex_exchange_date {
    type: date
    sql: ${TABLE}.forex_exchange_date ;;
  }

  dimension: aud_usd {
    type: string
    sql: ${TABLE}.AUD_USD ;;
  }

  dimension: chf_jpy {
    type: string
    sql: ${TABLE}.CHF_JPY ;;
  }

  dimension: eur_chf {
    type: string
    sql: ${TABLE}.EUR_CHF ;;
  }

  dimension: eur_gbp {
    type: string
    sql: ${TABLE}.EUR_GBP ;;
  }

  dimension: eur_jpy {
    type: string
    sql: ${TABLE}.EUR_JPY ;;
  }

  dimension: eur_usd {
    type: string
    sql: ${TABLE}.EUR_USD ;;
  }

  dimension: gbp_chf {
    type: string
    sql: ${TABLE}.GBP_CHF ;;
  }

  dimension: gbp_jpy {
    type: string
    sql: ${TABLE}.GBP_JPY ;;
  }

  dimension: gbp_usd {
    type: string
    sql: ${TABLE}.GBP_USD ;;
  }

  dimension: nzd_usd {
    type: string
    sql: ${TABLE}.NZD_USD ;;
  }

  dimension: usd_cad {
    type: string
    sql: ${TABLE}.USD_CAD ;;
  }

  dimension: usd_chf {
    type: string
    sql: ${TABLE}.USD_CHF ;;
  }

  dimension: usd_jpy {
    type: string
    sql: ${TABLE}.USD_JPY ;;
  }

  set: detail {
    fields: [
      forex_exchange_date,
      aud_usd,
      chf_jpy,
      eur_chf,
      eur_gbp,
      eur_jpy,
      eur_usd,
      gbp_chf,
      gbp_jpy,
      gbp_usd,
      nzd_usd,
      usd_cad,
      usd_chf,
      usd_jpy
    ]
  }
}

view: forex_real_dt {
  derived_table: {
    sql: SELECT
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
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
      ORDER BY 1 DESC
       ;;
      datagroup_trigger: default
  }

  dimension_group: exchange {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.exchange_date ;;
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

}

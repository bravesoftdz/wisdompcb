EP070含税总价格

CASE 
     WHEN Data0050.sales_order_unit_ptr = 0 THEN --pcs
     	ROUND(
              (
                  (
                      CASE data0060.tax_in_price
                           WHEN ''N'' THEN ( --单价
                                    CASE ISNULL(data0010.Invprice_from_64, 0)
                                         WHEN 0 THEN Data0060.part_price--60表
                                         ELSE Data0064.part_price--64表
                                    END
                                ) * (1 + data0189.state_tax / 100.00) --tax
                           ELSE (
                                    CASE ISNULL(data0010.Invprice_from_64, 0)
                                         WHEN 0 THEN Data0060.part_price
                                         ELSE Data0064.part_price
                                    END
                                )
                      END
                  ) * Data0064.QUAN_SHIPPED + (
                      CASE data0060.tax_in_price
                           WHEN ''N'' THEN (
                                    CASE ISNULL(data0010.Invprice_from_64, 0)
                                         WHEN 0 THEN Data0060.part_price
                                         ELSE Data0064.part_price
                                    END
                                ) *(1 + data0189.state_tax / 100.00)
                           ELSE (
                                    CASE ISNULL(data0010.Invprice_from_64, 0)
                                         WHEN 0 THEN Data0060.part_price
                                         ELSE Data0064.part_price
                                    END
                                )
                      END
                  ) * data0064.ovsh_qty * (100 -Data0064.ovsh_discount) * 0.01
              ) + 0.0000001,
              2
          )
     ELSE ROUND(
              (
                  (
                      CASE data0060.tax_in_price
                           WHEN ''N'' THEN data0060.set_price * (1 + data0189.state_tax / 100.00)
                           ELSE data0060.set_price
                      END
                  ) * (
                      1.000000 * Data0064.QUAN_SHIPPED / (Data0050.set_x_qty * Data0050.set_y_qty)
                  )
                  + (
                      CASE data0060.tax_in_price
                           WHEN ''N'' THEN data0060.set_price * (1 + data0189.state_tax / 100.00)
                           ELSE data0060.set_price
                      END
                  ) *(
                      1.00000 * data0064.ovsh_qty / (Data0050.set_x_qty * Data0050.set_y_qty)
                  ) * (100 -Data0064.ovsh_discount) * 0.01
              ) + 0.0000001,
              2
          )
END AS yestax_amount, 
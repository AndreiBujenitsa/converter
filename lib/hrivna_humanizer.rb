class HrivnaHumanizer
   SIMPLE_NUM = [ " ", " одна ", " дві ", " три ", " чотири ", " п'ять ", " шість ", " сім ", " вісім ", " дев'ять ",
                 "десять ", " одинадцять ", " дванадцять ", " тринадцять ", " чотирнадцять ", " п'ятнадцять ", " шістнадцять ", " сімнадцять ", 
                 "вісімнадцять ", " дев'ятнадцять" ]
    DOZENS    = [ " ", " десять ", " двадцять ", " тридцять ", " сорок ", " пятдесят ", " шістдесят ", " сімдесят ", " вісімдесят ", " дев'яносто" ]
    HUNDREDS  = [ " ", " сто ", " двісті ", " триста ", " чотириста ", " п'ятсот ", " шістсот ", " сімсот ", " вісімсот ", " дев'ятсот" ]
    THOUSANDS = [ "тисяч ", " тисяча ", " тисячі ", " тисячі ", " тисячі ", " тисяч ", " тисяч ", " тисяч ", " тисяч ", " тисяч" ]
    MILLIONS  =  ["мільйонів ","мільйон ","мільйони ","мільйони ", " мільйони ", " мільйонів ", " мільйонів ", " мільйонів ", " мільйонів ", " мільйонів"]

    def initialize
      @res = ""
    end

   def to_hrivna(sum, is_million=false)
    sum = sum.to_i
    @res = case 
            when sum < 0
              "-#{to_hrivna(-sum)}"
            when sum == 0
              ""
            when sum <= 19
              SIMPLE_NUM[sum]
            when sum <= 99
              n,r = sum.divmod(10)
              DOZENS[n] + to_hrivna(r)
            when sum <= 999
              n,r = sum.divmod(100)
              HUNDREDS[n] + to_hrivna(r)
            when sum <= 9999
              n,r = sum.divmod(1000)
              SIMPLE_NUM[n] + THOUSANDS[n] + to_hrivna(r)
            when sum <= 19999
              n,r = sum.divmod(1000)
              SIMPLE_NUM[n] + " тисяч " + to_hrivna(r)
            when sum <= 99999
              n,r = sum.divmod(1000)
              to_hrivna(n) + THOUSANDS[n%10] + to_hrivna(r)
            when sum <= 999999
              n,r = sum.divmod(100000)
              HUNDREDS[n] + to_hrivna(r)
            when sum <= 9999999
              n,r = sum.divmod(1000000)
              SIMPLE_NUM[n] + MILLIONS[n]+ to_hrivna(r)
            when sum <= 19999999
              n,r = sum.divmod(1000000)
              SIMPLE_NUM[n] + " мільйонів " + to_hrivna(r)
            when sum <= 99999999
              n,r = sum.divmod(1000000)
              to_hrivna(n) + MILLIONS[n%10] + to_hrivna(r)
            when sum <= 999999999
              n,r = sum.divmod(100000000)
              HUNDREDS[n] + to_hrivna(r)
            else
              "завелика сумма"
          end
    @res
  end
end
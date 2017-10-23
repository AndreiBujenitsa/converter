class HrivnaHumanizer
   SIMPLE_NUM = [ " ", " одна ", " дві ", " три ", " чотири ", " п'ять ", " шість ", " сім ", " вісім ", " дев'ять ",
                 "десять ", " одинадцять ", " дванадцять ", " тринадцять ", " чотирнадцять ", " п'ятнадцять ", " шістнадцять ", " сімнадцять ", 
                 "вісімнадцять ", " дев'ятнадцять " ]
    DOZENS    = [ " ", " десять ", " двадцять ", " тридцять ", " сорок ", " пятдесят ", " шістдесят ", " сімдесят ", " вісімдесят ", " дев'яносто " ]
    HUNDREDS  = [ " ", " сто ", " двісті ", " триста ", " чотириста ", " п'ятсот ", " шістсот ", " сімсот ", " вісімсот ", " дев'ятсот " ]
    THOUSANDS = [ "тисяч ", " тисяча ", " тисячі ", " тисячі ", " тисячі ", " тисяч ", " тисяч ", " тисяч ", " тисяч ", " тисяч ", " тисяч " ]
    MILLIONS  =  [ "мільйонів ","мільйон ","мільйони ","мільйони ", " мільйони ", " мільйонів ", " мільйонів ", " мільйонів ", " мільйонів ", " мільйонів "]
    HRIVNA    = [ " гривень ", " гривня ", " гривні ", " гривні ", " гривні ", " гривень ", " гривень ", " гривень ", " гривень ", " гривень " ]

    def initialize
      @res = ""
    end

    def to_str(sum)
      return "зфвелика сумма" if sum>999999999
      res = words(sum)
      res = res.gsub(/\bодна мільйон\b/, 'один мільйон').gsub(/\bдві мільйони\b/, 'два мільйони') if sum >= 10**6
      res += HRIVNA[last_digit(sum)] unless res.blank?

      res.split.join(" ")
    end

  private
    def words(sum)
      sum = sum.to_i
      @res = case 
            when sum < 0
              "мінус #{words(-sum)}"
            when sum == 0
              ""
            when sum <= 19
              SIMPLE_NUM[sum]
            when sum <= 99
              n,r = sum.divmod(10)
              DOZENS[n] + words(r)
            when sum <= 999
              n,r = sum.divmod(100)
              HUNDREDS[n] + words(r)
            when sum <= 9999
              n,r = sum.divmod(1000)
              SIMPLE_NUM[n] + THOUSANDS[n] + words(r)
            when sum <= 19999
              n,r = sum.divmod(1000)
              SIMPLE_NUM[n] + " тисяч " + words(r)
            when sum <= 99999
              n,r = sum.divmod(1000)
              words(n) + THOUSANDS[last_digit(n)] + words(r)
            when sum <= 999999
              n,r = sum.divmod(1000)
              words(n) + THOUSANDS[last_digit(n)] + words(r)
            when sum <= 9999999
              n,r = sum.divmod(1000000)
              SIMPLE_NUM[n] + MILLIONS[n]+ words(r)
            when sum <= 19999999
              n,r = sum.divmod(1000000)
              SIMPLE_NUM[n] + " мільйонів " + words(r)
            when sum <= 99999999
              n,r = sum.divmod(1000000)
              words(n) + MILLIONS[last_digit(n)] + words(r)
            when sum <= 999999999
              n,r = sum.divmod(1000000)
              words(n) + MILLIONS[last_digit(n)] + words(r)
            else
              "завелика сумма"
          end
      @res
    end

  def last_digit(sum)
    sum.to_s[-1].to_i
  end
end

class Integer
  def currency_to_words
    obj = HrivnaHumanizer.new
    obj.to_str(self)
  end 
end
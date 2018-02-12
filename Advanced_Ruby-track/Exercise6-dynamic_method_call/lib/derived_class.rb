class DerivedClass < String
  def exclude?(substr)
    !include?(substr)
  end

  def fun
    'Hi I dont need an argument'
  end

  def sum(a, b, c = 1)
    puts "a = #{a}\tb = #{b}\tc = #{c}"
    a.to_i + b.to_i + c.to_i
  end

  def product(num1, num2 = 2, num3 = 1)
    puts "num1 = #{num1}\tnum2 = #{num2}\tnum3 = #{num3}"
    num1.to_i * num2.to_i * num3.to_i
  end

  def abc(a, b = 1)
    "Hi from a = #{a}\n b = #{b}"
  end
end

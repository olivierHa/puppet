# The Enumeration class provides default Enumerable::Enumerator creation for Puppet Programming Language
# runtime objects that supports the concept of enumeration.
#
class Puppet::Pops::Types::Enumeration
  # Produces an Enumerable::Enumerator for Array, Hash, Integer, Integer Range, and String.
  #
  def self.enumerator(o)
    @@singleton ||= new
    @@singleton.enumerator(o)
  end

  # Produces an Enumerator for Array, Hash, Integer, Integer Range, and String.
  #
  def enumerator(o)
    case o
    when String
      x = o.chars
      # Ruby 1.9.3 returns an Enumerator, and 2.0.0 an Array
      x.is_a?(Array) ? x.each : x
    when Integer
      o.times
    when Array
      o.each
    when Hash
      o.each
    when Puppet::Pops::Types::PIntegerType
      # Not enumerable if representing an infinite range
      o.enumerable? ? o.each : nil
    else
      nil
    end
  end
end

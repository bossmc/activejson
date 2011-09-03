require 'json'
require 'multi_json'

MultiJson.engine = :yajl

module ActiveJson
  class Core
    instance_methods.each {|m| undef_method(m) unless %w(__id__ __send__ to_json instance_eval nil? is_a? class).include?(m.to_s)}

    def initialize(&blk)
      @hash = {}
      blk.call(self)
    end

    def method_missing(key, *values)
      value = if block_given?
        ActiveJson::Core.new do |a| yield a end
      else
        values.size == 1 ? values.first : values
      end

      if @hash[key].nil?
        @hash[key] = value
      elsif @hash[key].is_a? Array
        @hash[key] << value
      else
        @hash[key] = [@hash[key], value]
      end
    end

    def respond_to?(method) true end
    def to_json() MultiJson.encode(@hash) end
    def to_s() @hash.to_s end
    def inspect() @hash.inspect end
  end
end

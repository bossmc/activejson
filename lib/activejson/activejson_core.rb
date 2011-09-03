require 'json'
require 'multi_json'

MultiJson.engine = :yajl

module ActiveJson
  class Core
    instance_methods.each {|m| undef_method(m) unless %w(__id__ __send__ to_json instance_eval nil? is_a? class).include?(m.to_s)}
    attr_accessor :hash

    def initialize()
      @hash = {}
      yield self if block_given?
    end

    def method_missing(key, *values)
      value = 
        if block_given?
          if values.size == 1
            values.first.map do |v|
              new_json_ele = ActiveJson::Core.new
              yield new_json_ele, v
              new_json_ele
            end
          else
            new_json_ele = ActiveJson::Core.new
            yield new_json_ele
            new_json_ele
          end
        else
          values.size == 1 ? values.first : values
        end

      if @hash[key].nil?
        @hash[key] = value
      elsif @hash[key].is_a? Array
        @hash[key] << value
      else
        @hash[key] = value
      end
    end

    def respond_to?(method) true end
    def to_json() MultiJson.encode(@hash) end
    def to_s() @hash.to_s end
    def inspect() @hash.inspect end
  end
end

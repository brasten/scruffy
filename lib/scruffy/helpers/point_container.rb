module Scruffy::Helpers
  
  # ==Scruffy::Helpers::PointContainer
  #
  # Author:: Mat Schaffer
  # Date:: March 22nd, 2007
  #
  # Allows all standard point operations to be called on both Array and Hash
  module PointContainer
    def self.extended point_set
      point_set.extend(const_get("#{point_set.class.to_s}_ext"))
    end

    def sortable(values)
      values.find_all { |v| v.respond_to?(:<=>) && !v.nil? }
    end
    
    def summable(values)
      values.find_all { |v| v.respond_to?(:+) && !v.nil? }
    end
    
    def maximum_value
      sortable(values).sort.last
    end
    
    def minimum_value
      sortable(values).sort.first
    end
    
    def sum
      summable(values).inject(0) { |sum, i| sum += i }
    end
    
    def inject_with_index memo
      index = 0
      inject(memo) do |memo, item|
        ret = yield memo, item, index
        index = index.succ
        ret
      end
    end
    
    def minimum_key
      sortable(keys).sort.first
    end
      
    def maximum_key
      sortable(keys).sort.last
    end
    
    module Array_ext
      def values
        return self unless is_coordinate_list?
        collect { |x,y| y}
      end
      
      def keys
        return [0,size-1] unless is_coordinate_list?
        collect { |x,y| x}
      end
      
      def is_coordinate_list?
        if any? && first.is_a?(Array) && first.size == 2
          return true
        end
        return false
      end
      
      def each_point(&block)
        if is_coordinate_list?
          each{|x,y|block.call(x,y)}
        else
          size.times{|k|block.call(k,self[k])}
        end
      end
    end
    
    module Hash_ext
      def is_coordinate_list?
        true
      end
      
      def each_point(&block)
        keys.sort.each{|k|block.call(k,self[k])}
      end
      
      def inject memo
        keys.sort.each do |k|
          memo = yield memo, self[k]
        end
        memo
      end
      
      def size
        maximum_key - minimum_key + 1
      end
    end
  end
end
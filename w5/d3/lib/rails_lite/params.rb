require 'uri'

class Params
  def initialize(req, route_params)
    p "********in params init #{route_params.class}"
     p "********in params init #{route_params}"
    @params = parse_www_encoded_form(req.query_string) ||  {}
    @params.merge!(parse_www_encoded_form(req.body))
    @params.merge!(route_params)
    self
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_json
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    kvs = URI.decode_www_form(www_encoded_form || "")
    {}.tap do |query_hash|
      kvs.each do |k,v| 
        build_hash(query_hash, split_keys(k), v)
      end
    end
  end
  
  def build_hash(query_hash, key_array, val)
    if(key_array.count == 1)
      query_hash[key_array[0]] = val
      query_hash
    else
      query_hash[key_array[0]] =  {}
      build_hash(query_hash[key_array[0]], key_array[1..-1], val)
    end
  end
  
  def split_keys(key_string)
    key_string.split(/\]\[|\[|\]/)
  end
end

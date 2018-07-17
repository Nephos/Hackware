require "duktape"

module Duktape::API::Push
  def <<(hash : Hash)
    hash_ptr = self.push_object
    hash.each do |idx, value|
      self << value
      self.put_prop_string hash_ptr, idx.to_s
    end
  end
end

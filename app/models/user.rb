class User < ActiveResource::Base
  self.site = "http://localhost:3000"
  self.include_format_in_path = false

  has_many :albums
end

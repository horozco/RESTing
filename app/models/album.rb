class Album < ActiveResource::Base
  self.site = "http://localhost:3000"
  self.include_format_in_path = false
end

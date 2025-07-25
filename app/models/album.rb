class Album < ActiveResource::Base
  self.site = "http://localhost:3000"
  self.include_format_in_path = false

  # Fetch albums belonging to the given user. json-server does not support
  # nested resources, so we need to pass the user_id as a query parameter.
  def self.for_user(user_id)
    all(params: { user_id: user_id })
  end
end

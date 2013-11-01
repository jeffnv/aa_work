class GistFile < ActiveRecord::Base
  attr_accessible :body, :gist_id, :name
  belongs_to :gist
end

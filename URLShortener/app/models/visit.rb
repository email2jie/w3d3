#user_id
#url_id
class Visit < ActiveRecord::Base
  validates :user_id, :url_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create({user_id: user.id, url_id: shortened_url.id})
  end

  belongs_to :visitors,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  belongs_to :urls,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: 'ShortenedUrl'

end

# t.string   "long_url",   null: false
# t.string   "short_url",  null: false
# t.integer  "user_id",    null: false

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true

  def self.create_for_user_and_long_url!(user, long_url)
    random = random_code
    ShortenedUrl.create!({short_url: random, long_url: long_url, user_id: user.id})
  end

  def self.random_code
    random = SecureRandom.urlsafe_base64(12)
    while ShortenedUrl.exists?(:short_url => random)
      random = SecureRandom.urlsafe_base64(12)
    end
    random
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: 'Visit'

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitors

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where("created_at >= ?", 10.minutes.ago).distinct.count
  end

end

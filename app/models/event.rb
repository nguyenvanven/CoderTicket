class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming(search)
    if search
      where("(starts_at > ?) and (name like ?) and (publish_at is not null)", DateTime.now,"%#{search}%")
    else
      where("(starts_at > ?) and (publish_at is not null)", DateTime.now)
    end
  end

  def self.search_all(search)
    if search
      where("(name like ?) and (publish_at is not null)","%#{search}%")
    else
      where ("publish_at is not null")
    end
  end

  def self.my_events(user_id)
    where("created_by = ?", user_id)
  end

  def self.publish(id)
    where("id=?",id).update_all(:publish_at => DateTime.now)
  end

  def published?
    return publish_at.present?
  end

  def has_enough_ticket_types?
    return ticket_types.count >= 1
  end

  def past_event?
    return starts_at < DateTime.now
  end
end

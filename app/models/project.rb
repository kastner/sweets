require 'digest/sha1'

class Project < ActiveRecord::Base
  has_many :filters
  has_many :tweeps
  has_many :tweets, :through => :tweeps, :order => "tweets.created_at DESC"
  
  validates_presence_of :name, :terms, :password
  validates_uniqueness_of :name, :case_sensitive => false
  validate :name_restriction
  
  before_create :hash_password
  
  COOKIE_SEPERATOR = "__|__"
  
  # def filter_tweets
  #   move through the ptweets and disconnect any bad ones
  # end

  def self.find_from_name(name)
    find(:first, :conditions => ["name LIKE ?", name])
  end
  
  def self.authenticate(name, password)
    return nil unless p = find_from_name(name)
    db_pw, salt, pwd = p.password.match(/(.{8})(.*)/).to_a
    return p if salty_pass(password, salt) == db_pw
    return nil
  end
  
  def self.salty_pass(password, salt)
    salt + Digest::SHA1.hexdigest("#{salt}__#{CODE_SALT}__#{password}")
  end
  
  def self.random_salt
    chars = (('a'..'z').to_a + ('-'..'=').to_a + ('A'..'Z').to_a).flatten
    (1..8).map { chars[rand(chars.size)] }.join
  end
  
  def self.hashed_name(name)
    Digest::SHA1.hexdigest("#{name}__#{CODE_SALT}")
  end
  
  def self.get_from_cookie(cookie)
    return nil unless cookie
    name, name_h, pass_hash = cookie.split(COOKIE_SEPERATOR)
    return nil unless hashed_name(name) == name_h
    return nil unless p = Project.find_from_name(name)
    return nil unless pass_hash == Digest::SHA1.hexdigest("#{name_h}__#{p.password}")
    return p
  end
  
  def change_password(new_password)
    self.password = new_password
    hash_password
    save!
  end
  
  def hashed_name
    self.class.hashed_name(name)
  end
  
  def hashed_pass
    Digest::SHA1.hexdigest("#{hashed_name}__#{password}")
  end
  
  def cookie
    "#{name}#{COOKIE_SEPERATOR}#{hashed_name}#{COOKIE_SEPERATOR}#{hashed_pass}"
  end
  
  def hash_password
    self.password = self.class.salty_pass(self.password, self.class.random_salt)
  end
  
  def name_restriction
    errors.add(:name, "Must not contain #{COOKIE_SEPERATOR}") if name.match(/#{COOKIE_SEPERATOR}/)
  end
  
  def apply_filters
    tweets.from_users(filters.map(&:from_user)).each do |t|
      # puts "deleting #{t.inspect}"
      self.tweets.delete(t)
    end
  end
end

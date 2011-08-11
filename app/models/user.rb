class User < ActiveRecord::Base
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls

  has_many :group_members, :dependent => :destroy
  has_many :groups, :through => :group_members

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :display_name, :username, :personal_org, :orgs_with_access

  attr_readonly :personal_org

  validates_presence_of :display_name

  after_create do
    Org.create! :creator => self, :display_name => "#{display_name}'s Personal Org", :personal => true
  end

public
  def orgs_with_access
    orgs = []
    groups.each do |group|
      group.projects.each do |project|
        orgs << project.org
      end
    end
    projects.each do |project|
      orgs << project.org
    end
    orgs.uniq
  end

  def personal_org
    groups.each do |group|
      if group.display_name == 'Admins'
        if group.org.personal?
          return group.org
        end
      end
    end
    return nil
  end

end

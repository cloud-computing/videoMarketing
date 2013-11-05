class User
	include Dynamoid::Document

  attr_accessor :password, :password_confirmation, :salt, :encripted_password
	
  field :name
  field :provider
  field :uid
  field :email
  field :encripted_password
  field :salt

  index :created_at, {:type=>:datetime}
  index :id, {:type=>:string}
  index :name, {:type=>:string}
  index :provider, {:type=>:string}
  index :uid, {:type=>:string}
  index :email, {:type=>:string}
  index :updated_at, {:type=>:datetime}

  validates :name, :presence => true, :length => { :in => 3..20 }
  validates_format_of :email, :with => /@/
  validates :password, :confirmation => true

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encripted_password = BCrypt::Engine.hash_secret(password, salt)
      self.provider = "videomarketing"
    end
  end

  def clear_password
    self.password = nil
  end

  def self.create_with_omniauth(auth)
    create!(
      :name     => auth["info"]["nickname"],
      :provider => auth["provider"],
      :uid      => auth["uid"],
      :email    => auth["uid"]
    )
  end

  def self.authenticate(email="", login_password="")
    user = User.find_by_email(email)
    if user && user.match_password(login_password, user.encripted_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="", enc_password="")
    enc_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	#attr_accessible :nombre, :apellidos, :email, :password, :password_confirmation
	
	#devise :database_authenticatable, :registerable,
	#	   :recoverable, :rememberable, :trackable, :validatable
end

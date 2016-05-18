class User < ActiveRecord::Base
  validates :provider, :uid, :name, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    @user = User.find_by(uid: auth_hash[:info][:id], provider: auth_hash[:provider])
    if !@user.nil?
      return @user
    else
      @user = User.new(name: auth_hash[:info][:display_name], uid: auth_hash[:info][:id], provider: auth_hash[:provider], email: auth_hash[:info][:email], nickname: auth_hash[:info][:nickname])

      if @user.save
        return @user
      else
        return nil
      end
    end
  end
end

class Chat < ApplicationRecord
  has_attached_file :attached_file, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png",
                    :path                   => ":rails_root/public/user_data/:attachment/:id/:style/:basename.:extension",
                    :url                    => "/user_data/:attachment/:id/:style/:basename.:extension"
  validates_attachment_content_type :attached_file, content_type: /\Aimage\/.*\z/
  belongs_to :user
end

class Client < ApplicationRecord
    has_one_attached :image

    require "roo"
end

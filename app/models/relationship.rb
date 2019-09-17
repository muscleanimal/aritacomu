class Relationship < ApplicationRecord
  belongs_to :info
  belongs_to :answer, class_name: 'Answer'
end

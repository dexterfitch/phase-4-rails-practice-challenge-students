class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :instructor
end

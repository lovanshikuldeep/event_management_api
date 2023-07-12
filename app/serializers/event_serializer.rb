class EventSerializer < ActiveModel::Serializer
  attributes  :title, :description, :location, :start_time, :end_time
end

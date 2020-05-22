# frozen_string_literal: true
RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  config.default = RGeo::Cartesian.simple_factory(uses_lenient_assertions: true, srid: 4326)
end

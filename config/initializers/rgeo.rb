# frozen_string_literal: true

SRID = 4326

RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  config.default = RGeo::Cartesian.simple_factory(uses_lenient_assertions: true, srid: SRID)
end

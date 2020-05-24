# frozen_string_literal: true
module Countries
  class CountrySyncService < UseCaseService
    def execute(_)
      Country.upsert_all(valid_objects)
    end

    private

    def shapefile
      Rails.root.join('lib/world_borders/TM_WORLD_BORDERS-0.3.shp')
    end

    def import_factory
      RGeo::Cartesian.simple_factory(uses_lenient_assertions: true, srid: 4326)
    end

    def polygons
      polygons = []

      RGeo::Shapefile::Reader.open(shapefile, assume_inner_follows_outer: true, factory: import_factory) do |file|
        file.each do |record|
          polygons << record
        end
      end

      polygons
    end

    def objects
      polygons.map do |feature|
        # https://github.com/rails/rails/issues/35493
        now = Time.zone.now

        latitude = feature['LAT']
        longitude = feature['LON']
        point = "POINT(#{longitude} #{latitude})"

        params = {
          name: feature['NAME'],
          fips: feature['FIPS'],
          iso2: feature['ISO2'],
          iso3: feature['ISO3'],
          un: feature['UN'],
          location: point,
          shape: feature.geometry,
          updated_at: now,
        }

        # Check to make sure the item we are adding is actually valid.
        params if Country.new(skip_uniqueness: true, **params).valid?
      end
    end

    def valid_objects
      objects.compact
    end
  end
end

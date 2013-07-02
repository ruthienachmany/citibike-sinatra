ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/stations.db")

DataMapper.auto_upgrade!


class Station
  include DataMapper::Resource 
  property :id,                   Serial
  property :stationName,          String, :required => true
  property :availableDocks,       Text
  property :totalDocks,           Integer
  property :latitude,             String
  property :longitude,            DateTime
  property :statusValue,          DateTime
  property :statusKey,            String
  property :availableBikes,       String
  property :stAddress1,           String
  property :stAddress2,           String
  property :city,                 String
  property :postalCode,           Integer
  property :location,             String
  property :altitude,             Integer
  property :testStation           String :required => false,
  property :lastCommunicationTime DateTime :required => false,
  property :landMark              String

end

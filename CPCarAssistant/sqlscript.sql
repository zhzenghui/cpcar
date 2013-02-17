CREATE TABLE 'ConsumeRecord' ('id'  integer primary key, 'type' CHAR(1), 'price' float, 'uptime' datetime);
CREATE TABLE 'MyCar' ('id'  integer primary key, 'carNum' varchar(15), 'carModel' varchar(30), 'paytime' datetime, 'currentMileage' float);
CREATE TABLE 'Message' ('id' integer primary key, 'Dealer' varchar(15), 'UDID' varchar(64), 'Message' varchar(300), 'Answer' varchar(300),'IsAnswer' bool, 'uptime' datetime);
CREATE TABLE 'Auto' ( 'AutoID' integer primary key, 'SeriesID' integer, 'Name' varchar(20), 'AutoImg' varchar(100), 'MSRP' float,'IsTestDrive' integer, 'OrderNum' integer);
CREATE TABLE 'AutoSeries' ( 'SeriesID' integer primary key, 'Name' varchar(20), 'SeriesImg' varchar(100), 'Describe' varchar(20), 'OrderNum' integer);
CREATE TABLE 'Images' ( 'ImageID' integer primary key, 'AutoID' integer, 'Thumbnail' varchar(100), 'ImgURL' varchar(100), 'Describe' varchar(20), 'Name' varchar(20), 'SeriesImg' integer, 'OrderNum' integer);
CREATE TABLE 'Activity' ( 'ID' integer primary key, 'DealerID' integer, 'Title' varchar(50), 'ImgURL' varchar(100), 'SupTime' datetime(20));
CREATE TABLE 'City' ('ID' integer primary key,'ProvinceName' varchar(25),'CityName' varchar(25),'Code' ,'Father');
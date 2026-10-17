IF OBJECT_ID('dbo.device_positions', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.device_positions (
        id INT IDENTITY(1,1) PRIMARY KEY,
        device_id NVARCHAR(100) NOT NULL,
        latitude DECIMAL(9,6) NOT NULL,
        longitude DECIMAL(9,6) NOT NULL,
        accuracy DECIMAL(10,3) NULL,
        speed DECIMAL(10,3) NULL,
        source NVARCHAR(50) NOT NULL DEFAULT 'mobile',
        created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );

    CREATE INDEX IX_device_positions_device_created_at
        ON dbo.device_positions(device_id, created_at DESC);
END;

IF OBJECT_ID('dbo.rides', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.rides (
        id NVARCHAR(36) NOT NULL PRIMARY KEY,
        device_id NVARCHAR(100) NOT NULL,
        started_at DATETIME2(3) NOT NULL,
        ended_at DATETIME2(3) NULL,
        status NVARCHAR(10) NOT NULL,
        created_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
    );
    CREATE INDEX IX_rides_device_started ON dbo.rides(device_id, started_at DESC);
END;

IF OBJECT_ID('dbo.ride_points', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ride_points (
        id NVARCHAR(36) NOT NULL PRIMARY KEY,
        ride_id NVARCHAR(36) NOT NULL REFERENCES dbo.rides(id),
        device_id NVARCHAR(100) NOT NULL,
        lat FLOAT NOT NULL, lng FLOAT NOT NULL,
        accuracy FLOAT NULL, altitude FLOAT NULL, speed FLOAT NULL, bearing FLOAT NULL,
        provider NVARCHAR(20) NULL,
        is_mocked BIT NOT NULL DEFAULT 0,
        is_filtered BIT NOT NULL DEFAULT 0,
        filter_reason NVARCHAR(32) NULL,
        recorded_at DATETIME2(3) NOT NULL,
        received_at DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
    );
    CREATE INDEX IX_ride_points_ride_recorded ON dbo.ride_points(ride_id, recorded_at);
    CREATE INDEX IX_ride_points_device_recorded ON dbo.ride_points(device_id, recorded_at DESC);
END;

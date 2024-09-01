USE [master]

IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name='testdb')
begin
CREATE DATABASE [testdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'testdb_data', FILENAME = N'J:\MSSQL13.PENOTEDB01\MSSQL\Data\testdb_data.mdf' , SIZE = 102400KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'testdb_log', FILENAME = N'L:\MSSQL13.PENOTEDB01\MSSQL\Data\testdb_log.ldf' , SIZE = 102400KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )

ALTER DATABASE [testdb] SET COMPATIBILITY_LEVEL = 130
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [testdb].[dbo].[sp_fulltext_database] @action = 'enable'
end

ALTER DATABASE [testdb] SET ANSI_NULL_DEFAULT OFF 

ALTER DATABASE [testdb] SET ANSI_NULLS OFF 

ALTER DATABASE [testdb] SET ANSI_PADDING OFF 

ALTER DATABASE [testdb] SET ANSI_WARNINGS OFF 

ALTER DATABASE [testdb] SET ARITHABORT OFF 

ALTER DATABASE [testdb] SET AUTO_CLOSE OFF 

ALTER DATABASE [testdb] SET AUTO_SHRINK OFF 

ALTER DATABASE [testdb] SET AUTO_UPDATE_STATISTICS ON 

ALTER DATABASE [testdb] SET CURSOR_CLOSE_ON_COMMIT OFF 

ALTER DATABASE [testdb] SET CURSOR_DEFAULT  GLOBAL 

ALTER DATABASE [testdb] SET CONCAT_NULL_YIELDS_NULL OFF 

ALTER DATABASE [testdb] SET NUMERIC_ROUNDABORT OFF 

ALTER DATABASE [testdb] SET QUOTED_IDENTIFIER OFF 

ALTER DATABASE [testdb] SET RECURSIVE_TRIGGERS OFF 

ALTER DATABASE [testdb] SET  DISABLE_BROKER 

ALTER DATABASE [testdb] SET AUTO_UPDATE_STATISTICS_ASYNC ON 

ALTER DATABASE [testdb] SET DATE_CORRELATION_OPTIMIZATION OFF 

ALTER DATABASE [testdb] SET TRUSTWORTHY OFF 

ALTER DATABASE [testdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 

ALTER DATABASE [testdb] SET PARAMETERIZATION SIMPLE 

ALTER DATABASE [testdb] SET READ_COMMITTED_SNAPSHOT OFF 

ALTER DATABASE [testdb] SET HONOR_BROKER_PRIORITY OFF 

ALTER DATABASE [testdb] SET RECOVERY FULL 

ALTER DATABASE [testdb] SET  MULTI_USER 

ALTER DATABASE [testdb] SET PAGE_VERIFY CHECKSUM  

ALTER DATABASE [testdb] SET DB_CHAINING OFF 

ALTER DATABASE [testdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 

ALTER DATABASE [testdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 

ALTER DATABASE [testdb] SET DELAYED_DURABILITY = DISABLED 

ALTER DATABASE [testdb] SET QUERY_STORE = OFF

END

GO

USE [testdb]
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;

ALTER DATABASE [testdb] SET  READ_WRITE 
package main

import (
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var DB *gorm.DB

// DatabaseInit creates the database
func DatabaseInit(test bool) *gorm.DB {
	const addr = "postgresql://root@roach-ui:26257/?sslmode=disable"
	db, err := gorm.Open("postgres", addr)
	if err != nil {
		panic(fmt.Sprintf("failed to connect to database: %v", err))
	}

	if test {
		db.DropTableIfExists(&User{})
		db.DropTableIfExists(&Contact{})
		db.DropTableIfExists(&Update{})
	}

	// Migrate the schema
	db.AutoMigrate(&Update{})
	db.AutoMigrate(&Contact{})
	db.AutoMigrate(&User{})

	DB = db

	return db
}

// GetDB returns a pointer to the database
func GetDB() *gorm.DB {
	return DB
}

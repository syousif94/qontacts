package main

import (
	"github.com/jinzhu/gorm"
	"github.com/lib/pq"
)

// Contact model
type Contact struct {
	gorm.Model
	SharedBy     User `gorm:"foreignkey:SharedByID"`
	SharedByID   uint
	SharedWith   User `gorm:"foreignkey:SharedWithID"`
	SharedWithID uint
	Sharing      pq.StringArray `gorm:"type:varchar(64)[]"`
}

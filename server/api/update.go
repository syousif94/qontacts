package main

import "github.com/jinzhu/gorm"

// Action is performed on User
type Action string

const (
	// ScannedBy Contact scanned user
	ScannedBy Action = "scannedBy"
	// Scanned User scanned contact
	Scanned Action = "scanned"
	// SharedBy Contact shared with user
	SharedBy Action = "sharedBy"
	// RequestedBy Contact requested user info
	RequestedBy Action = "requestedBy"
)

// Update model
type Update struct {
	gorm.Model
	Title     string
	Subtitle  string
	Message   string
	Timestamp string
	Action    Action
	UserID    uint
}

package main

import (
	"math/rand"
	"strings"
	"time"

	"github.com/jinzhu/gorm"
	"golang.org/x/crypto/bcrypt"
)

// User model
type User struct {
	gorm.Model
	Name         string
	Sharing      []Contact `gorm:"foreignkey:SharedByID"`
	Contacts     []Contact `gorm:"foreignkey:SharedWithID"`
	Updates      []Update
	PasswordHash string `gorm:"column:password;not null"`
	Number       string
	Email        string
	Birthday     string
}

func createUser() (User, string) {
	db := GetDB()

	user := User{}

	password := user.generatePassword()

	db.Create(&user)

	return user, password
}

func (u *User) generatePassword() string {
	rand.Seed(time.Now().UnixNano())
	chars := []rune("ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
		"abcdefghijklmnopqrstuvwxyz" +
		"0123456789")
	length := 16
	var b strings.Builder
	for i := 0; i < length; i++ {
		b.WriteRune(chars[rand.Intn(len(chars))])
	}
	password := b.String()
	bytePassword := []byte(password)
	passwordHash, _ := bcrypt.GenerateFromPassword(bytePassword, bcrypt.DefaultCost)
	u.PasswordHash = string(passwordHash)
	return password
}

func (u *User) update(update User) {
	db := GetDB()

	db.Model(&u).Update(update)
}

func (u *User) connectToUser(id uint) {
	db := GetDB()

	var u2 User

	db.First(&u2, id)

	contact := Contact{SharedByID: u2.Model.ID, SharedWithID: u.Model.ID}

	db.Create(&contact)
}

func (u *User) getUserContacts() []Contact {
	db := GetDB()

	db.Preload("Contacts").Preload("Contacts.SharedBy").Find(&u)

	return u.Contacts
}

func (u *User) getUserUpdates() {

}

package main

import (
	log "github.com/sirupsen/logrus"
)

func main() {
	db := DatabaseInit(true)
	defer db.Close()

	user1, user1Password := createUser()
	user1.update(User{Name: "Sammy"})

	log.WithFields(log.Fields{
		"user":     user1,
		"password": user1Password,
	}).Info("User 1 created")

	user2, user2Password := createUser()
	user2.update(User{Name: "Friendo"})

	log.WithFields(log.Fields{
		"user":     user2,
		"password": user2Password,
	}).Info("User 2 created")

	user1.connectToUser(user2.ID)

	user1Contacts := user1.getUserContacts()

	log.WithFields(log.Fields{
		"contacts": user1Contacts,
	}).Info("User 1 contacts")
}

package model

import (
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	Username string `gorm:"unique;not null"`
	Password string `gorm:"not null"`
	Telphone string `gorm:"unique;not null"`
}

type Log struct {
	gorm.Model
	Uid uint
}

type Pills struct {
	gorm.Model
	Uid       uint
	Theme     string
	Latitude  float64
	Longitude float64
	Text      string
	Privacy   bool
}

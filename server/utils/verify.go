package utils

import "regexp"

func VerifyMobileFormat(mobileNum string) bool {
	regular := `^1([38][0-9]|14[579]|5[^4]|16[6]|7[1-35-8]|9[189])\d{8}$`

	reg := regexp.MustCompile(regular)
	return reg.MatchString(mobileNum)
}

package utils

import (
	"encoding/json"
	"fmt"
	"strings"

	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/errors"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/profile"
	sms "github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/sms/v20210111"
)

// https://cloud.tencent.com/document/product/382/43199#.E5.8F.91.E9.80.81.E7.9F.AD.E4.BF.A1
var param = map[string]string{
	"secretId":  "",
	"secretKey": "",
	"sdkAppId":  "",
	"signName":  "",
}

func SmsSignUp(mobileNum string, captcha string) {
	// 认证
	credential := common.NewCredential(param["secretId"], param["secretKey"])

	cpf := profile.NewClientProfile()

	// 实例化sms对象
	client, _ := sms.NewClient(credential, "ap-guangzhou", cpf)

	// 设置请求参数
	request := sms.NewSendSmsRequest()
	request.SmsSdkAppId = common.StringPtr(param["sdkAppId"])
	request.SignName = common.StringPtr(param["signName"])
	request.TemplateId = common.StringPtr("")
	request.TemplateParamSet = common.StringPtrs([]string{captcha})
	request.PhoneNumberSet = common.StringPtrs([]string{strings.Join([]string{"+86", mobileNum}, "")})

	// 发送短信
	response, err := client.SendSms(request)
	if _, ok := err.(*errors.TencentCloudSDKError); ok {
		fmt.Printf("An API error has returned: %s", err)
		return
	}

	if err != nil {
		panic(err)
	}

	b, _ := json.Marshal(response.Response)
	// 打印返回的json字符串
	fmt.Printf("%s", b)
}

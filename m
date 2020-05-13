Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5251D072A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 08:25:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4885C11ACC609;
	Tue, 12 May 2020 23:22:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.238.178.147; helo=sonic308-19.consmr.mail.ir2.yahoo.com; envelope-from=s.maeru@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DB0D11ACC2E7
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589351112; bh=LwHTN4EuzpnbCbRTfE3Do4r7elw/S8JogZ5bLLoHGW0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NvbNwuQToQqg2cBqRD43AZzG2IQvz3dr55pS0mCVUmh/v1Wtd2lDNcl8ca3Mvc9NzjmyK/JM2h3RYAgCwmtW+/cA0QJpzWpVrKNyN7sr+BTD9bW4LPwR9WIWieRNBi9A4Q0rXnXwIupYqtZ1qfPVDC9zGwFnj1MkT0eYb4ce0r3uIbpZmr6rJ9dTQKsjJiXJ/cHc6uNR1kN3rWbSiEXWtKBNMSuDOLRtR5713Rcza0vCCtHzEWAk1gQAvFLDZAHo9vD83Q4+UlbkWaTGeVYuGu79tPSRzM1nryb3gmkWNvvg91/eTWvuWbzKYCzHehwatYKWnUwnneW6lG5bT5AqVQ==
X-YMail-OSG: V7UgpqAVM1nPflA4aqdy5Ma_FBO3.wWRgxQNzilnjdj_6kBAdlMuNQ_qM7XGWyj
 dasLL.sUK1JAPZkch6vpkvYgCi5GZuoO9gAzaUMBV1TGEe7FLZBXMlA5u2ncNtPsgbrjzDYorGYB
 xSKwMNPpPhWOikenQtL9SRxkzZ93.tuxaUAEKDdNNjT315zygzy20RCeMjKnvSJftErivmPa5HDU
 wSb2j_6mOjH1E6P2O480BC_8C.9SXVGds7eRDBLGJ3SIiqv1WBNzXh8q22OMCuNeOdl4XvG_mtsB
 mEy_4Adng2rfKvd9JFtGrsLpaxfxsfwjlVfLuAvBEpYaWOnIn8mfBN0mWMD5X_CGSM_RH5xcz9dQ
 .QS5G6Woiolhc4tBCZ.nARcRk3Rd.iEMGb.nmx56dPoYHXhbffmbIBlq9hrW52fsCZCsjRMzwKG2
 5kYjB4CEynwh5zssCIcnpeOGgCRiZoBmMzv5gb7T0hI_IpTrHDBYvNz8uheyQyLBGDWyd6VbmCz7
 fdzg6_ARk19nrkWBd671Vb8uiAGw9z5LoF0wUvei4bEld0c5Wo82dd9RXuWEX.uJ5b3CP3CpXmtk
 8ef8vsKvSp0mdCGePG4JSXsPtaYyPR1lMgBD3q76O8gEFQOIQt6FRSKPvZvc5Aw6_ILp5vyNN1uW
 OfTYYVXZIbI.8OXH7utQdsvIf9ra7.RHQ1AnUT2mhDkuDosDZsgF0LRFuwWMLxknxjEeCH3S4Vl5
 .Ltt_OuDsjP8gk3IY2s3e1Olso9TgfH2qLTdFmRPIj9XsMq8j7iYnsb4gM8wvilIPMynU_RFr1pZ
 .kas_EL0CHaelVG9ckDbqcP6kA6kGpFdgKO617NQPNgxwFXvcB0wCq.K3OETpOO3T8PiK0QwhhDA
 eygrXeW_C8P8U45XmEt4Td5kNmvLNSSjPSXRug6MpP6DsKFgekN9Kjunm_pGDlZflZXP4pm0jFRB
 u40Ys6WnAYoYB2L6zabjcqIC6wzzH7EHPrOwGz6EUid8tgffqtkTXqKBTOaiz2CGl_UpSOB.KMGf
 24dKbYHHjiH7M7Fuvw7EYZ2P62mDPvSkpp56g2h_AvxfCr9t7PVxvXHgWvU0hdXkBcIrwDoDPaAT
 AicIlMohQdqDTWgBYjFwfQkeX5rRIB_sCaQ95gkJsgbhZO9lfSzqWQOZBJk75j8_m0nMuDYNKfa2
 qwDwxkk0__U6H2Fv5U7R4zU0Qd1lCaIY09PJrMP6ORE39y8SZNCNYfN7TGsK9XCLyJjV2DcI.K61
 d1rdKmFjEkUkcOKiVhR8b1tVoT4gLAgpkZilqKv_eLFfI0wYvbVYXqqbZKd8bp5GYo0Tbpg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 13 May 2020 06:25:12 +0000
Date: Wed, 13 May 2020 06:25:07 +0000 (UTC)
From: United Nations Monetary Unit  <s.maeru@yahoo.com>
Message-ID: <134907967.244737.1589351107863@mail.yahoo.com>
Subject: IRREVOCABLE COMPENSATION PAYMENT OF US$1,750,000.00 VIA ATM VISA
 CARD
MIME-Version: 1.0
References: <134907967.244737.1589351107863.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15904 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4127.0 Safari/537.36
Message-ID-Hash: S2SXYMZD6CPKHBWRNDY2O3QJIKBJJVQK
X-Message-ID-Hash: S2SXYMZD6CPKHBWRNDY2O3QJIKBJJVQK
X-MailFrom: s.maeru@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrswalker.amaliya@hotmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S2SXYMZD6CPKHBWRNDY2O3QJIKBJJVQK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



IRREVOCABLE COMPENSATION PAYMENT OF US$1,750,000.00 VIA ATM VISA CARD
We have actually been authorized by the newly appointed Minister of finance and the governing body of the United Nations Monetary Unit to investigate the unnecessary delay of your payment. During the course of our investigation, we discovered with dismay that your payment has been unnecessarily delayed by corrupt officials of the Bank in attempt to swindle your fund which has lead to so many losses from your end and unnecessary delay in the receipt of your payment.

The United Nations and the International Monetary Fund (IMF) has chosen to pay out all the unpaid contract, inheritance and lotto winning claims by Companies and individuals to 150 Beneficiaries from U.S.A, Europe, Canada, United Arab Emirates, Bahrain, Qatar, Saudi Arabia, South America, Australia and Asia and Africa Continent through ATM Visa Card as this is a global payments technology that enables consumers, businesses, financial institutions and governments to use digital currency instead of Cash and Cheques.

We have arranged your payment to be paid to you through ATM Visa Card and this will be issued on your Name and shall be posted directly to your address via DHL or any courier services available in your country. Upon your contact with us, the sum of US$1,750,000.00 will be credited into the ATM Visa Card and this will enable you to withdraw your funds in any ATM Machines in your country with a minimum withdrawal of US$5000.00 per day. Your limit can be increase to any amount upon your request.
In this regards, you are to contact and furnish the requested information to the Directorate of International Payment and Transfer with the followings;

1. Your Name:
2. Country :
3. Age and Sex:
4. Occupation :
5. Mobile Telephone:
6. Delivery Address:
7. Id Card Identification:

Endeavor to furnish the above information to the officers below forth issuance and delivery of your ATM Visa Card;

MRS. MARIA ANGELS
Director of International Payment

We required your urgent response to this email as directed to avoid further delay.
Yours faithfully,
UNITED NATIONS Public Information Office
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

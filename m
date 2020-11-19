Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E52B8BAC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Nov 2020 07:36:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02FA0100EBB82;
	Wed, 18 Nov 2020 22:36:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.255.40; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=galenobriax@hotmail.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-oln040092255040.outbound.protection.outlook.com [40.92.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F700100EBB81
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 22:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zomy6kpPXsaf0kd0z+N7F9Hc5j4GlUXJmKrEwYOQaK5ukBoqdJmL404tgOLGxAapoDvX2/HoWsWP4AJaRNibAVr4MKqRgWL3/hhdNYDbZsUBjKfAqVHpUtFWi2T4PNK4k0JlSDs8lV2nWDLi+EksKoeh0OextP93OZ3fy6jg8BWFOwKF++5Cre6Lp24ktmog7SStLMlFoD8//5BzdA4Y8YbU3INLj5E6raftpk72zGIhcQ+D7rcjkKuASVdjqVVcNDSK3o7OoYPw76GKNH25SG2PW5zSH0Kw1IQpVDo9Crl/WR6bKlvIdVpQXnBJqU7Pt7TMqmP1vAnbLh/iOQcveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9OC8X4/7LAXce54nYlQJY3O2ZLLDIXcOXS244pYlxE=;
 b=BhLaIR0aspNNql+FOARsL1fW25CC3d1RpYsJh18A0YY4qwAw5nAaJfZz1X8VJV3xvF/jvJGtJoZt/Be/7NsEluXrAMtZVn4AxXV2HsXOHNgPzwEHyyzWk7OFSCSwI+mUsWspN0Fx6yQSidZ1WksG2hosRdiKSzNVyeiGqGTbwrdKVeKTEos48M+uHXr6icLeH1IktKWDOIIF5iEHch9tiGb8FMn2Y8e87Krg0xe103cyqhVump+4fUTh8ZZXdFBO9wA3Zc07OXzWhgM69kVkjQpSb1/Arr5JQSEfwBA8yYhLBt1sjXimabjH3ydvxGQPxEOiM1PV7pYMt7kvDg2ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9OC8X4/7LAXce54nYlQJY3O2ZLLDIXcOXS244pYlxE=;
 b=GupdYAvh4TjGVHRZFGIPA0H3RE8le7fVbQjY0yMLTwj8mx3vRVZ3ea0AMBFdJkb1hR5BVOeH057BnnuwTPSsQwhmWwaRK0jwK3rq70ejMP7TLQw9K/ZPMSBNOLmd2RvB59j//OE3HSLLKd4tOrGOif5tT91nfEf3MlEnvStD6yU4lFR39bPJf5XFENwPh+EyESIGHrSi4htlNMKsYS2LxrMqU4wyU9WwlU8BN5aKHL+A3bsu88bFnGGYy52hz4HUZ6kSFC+hD1H4DnOhqUix5OFbwsQdiR43edYa1ywBWiCnGMkvCs1cx5gzFxzJTlkiTDaGm5zitQBrZ6d6OXCpOA==
Received: from HK2APC01FT060.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::47) by
 HK2APC01HT240.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::261)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 06:35:18 +0000
Received: from MEXPR01MB2198.ausprd01.prod.outlook.com (10.152.248.51) by
 HK2APC01FT060.mail.protection.outlook.com (10.152.249.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 06:35:18 +0000
Received: from MEXPR01MB2198.ausprd01.prod.outlook.com
 ([fe80::8586:c35c:11f5:16d2]) by MEXPR01MB2198.ausprd01.prod.outlook.com
 ([fe80::8586:c35c:11f5:16d2%11]) with mapi id 15.20.3589.020; Thu, 19 Nov
 2020 06:35:18 +0000
From: victor ubulbe <galenobriax@hotmail.com>
To: "aleck79564@126.com" <aleck79564@126.com>
Subject: =?gb2312?B?xrfWyrGj1qQus/a/7rGj1qQss/a/7r/sy9m7ttOtxPrAtMrUzeah8g==?=
Thread-Topic: 
 =?gb2312?B?xrfWyrGj1qQus/a/7rGj1qQss/a/7r/sy9m7ttOtxPrAtMrUzeah8g==?=
Thread-Index: AQHWvj4lI+QWea0/l0ClWfnYIFw2CQ==
Date: Thu, 19 Nov 2020 06:35:18 +0000
Message-ID: 
 <MEXPR01MB21981B4638C59740C70B8153A1E00@MEXPR01MB2198.ausprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:283B2B093866CF6A3F7AA998B7208ADEE84E36CDEACF2B73AB4D53889F24D8F0;UpperCasedChecksum:E42E5FC2299D8B3D96F2C4752816466CD407FF25B71F1BEA019706C119022F9B;SizeAsReceived:12648;Count:41
x-tmn: [qRJ1m4F9zU7afIZW4As44Z5lZSSpxFYJ]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6afc6e79-7fb5-4437-4410-08d88c554855
x-ms-exchange-slblob-mailprops: 
 =?gb2312?B?U2lQcm0vN29FU3lST1ZXcmNiUXU0c0V5SmZtb2FXUWhtWnUvQmhKdlpKSFdO?=
 =?gb2312?B?THZwQ1dZQUxvaTFrWjlaV2RQRUFSNkZKelBiRFhsU01kR2U4YnBmZGFpVmVZ?=
 =?gb2312?B?dmlGUFgxdC9GRXY5MnRldlp1Tm01ZzFoVjE3YzN5NytpakdEV2NqWUw4bldO?=
 =?gb2312?B?OWg2Tkc0K0hBaThTUEhVUlovTTF5R3hnTFFSWkEyUWdISnlTend0TnBrYitS?=
 =?gb2312?B?eTBOTHZYbUhONlV1RlJoYWI2VkNWSDlKbS9KN0RWNDNzQUpUcmxUd3BobFVu?=
 =?gb2312?B?MDM0VXJxY0U0cUVTOVJVSnFVT3M0TUhNc3ZaYU5qazc1ekhDOWtYbmZPY3U5?=
 =?gb2312?B?NWo2RDRZdzZjMmdTSmhiTHhhYklGdDJNbnFReWoxNFdhN0Q0YS9uRWZFcXhw?=
 =?gb2312?B?Q3JaVThkZjA2NFRwcFBMNEdOUVBSNGViR3NvaHBpaFN4TFMvZmdDRk1IcEsx?=
 =?gb2312?B?dEl0SGhhTExuaE1zZlpXU0k4M0pvK3dVUVB0VFpPcjlEaENKM3NnSnFWQXBK?=
 =?gb2312?B?eXlXbUZXcU93K1ZpV3FrOE5QbDgwQWQ5dktwR0p0eDVUdUtzVlVDN044NGUy?=
 =?gb2312?B?ZDI4RFJKcGN1eUF2QnlSenYwdVFMUDZWVFkyTGw4VUhzTjBzVGVNZWpsM2N0?=
 =?gb2312?B?QVgvRnlWbjd2eUs4dVpJeVhSbXhuQ2VxdnoxalQ5OFlTMU10Sjl5dzMyeWY3?=
 =?gb2312?B?SnJreGFRMjVXbXd2MVUvMkVMV1NiK285ODNEdjNabU9BdmJmWmJvZFR4UzYz?=
 =?gb2312?B?cXVpVG5hczliMWRrMlV6aTh0QklzQ0N5ZTh1YUo0WGJpdGtRTGF5Vm5Beldi?=
 =?gb2312?B?cEJOZC9PQWpHa3JQelZxL0V5akxZeHZyTHlKc1ZSdGJoZ0V6amNtRzZhNW80?=
 =?gb2312?B?VnRuSjlNOU5Wc3lIWFBmckoxTThyRXhjU2xnMVRlUjA0UzFvUHFxUTFuWHBz?=
 =?gb2312?B?eUFXSnEyeXVuYlYxZU5FY0VSUWhueUJWZEgzRVpNdUNFOFg0b3dnT2NLQzhS?=
 =?gb2312?B?Unc5MXl3LzJTaCtBcldDUG5oS3p1MnY2SGlQanJUVzJTdmd5cGFkSUpnM1Zv?=
 =?gb2312?B?V0dkSzQxQXhINDFNTVdFTHUrRHNTeEhMWHlPZzQ1dVp2QXptNWxrMjU2Zmhj?=
 =?gb2312?B?Y3ZucUdYTUN4WHBqV0RabUdHMFBSVkFBSFRzZUx2czNydmd5aXlZaXRaYzdy?=
 =?gb2312?B?QkFlc1VGL1N2NTV3cXdqelB6ODVvT3VjZmZiWUVKR0JTWks0VEtzZk50eSs3?=
 =?gb2312?B?OWJ4NVJlM3VEcnRydEpUVW1CWVdCR0J0WnV3dk5tNytwQ2xEem01QkwyTk1j?=
 =?gb2312?Q?0KCqnmPidtiJs=3D?=
x-ms-traffictypediagnostic: HK2APC01HT240:
x-ms-exchange-minimumurldomainage: 1ku111.com#369
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ap6jsZSFmCqMjTx3Qq0zFwPmfAYYRtsYnUi6ZGltKr9j2rT2XALtvNsHxjsJQAFtLbbf0aLUFw9o/GkwP0sQ6uHK9N9Ax3PFmRuBghmEk0SfJLte1zHYs8UzCWP7KkFdHWif9xpXMmBdKP0IQsMYN5cx5x+spUKtTwF/ToWSxEKSHOK0lXWGHb0H9JgbFB3iBKJ8cLlweOdj4ok7D3NEb0zFeC1A1NvP+wVBYl8Pp+0Nycq7wB50ypA+/IbJSkLU
x-ms-exchange-antispam-messagedata: 
 MaEHEx91h0CUOqI6nwsqObee43IShu+Z0MNm7mA7tuRYvLJV8EH2+d1zn618C7RzHcqOWeMXSOyyl67QyI0ktcA3ED+UrB1wVOo41pv3GaRbjDBj+UQUQdQJEbAdASMi6AnVIm0AtY92WZmbfHGU+w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT060.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afc6e79-7fb5-4437-4410-08d88c554855
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 06:35:18.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT240
Message-ID-Hash: 7MCH44AAH37IO3MEIORN3UICSSH72KMK
X-Message-ID-Hash: 7MCH44AAH37IO3MEIORN3UICSSH72KMK
X-MailFrom: galenobriax@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YENQPUKTV5E7E4TNDAEFAPVSYOK6KTX7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============2618674118041531006=="

--===============2618674118041531006==
Content-Language: zh-TW
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

xPq6w6iQqJCokCHO0sPHysdrddPpwNYuztLDx9X7us/L+dPQ0+nA1s34087Pty7Iw8T6ssa4u76h
1NrK1tbQLs/fyc+zrLn9sNnN8sjLxePE+tK7xvDN5s/tytzX7tXmyrW1xNXmyMu21NW9LrDZvNLA
1i7Az7uiu/ouzOXT/bLKxrEuuPfW1sqxyrGyyrXI087Pt7a809Aszea80tPrzea80tauvOS1xLbU
vvYuyKvKwL3n1+7XqNK1tcTT6cDWxr3MqNau0rvWu9KqxPrT0LG4tvjAtL7Nv8nS1ML61Ni2+Lnp
Ls7Sw8fKx9X9uea+rdOqtcTT6cDWzcW20y6okLGj1qS1vb/uu/DL2bW9v+4uxPrP67Tyt6LKsbzk
Ls/7x7LKsbzkLtfc09DE48/r0qq1xNPpwNYu16Ky4dPQ08W73brswPsu0vLOqrPP0MXL+dLUztLD
x2t10+nA1sTc1NrIq8fyzfjC59Taz9/M5dP9zbbXosa9zKjW0NOutcOzz9DFv8m/v7XEw8DT/iEg
1NrP38zl0/2+urLKzfgs1+680cqxyrGyysa9zKgstPPA1s241KSy4iws1ebIy7DZvNIstcLW3cbL
v8ssIDI4uNwsqJDC6b2r087PtyzFo8Wj087Ptyy2t7XY1vfTrs/WvfC1yLbg1tbG5cXG087PtyzA
z7uiu/ostefX09POz7e2vNPQIbP2v+7L2bbI1+6/7DW31tbTo6y2+MfSu7nM4bmps6y437XExeLC
yiDGt9bKsaPWpC6z9r/usaPWpCyz9r/uv+zL2bu2063E+sC0ytTN5iGokKiQqJCokKiQyOfS1MnP
way9087et6i08r+qo6wgx+u4tNbG0tTPws341re1veSvwMDG99bQtPK/qjpodHRwczovLzByei50
dy9LM0NxbjxodHRwczovL3d3dy4xa3UxMTEuY29tPg0KPGh0dHBzOi8vd3d3LjFrdTExMS5jb20+
DQoNCmt10+nA1rXHyOvXqNPDzfjWt2h0dHBzOi8vMHJ6LnR3L0szQ3FuPGh0dHBzOi8vd3d3LjFr
dTExMS5jb20+DQo=

--===============2618674118041531006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============2618674118041531006==--

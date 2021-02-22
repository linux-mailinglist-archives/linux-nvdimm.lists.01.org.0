Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118A321112
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 08:00:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A0DC100EBBC1;
	Sun, 21 Feb 2021 23:00:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.152.246; helo=esa2.fujitsucc.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B6FD100EBBB9
	for <linux-nvdimm@lists.01.org>; Sun, 21 Feb 2021 23:00:41 -0800 (PST)
IronPort-SDR: E6b7/JUIWUkmnKGZqHVEmc8E3KKfq44q/1xgLLeuht1Ekm8i0Evgo0JipkuMr4ZXY943deUZTm
 NFurnw/lpCTgfdnT1nE6cQDbc3LLCNDKcNk2NBcmGF/cxRd259A+ZBRAl+kIelN+IfxB4Vq+wP
 NvhPsbE/Pl/qkA/zrl5WsiHf5ZG8xMhHFmtvIBv2TOzDm5C+n1oXQfmJpCw9OEnk/Un9+z8tfz
 4uqS20LxBTL/vKEmunyX17pCEsHSFegPuDntF4rgLTU8Bum8zSy56j3v4Nq/dKIVRCvYgdef5z
 o0g=
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="34755932"
X-IronPort-AV: E=Sophos;i="5.81,196,1610377200";
   d="scan'208";a="34755932"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 16:00:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4n8TtkaAsgmsoM0pZKNZFV234BjZ8aA18FLklcb8IdmAtlyv4q1aOnAUpbSWK2fZ7wxMbiSelAf6lZ2jr3Q6aeNFC7ro2dlve8TFPqjIIgNyXjzBqInTydtt6ApSsBxTiEFaXzbfBwTh3qrkGGVXzXWrU5OM1nfDuQ48u/iwu7fDWJCAbtgaC1mAxuaCnTfwA9cnAbOScUee5r4LB6qWoE4haXIhbtR+uU4j7G1obuZekaVby8S5QUap2ltvVbQdGt12nFJN/OVE3AXRs+pf74I/jiuJQIjY2i3MGlIUp2VCePbHnY8Td2IrI/BUW9yamUzetppRqjGfjHzQh/nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT+VQNBoeoaMnx8uuFkylvA2cGv1XcIoAiDOVyJhy2k=;
 b=f/65fpM36zkt6ogEI18+PW4qfxQZ/4W6PSABcP0+shQluDSPZyfHB1DI9EzPvNWOqLbuWBDdcZgxHxWwdy6coQBELFzVVaGxewwGjZoxShC0vaI/qHOPKty8ILxIiUDo7DljhbwyQRdCX/KQYpUM7/pITGYvqrxZ/06xdQI9pT8UevSZbOECpvZDUU+xO6RkYuhlYuWfUxUCHsw5DC0zzb2LypRgmlOWFjOBEajcDNrkWPYgACUYdTxvVsqHkgRikf74P8vdBXWXttPLXscJ82hQ5dZS7rJfXQ8nZI8RPxhouVV/6zzDEpeCxyFjyve1ShUJdFfSPCAAr/J0SHRJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT+VQNBoeoaMnx8uuFkylvA2cGv1XcIoAiDOVyJhy2k=;
 b=g+F1jO6u7UCsH1BBm8P02M87eYkH4xjfnMDH17hUKdocbGIn1xbb76KmITWsdpF9jnjE32SVHk8tc7NW/KZ+AZaoGUricTOHZGXiTcwcpUvUeLLLTgWcOquEU+QMRY1LF1R9bvcCnT9zzByIcTgIteDZuHAOXFtvM1WUSfvtro4=
Received: from TY2PR01MB3660.jpnprd01.prod.outlook.com (2603:1096:404:d2::20)
 by TYAPR01MB3359.jpnprd01.prod.outlook.com (2603:1096:404:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 07:00:37 +0000
Received: from TY2PR01MB3660.jpnprd01.prod.outlook.com
 ([fe80::e581:8b94:a754:1169]) by TY2PR01MB3660.jpnprd01.prod.outlook.com
 ([fe80::e581:8b94:a754:1169%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 07:00:37 +0000
From: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH] ndctl: update .gitignore
Thread-Topic: [ndctl PATCH] ndctl: update .gitignore
Thread-Index: AQHW+WOj0AcKehXnKUadgI8SHlb8WKpj3e9w
Date: Mon, 22 Feb 2021 07:00:37 +0000
Message-ID: 
 <TY2PR01MB366097FA6896C6F0A505E415F7819@TY2PR01MB3660.jpnprd01.prod.outlook.com>
References: <20210202130206.3761-1-qi.fuli@fujitsu.com>
In-Reply-To: <20210202130206.3761-1-qi.fuli@fujitsu.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe06d771-e916-4491-537b-08d8d6ff8ee1
x-ms-traffictypediagnostic: TYAPR01MB3359:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3359B5C3599AA0AF69018B30F7819@TYAPR01MB3359.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cJe0ee7KFl+O3mdk5EA/G407r1+fGo2tZ7NaAJLg64cizf/GM2NAtz8wJM3bzMIceT5Z3iZNx97vKEjggMJNjht5oJSf1rqbUSfwn6CFpxx8wcn5thizLb3TzKNm6v33+YiSzakT7+QNvxFVl15t66EZayveEQT0vLNi3o/+yh3mJH1B1UsIXyVcRCqmBnwlnBoMdC450ANmf6kpQ9+N7zMWatMcKxKmjBKF+ptbQxTMPbLv8wsQX7ipxwGXebqc73sthLdIs19/HAtKo7hhzqKJKsbcFEIMIqzHmz0tPmWMf++pFt9gMR+xKMBn5OJgcVjrqAn5werhjLMs1oWz3pEDM25WY+5aBiAR2tblQmxCVXZvRe4PAOziBDeC0J051AGNzk+px5OiZzaAmcStaqjFP0pHdHHCtaTnJD/+eKoLkjd+C+nKh1Y0tu2dtdRlcoca8TUu4GSoeE3O74WkmJp5Q37aMl1/LcEedcegBpV3elavWUO4RpXqVZi94zzPbx0da9Xds3tQUxY6pB6tmonNbiaGF1oYP+AxmXqtAsQ6DYrbsiTYib/mAEmG+dPG
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3660.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(8676002)(55016002)(76116006)(83380400001)(2906002)(6506007)(5660300002)(53546011)(478600001)(64756008)(316002)(9686003)(66476007)(8936002)(186003)(66446008)(7696005)(66556008)(15650500001)(86362001)(85182001)(33656002)(71200400001)(26005)(66946007)(6916009)(52536014)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?bmFLVDYvN0xTZnV6MGJIdzZwa2hiL0xkSGpJaXhJLzJiMHFvRCs5aVdo?=
 =?iso-2022-jp?B?RnBSTm5rVGxZM2lVVDYxQ2s0bnhxNDZEclZMa2tWcSt3YnJneElJNGho?=
 =?iso-2022-jp?B?bDljNGFGOVVjUUxBUWxsaXRJMUoxNk56eWdYbjZjTTFTZThxMEhGT1Jn?=
 =?iso-2022-jp?B?U2V6ZU9UTjdrUnc0YmlIYjJEcUxnRTR1OENNQlgydEhBWGZmREVubkdj?=
 =?iso-2022-jp?B?WklCSDcwdFZuZ1BKazBQY3hxelJja2FhTkUyNDZUVGh5M3plTnlMWmY0?=
 =?iso-2022-jp?B?dHRRVHd2NEluTjNmRkFaemJSSVR2TVF6NGg5aisvSkVqUEVxeGNmL2dh?=
 =?iso-2022-jp?B?ak5KSEtac2NFNVpOdURzczNIbExiQURxK2graWxUUEpSRngyc053OXdm?=
 =?iso-2022-jp?B?ZDFNdVpLMEFFNzVYSWFVc3FxMEZtWDU1ZzJ0a3FOemZGUFhkL3VTdEhB?=
 =?iso-2022-jp?B?L3dORndJdDNLeUpPWTgrQS9Ca1VLMnh5NUJLN1BFNkxKWEU2VVRUN2NR?=
 =?iso-2022-jp?B?MjBOSC92ZktwdElxQzBYVFh2SGZOYllVQXdKNGJSRkFwS3ZYQVZuTmhR?=
 =?iso-2022-jp?B?eWVUOFZpNnB0UE1aN2FiYWNBc2RSL1ZXUTlydHJsU2FEVzZzUldzYmMv?=
 =?iso-2022-jp?B?WXlINzZ6TlNFR1Eydkk3b1YvbytocFNCa0xEQlljMndWc3N2eDcwaWV3?=
 =?iso-2022-jp?B?NTVIQzVqNi9jWnNaZTJZMFFycVU1Ykt0QkkvVmt2bnNaMGlXbG1MSlNN?=
 =?iso-2022-jp?B?MTI0UFhDaEYzRGVZQkdENjQ4a0JRRHBNUTlMaDcvRlI2c05JVGNoR1JX?=
 =?iso-2022-jp?B?V1lkVjdTZVdibzFBVHg3blVyeXBZdGVWdzN5cWF5ZkJ3WEJGVGU0OWRP?=
 =?iso-2022-jp?B?YWRvcDI4aEp2NGJBSXZWTzdTK2NPd1VxdTFud0tJOGtVNU1MOTNMcmNh?=
 =?iso-2022-jp?B?ZzYyaTJDVDNvb2JlQTM4NjRHZFQ4dkZFWHB3MndiL1ltaVIvUmlaMWdS?=
 =?iso-2022-jp?B?WDg0NGZsc1FUVDlHdmtRLzM0L0U0Z2NLU0xRTVZoa1ZMeUpiVzNZUXZy?=
 =?iso-2022-jp?B?OTNkeHNtVTcwMG5GWHdqeTBUUHcxbnAyWG53ZnZTNkdtaXNvNDVLRENv?=
 =?iso-2022-jp?B?SmFCUzhLczJhNzB3OHExbXhPdFdqeFBiSUJueVVTc0FGUzhGMDdPZWNt?=
 =?iso-2022-jp?B?ZGJuMUROckc5bWJoZTYrbk5LSWIxekJwK0N4OHJnbmJ1Q0hzWjB6WStx?=
 =?iso-2022-jp?B?MG9mWjY3N0xSZWdOb2JubGlWN3l2TmtoSXN3eXRsdjUwU1praFJDRm16?=
 =?iso-2022-jp?B?bGlmY2VDRjFvYWpOd2d0Y0t4RFpxS1BvaEhXbHBPZG8rNE9HTlJ1SG1Q?=
 =?iso-2022-jp?B?VDd0VVRYRWYrajQ1OFFlUlhTaW9BOU8vdmtENjNLVkt3WEtHcWFQV1U4?=
 =?iso-2022-jp?B?OFY2QlBGZFNQU2lDQmxRL3JuNkxSV1MxRGJTYm5IYmtZZEtiL3FrSzJE?=
 =?iso-2022-jp?B?b1JadFk3djdHR0RTRlZSS0gzcE8xaERPN1VzMDN3bW1tWFEyZjlDTXFH?=
 =?iso-2022-jp?B?T1Q5eU84Umw5dDZZRy9qZTF3UGNDWjdzSkVaWnpNZHYzUlBKUzhWd1ZR?=
 =?iso-2022-jp?B?TndiNDJuSjNUZ3dHQ0JjOE1GamU5UHZaUE9oM2xxSHZJZEN6MGFtazB2?=
 =?iso-2022-jp?B?cWRXeHZrUkdCSlpueXVBMDVPTnBGdFN3MFRLYXZGeG8wUy9rTktSMzZq?=
 =?iso-2022-jp?B?TEtZWlNjQTVDbFVqazNYemg4c2NnLzgrVDM0Yys3M3ZUb2VTNHB2YURW?=
 =?iso-2022-jp?B?OW5vT3Bva2VYdWNEbkpkc09yV2RxaW4yYXpBWGJ5akVHTzFQRVdxWnN2?=
 =?iso-2022-jp?B?eDRvR0x5VFBSelI0MnYrUFZ5TTF4Q1VYNEhocmtvU2QvMnozd25hWDBB?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3660.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe06d771-e916-4491-537b-08d8d6ff8ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 07:00:37.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFFO8y2HbiKSssynu0kPzEebJoYWpK9eRw89i1snNbeuMFBFePM/Ivq0pc4CuS+3/gWIoCmmwVO4dvKbcvjV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3359
Message-ID-Hash: SCV4QSLGK2MESEHDKAX3QSXWT4RMRFGE
X-Message-ID-Hash: SCV4QSLGK2MESEHDKAX3QSXWT4RMRFGE
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V5UEVUUJXDHJNJQRDMW4XQFB5RGRDUIS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ping

> -----Original Message-----
> From: QI Fuli <qi.fuli@fujitsu.com>
> Sent: Tuesday, February 2, 2021 10:02 PM
> To: linux-nvdimm@lists.01.org
> Cc: QI Fuli <qi.fuli@fujitsu.com>
> Subject: [ndctl PATCH] ndctl: update .gitignore
> 
> Add Documentation/ndctl/attrs.adoc and *.lo to .gitignore.
> 
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>  .gitignore | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 3ef9ff7..53512b2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,4 +1,5 @@
>  *.o
> +*.lo
>  *.xml
>  .deps/
>  .libs/
> @@ -15,13 +16,13 @@ Makefile.in
>  *.1
>  Documentation/daxctl/asciidoc.conf
>  Documentation/ndctl/asciidoc.conf
> +Documentation/ndctl/attrs.adoc
>  Documentation/daxctl/asciidoctor-extensions.rb
>  Documentation/ndctl/asciidoctor-extensions.rb
>  .dirstamp
>  daxctl/config.h
>  daxctl/daxctl
>  daxctl/lib/libdaxctl.la
> -daxctl/lib/libdaxctl.lo
>  daxctl/lib/libdaxctl.pc
>  *.a
>  ndctl/config.h
> @@ -29,8 +30,6 @@ ndctl/lib/libndctl.pc
>  ndctl/ndctl
>  rhel/
>  sles/ndctl.spec
> -util/log.lo
> -util/sysfs.lo
>  version.m4
>  *.swp
>  cscope.files
> --
> 2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

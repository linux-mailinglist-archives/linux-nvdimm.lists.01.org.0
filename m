Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3D263513
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Sep 2020 19:55:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BE2813D0B6C7;
	Wed,  9 Sep 2020 10:55:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.18.26; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=will.jonson22085@outlook.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2026.outbound.protection.outlook.com [40.92.18.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2BF013D0B6C6
	for <linux-nvdimm@lists.01.org>; Wed,  9 Sep 2020 10:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOzNPUwOqPwkp6iPqEmsRjlCD+Dti4RHtxw50RW3mGaBM/Si2Rgs+cTuBHvKs7RNKZK3t1RegAXRqtMcvadtq+9hqsCB+ncN2Ikj0efJLo7IwNvaJFdUA5XqLAF2J4jsPrJyiZ/kdzP1/mW7C8teN0sgO9p5+YzP/NdCqzDqVUYDJLFUIXq2k+SbaLrewCm/0IEMIgrJf5yScnQ3qweoOudSFzzP9v0m1GrKQCE3scsYi4fkNO42OkYKR79NEmfk6a1fSWcdjzXMq5243t+zGVFy3vX6xOKxTGBVwlmV5O+CW4js1Zgsm8cbjLKlY37VI0tkjK/BCfIRHfP30b9lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN0KKjBv2TyXDs4wzxpOy2JCLOwG9U6LlSUzZC5Ie80=;
 b=oTpOTDkghra/ZGOKO2LzPI4qOUZMODK88ih915QeTRvWGCZ+681LgOEqVzJi3A5DsPtK/+tTkp/dWSGhUQqI9ioUlKvsRNbkEWQ5ClQ5TgD2Xn/G1EDdQ6d6iyYujXT0bee45SN0i66OaDC53BGeXNvrRFDIg84VuvXxjFFYp/HzNeGtLcBxbMkoTLm02Fj7q2+1PW1oC7NyOjsPUG21b3MC9TsgtwyvHJfBiRNUuZTArRhwJosCtC1CWwG3qOBFNcF6djnw86FPSV+ONbhhDDv6V9O5affFG2Yh+7ORnDP2UtIphTBX7XI3n9pTDaHdCXlpwJXs3I/7GNVloc+zzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN0KKjBv2TyXDs4wzxpOy2JCLOwG9U6LlSUzZC5Ie80=;
 b=oBb9nIvHDrWmP2ltQKUHFN9qaf7VzsWj4Nzqg2T3+tK/w0NCuLQ2rdUlHuhCYqZsUqXPQIOMOBPhHQZV0c2xqUTMzVxMg40GMI2DHjMBjxE++bh5L1rwVcU2vm4XGh0etNIKJ1MELAyMUdM0dTTFvvPEYciXRxdEEIRFqsoL8ltOU8WzRz6XAskGvdO748UhseAXu6wBtxNJyir0QN89QzqJd2mluK9F04EHEY5p9tsttK8WzxvNtEb7fi2F4CQZDCYNRx/ZftiWuG0vprTS7xKtd6ntbEWJGCV5AV03+nJlybcx6Onj+KkwrK7F43aKC3aOfW+sxwrJA1yJO9E3BQ==
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::53) by
 CO1NAM11HT204.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::106)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 9 Sep
 2020 17:55:23 +0000
Received: from BYAPR02MB3959.namprd02.prod.outlook.com
 (2a01:111:e400:3861::4d) by CO1NAM11FT019.mail.protection.outlook.com
 (2a01:111:e400:3861::313) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 17:55:23 +0000
Received: from BYAPR02MB3959.namprd02.prod.outlook.com
 ([fe80::b852:6526:4c3a:96c2]) by BYAPR02MB3959.namprd02.prod.outlook.com
 ([fe80::b852:6526:4c3a:96c2%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 17:55:23 +0000
From: will jonson <will.jonson22085@outlook.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Obstetrician-Gynecologist Contact Details
Thread-Topic: Obstetrician-Gynecologist Contact Details
Thread-Index: AdaGxAodH7Fhv9a2SZmc4/G7Rt9aVg==
Date: Wed, 9 Sep 2020 17:55:23 +0000
Message-ID: 
 <BYAPR02MB3959E8A038FCAA07BCAC4114C8260@BYAPR02MB3959.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:9E1C28BBDB9EDA4FA15723A64D059BAEE6625B01F6F92392A9B89E581FC21C81;UpperCasedChecksum:D4DE548767AEC10207FC1BB7556E94494CBFB756605846165E60B4E4E523438B;SizeAsReceived:7045;Count:44
x-tmn: [JhP3nWi/Ajp30C8xfJNARUpN0It9SxGAnnF4lBSd0c1qjUUDIgLVcqe3asy3EuUT]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a83abcaa-e3ed-4a76-73c1-08d854e986be
x-ms-traffictypediagnostic: CO1NAM11HT204:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rnRXhe7Xpn4z6l7PTikzPAKy94hfDoZP/VoOROO21nDHr9Rwiqm9XmgmEju45XIAXLTtH3MT8oemREe+r/Tnu82SzBti0JREE1XVoQKMxdXxKH46kvtNOV0Gg3N3sV4RLSUgsj60ZOLBgGZKV4n2WKaueJ+qIdDkFKy7OdtDbFZ2Zlq5akO+fRTbHn7KCHnH87q59OVfDrze3rnXYTqqKw==
x-ms-exchange-antispam-messagedata: 
 aIUDqlnXs9YMq9B+UVd4kWdfPA9pmXxSReLpJr8QHu/ocszr7OdC3lLpJzndqviuHGHqmzYEFPrvu/sf1LR3Ac3hZvUsObvsuoKlESgAR0FQ7wMZie4e3RGxJrQ561idwWewNIE5s9DjWGllQ6KuRDVmOZLA1fqCC8CJoa4b1XU8ieQpXMV0OMCd0SC9v+o4/+e9CRvmUuXGu/8BQSJsPw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a83abcaa-e3ed-4a76-73c1-08d854e986be
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 17:55:23.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT204
Message-ID-Hash: POOXLR7S3IJ46QRWDRTO75RY3ASFHY2W
X-Message-ID-Hash: POOXLR7S3IJ46QRWDRTO75RY3ASFHY2W
X-MailFrom: will.jonson22085@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BPMLNMAUTGWOUTSDZE4IU4LQL2TSUQY3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi,



I wanted to check if you'd be interested in acquiring Obstetrician-Gynecologist Contact List for your sales and marketing initiatives?



Note: We can help customize the lists for any specific requirement based on your criteria.



Please send me your target geographical location, so that I can send you the available counts and pricing for your review.



Regards,

Will Jonson

Sr. Marketing Manager



If you do not wish to receive further emails, please respond with "Opt Out" in subject line.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

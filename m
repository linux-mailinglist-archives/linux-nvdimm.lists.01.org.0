Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6B376B48
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 22:48:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10A17100EAB7E;
	Fri,  7 May 2021 13:48:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.16.24; helo=eur06-am7-obe.outbound.protection.outlook.com; envelope-from=ddddssad@outlook.com; receiver=<UNKNOWN> 
Received: from EUR06-AM7-obe.outbound.protection.outlook.com (mail-am7eur06olkn2024.outbound.protection.outlook.com [40.92.16.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27B10100EAB77;
	Fri,  7 May 2021 13:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpVWGQmf6I1uIGRsj6i4Q8DDLrQ41qmvSVnGwxzD3Br2IZAldn0OXJOaI7gSllx8dPjU0hO/GkgrrAF8e6H6P1skwmX2QT6XU2HWoL18mjBGpg37QW9fsoVEF8KEjSChtJUY8IecmeyMLsq4gKCgMifKS2FHIB39BpI6nqXYWCq7GDolwb/GYl2pJcAGOD+IuDJVkkiHcTp7MMGAiaW7+QByvj0wmsbSGfMl4c5Xv9zcEnGXGQaRD6hau7x0dGxdIo7eOQajncojqH+5ibZ8K8DApjTB0jf6TPR4agfjSVW288Hos/Drhe2WPWCzIZCIZQaFIxfDLw/guxeRh2y6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FH/cNJqT8tStW+cZsYuOwLWJ4qv3ZpW4YgzLLHUA/U=;
 b=ghbWvMH0N97nHgc496YQSjO/t+YRm7DnqrjBMfR9kvFreUBnj6aRLbc8e663eZNNAsLFxb/gU6SvV5xn+guYkadb4SBliaY46ACFB1F0QI7chKb1Inr79aypp+8BR5vJpQ2B9giUqhG/VCswXg+JHhy/5/YhdulOeR6kuQepuoCdEw9Z5M6hNFHquBRhhc+KZwGYNmpjukQhyWftEWibAY4pQ+ouu6rpXCRs8EjMnjGi/ugzXy8h4ZxTNBjcFBQF/42gaDSwvKwkbu4cGdQq1zpWTexXDaVupufSFjxkpdPhPY0vOVceBl76+1hvC/ssJMLmGvWeAqK++S0EtZny4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FH/cNJqT8tStW+cZsYuOwLWJ4qv3ZpW4YgzLLHUA/U=;
 b=Co3/RjSLeZ5m/95sJ7nmfozOM5oKYgdgLgfqRqe4vLjgHbBRwDKEkYUfrwecX7urCWG1ZSCI86BUQBfcMbipbnoKDPOnt17lxDt68O50nc4tw3DT5LqIzdnc1TB9eb55AfNEn7cXH2URnJIVZ/c3PyNcSQa5MK7SwlO33lAqPQSQR2VufKN/tFtr4kqzaTmlRum//nVRGToGUcyFHHAx5Kci4u7R6c+bHOLqPtqx2Aspf8QXIAHLsfetQGU/Qy5BgarvDBF88YG97P2CFLoQl3wRHdAyo400u0yPbo7QpM2jhprRjvc3nNxLiFwMDHZVrXQrMoCZRSFb/+Hno4WzSg==
Received: from DB8EUR06FT059.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::51) by
 DB8EUR06HT166.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 20:47:45 +0000
Received: from AM0PR02MB3601.eurprd02.prod.outlook.com
 (2a01:111:e400:fc35::4a) by DB8EUR06FT059.mail.protection.outlook.com
 (2a01:111:e400:fc35::333) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 20:47:45 +0000
Received: from AM0PR02MB3601.eurprd02.prod.outlook.com
 ([fe80::b481:2bcb:ee90:21bc]) by AM0PR02MB3601.eurprd02.prod.outlook.com
 ([fe80::b481:2bcb:ee90:21bc%3]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 20:47:44 +0000
From: aaa aaa <ddddssad@outlook.com>
Subject: THANKS!
Thread-Topic: THANKS!
Thread-Index: AQHXQ4IX0yvGmyPl4UC4KR2L200BHg==
Date: Fri, 7 May 2021 20:47:44 +0000
Message-ID: 
 <AM0PR02MB3601D3CF3EBD397CF7C3F56FD9579@AM0PR02MB3601.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:8C68F4B3F2A68A4FC5336DFC70D509F048F68D19A44A42BD7D64CA5EFCC9F6B8;UpperCasedChecksum:6FA7CD35812C65DB73291E8D74391B8D5F75681D3F308F3BC87D82DA427E2BCA;SizeAsReceived:33930;Count:40
x-tmn: [f/cTLu3pUcL33jUNX76LRv/qLsFg/8gD]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 184f76bd-87f0-4695-79ac-08d911995da6
x-ms-exchange-slblob-mailprops: 
 BBDuhOFk7KB6PrmFdLHISg5JKjPtlWYE/IKJqmEJq8e1+usCN2vYqhG7EUVqxj8D12rJgsixrikZpTBW6QVQ151ExuTOJs2tDeUhX6Py/367DWx6k/9zceS+Uj01H9AGV90APRFoTVOk7hTi40zA2cqsUy7UQA9a+OINkvBWX2plQRJVOCeJjTbS3b5rvTCcLMKBvXNT+cv0KxiyBrnVYKK80YegniFm1sfZvYi5rDjCgUOV2snWL0wSoBgsyuzoVa0fXGJ3rnczxrBaKHqBLQ51f74M42316jfFnHNh5nTiAOWBLgP1kvKUQPjHRqtxC0w4MbgPYQdTPJXeS/tvxLZpKYY62UF+tyaGeNu0kl915yNq7n8m9nrXs7iK4ZCYfUT/2MRuWsMtt9oz4poXKbA/8k6X0+WY6Ed3J75fdkN7Kk1BD4hJHIwsANd0f4OmsyOCwdRQFEeqfd0DXbj/RckyzZsUIMi3b5N7+kW06aFjxqFIT/ChZ4r52V/BD7wZegcET5EvXyB05hKJMLdN1LszzYKk2pWecCH/1ibHgDxdSj5wA3e5RKAioS1XRYLClAIv5X2zJkl4Rqofngmd50HX6leu0oC07erMDb0n+dkYp3bZcUZ2MyekUWAK5Qd+uUjA3NH/yOqcMRTkbMBik82KRA7GdqBSRFpL+XeZY64=
x-ms-traffictypediagnostic: DB8EUR06HT166:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IAWGgLGzYriSZKK/Nu9j3CZ6cdhHY4U64OZaUAkXoSc+NlQkbyZS3etJdAhbcSAaxtEai9Aa3DXz8ZN5u78BwlykFOTZEX8gQjp1//mDoVh1uVBIEXL5xAI3HQVDgW+29mN03m+wfeL2TnKVmhOVZrj2xhbmvN52seQ9fRBu8O5BRWJsbT/sC8HgARunESpS3HPO5ImXUKF2FHgd8574jSFzAk0Ecj+qWkF5k7KqlVwqZkmQtB1Lq69r59jBCtv5F90uojhC9fmrt7mnhU2DHJu7qTYUAIzDgnF3CETsAQEk9JwHiXeECJHE05nbVbXApJcs4su4j5FiX2x3uDqwfPlDcbBxygrMPPbGeeDBqfn48GZK7EtogkbQMUxPUciTbXUkPaLF4X1DxMewmtYVwQ==
x-ms-exchange-antispam-messagedata: 
 QpmZ51RHTGWUFOu2tj/XeapPWcqOm9D19tWJqRx8FR5GuMDukY+wnD5ZXgivF7rPr7DQGUHsdxsX2LVvFMJnKv3VHuF++C8YwiwmLSlHzmOpg8hnyOHoenX2Xwn1NhzhPoGZsGggiR7MJvyPH59KDQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT059.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 184f76bd-87f0-4695-79ac-08d911995da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 20:47:44.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT166
Message-ID-Hash: LGTNGG6CBZAYVBYWIMYTQVFNPNNFM3YH
X-Message-ID-Hash: LGTNGG6CBZAYVBYWIMYTQVFNPNNFM3YH
X-MailFrom: ddddssad@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CD3HI3MUTUP7GAH2EKSV3Y6ASXKAL6UW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Email:Ahpeiyassin@gmail.com



Dearest Friend,



I am Mrs. Ah-Pei Yassin. A dual France and Saudi Arabic National, I decided to donate part of what I have to you for investment towards the good work of charity organization, and also to help the motherless and the less privileged ones and to carry out a charitable works in
your Country and around the World on my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and some months now and quite obvious that I have few days to live, and I am a Widow no child; I decided to will/donate the sum of $7.8 million to you for the good work of God, and also to help the motherless and less privilege and also forth assistance of the widows. At the moment I cannot take any telephone calls right now due to the fact that my relatives (that have squandered the funds for this purpose before) are round me and my health status also. I have adjusted my will and my
Bank  is  aware.

I have willed those properties to you by quoting my Personal File Routing and Account Information. And I have also notified the bank that I am willing that properties to you for a good, effective and prudent work. It is right to say that I have been directed to do this
by God. I will be going in for a surgery soon and I want to make sure
that I make this donation before undergoing this surgery.

I will need your support to make this dream come through, could  you let  me know your interest to enable me give you further information. And I hereby advice to contact me by this email address : Ahpeiyassi@gmail.com

Thanks
Ah-Pei Yassin

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

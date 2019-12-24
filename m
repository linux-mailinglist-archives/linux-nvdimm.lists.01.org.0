Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE912A4CE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Dec 2019 01:00:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 15BDB1011367C;
	Tue, 24 Dec 2019 16:03:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.74.69; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=miran20089@hotmail.com; receiver=<UNKNOWN> 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074069.outbound.protection.outlook.com [40.92.74.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C582910113672
	for <linux-nvdimm@lists.01.org>; Tue, 24 Dec 2019 16:03:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYPY8ydAIRpW3jdCFunWMOD+TBaHvUeHPKDpvV33RwyOW/8v9Bgm9In4jzf5zQayFenhxFpgRCvuL7V8ZpFzp2JXoUuoDR2caKC2SxqSzgoTzozW5tOQdVJFVV9FqrIUiC/l3Eo7e7Dhqh/NlR0wm32KIcNqKqH2yiwTJHl1deYL+wT83g6mvToYriKuzMIUttpd6Wucd+acLrsEtDzuKEJpon8AoeImYYeObGjH3lxAJzpv4hMgdXRtodLH2pYjewNmPgRFN7IUaHlBqyIFkHgWn4PYjNbI2hRtd8hjC16phSvDopwmSgDTHZqjvIZqLn8pxaJYSP0LZV9WYdycog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSKhh7ABcbS5cm24y6xFfDWnd1Zg3rm0Nxz3CDCsK2o=;
 b=aD+ncutGVUaEEZrYMrF2Y72PCaNU1A4G+0duknhfTIy+A7yZvYvH37PJLgZb2y0P5sDUjFatIE3ez4HS24mCc1zSkiG0VFiq8Rvi+LHIhOfd5VDRBjGeuOXMz4cfxEVj9JgIb3VQAGFOwKo1k2o2zuqViF660C5PiZOp3FAYqX8RT6APHGHA1NFAym7kiCw2BT1SiXPOYJNw2VfmImb8661LgFSX0TJiRJkUigRar96dLbueEm29/KCY3uhNpB6OHVIQKEQfStDgL7IWIeMAmsmYVvXOtl6JVUbomrYIs+AQzIzjH/zbUJ7qBg+T0AfJB7ARfuTjOnC6pklJ9/u6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSKhh7ABcbS5cm24y6xFfDWnd1Zg3rm0Nxz3CDCsK2o=;
 b=SdA8nHfBHu7+ZJbPhSFAFuKEZ3VIFc8BfPbAECywpyvcfR9HXNS0hP8Q6Dzu/uYQxNBwVFLDxZp3MzJSKYNaOhDrjSfsW8rJKIpxLJOkzFv+gh557mLCELZMOdYwnrcNiOY1/D/snayPTp9MblSVA1GQ+PWAZt3YVs7ATyIZpNkSrYyKv1oFGgMPERKmCuMLPp7PojdAYmW3GHsdIe8eCl7RCut/OgmS6DsGtSowYTKxTAeLMLh40/UQYJPdQI4YphkgZAgfDqyDMen21ieKTQIHIEmtHTEJQ0gCwP/ZR6Jce8y1UbTBUSefcOms2Lib1L3Zo0F2r4Tdhj7scHFxuw==
Received: from DB3EUR04FT035.eop-eur04.prod.protection.outlook.com
 (10.152.24.51) by DB3EUR04HT085.eop-eur04.prod.protection.outlook.com
 (10.152.24.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Tue, 24 Dec
 2019 23:59:56 +0000
Received: from AM6PR07MB4008.eurprd07.prod.outlook.com (10.152.24.53) by
 DB3EUR04FT035.mail.protection.outlook.com (10.152.24.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Tue, 24 Dec 2019 23:59:56 +0000
Received: from AM6PR07MB4008.eurprd07.prod.outlook.com
 ([fe80::fdaa:780:ae36:1ac3]) by AM6PR07MB4008.eurprd07.prod.outlook.com
 ([fe80::fdaa:780:ae36:1ac3%7]) with mapi id 15.20.2581.007; Tue, 24 Dec 2019
 23:59:56 +0000
From: Miran Posser <miran20089@hotmail.com>
Subject: I wish you all the best
Thread-Topic: I wish you all the best
Thread-Index: AQHVucAEsdsl8C2ojEKg0dryzv1etg==
Date: Tue, 24 Dec 2019 23:59:56 +0000
Message-ID: 
 <AM0PR07MB4002754836DAFC1AFA17A4C3852E0@AM0PR07MB4002.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:0ABE45A0D8F2C47344502C4CB8976132C2EC563F23BF4216F28E6BC950D4B936;UpperCasedChecksum:90A83FEB27457F75103AF5D1B427BF2677EA5EC30AAB85C6CC0E2A4005915CF9;SizeAsReceived:6902;Count:41
x-tmn: [DiIQRbXtoPTi/B1HhdYJO30yi6cTImLj]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 685b580e-f58a-4f4b-d9d9-08d788cd60a8
x-ms-traffictypediagnostic: DB3EUR04HT085:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6GpLwcKCl6N0HZ6ek/yFrKvQ/JxKEqVMyDse8RxCX2F+AiQsIvOeDAn1mU0n3cN4jfnneMsQoQ5MZplV4kZPRzxhcgyHDbu8icPhOPzhlfy1CisvuJrF4MldqGdbzcLCxSfPg7l0zIds9valqdh2BhWdyurFON8at4BQcPsaEZ7IKhn4s3D9cP1/PmmMBJaM
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 685b580e-f58a-4f4b-d9d9-08d788cd60a8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 23:59:56.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT085
Message-ID-Hash: MPKRXSJMYWMAQLO7LRX6RWQ4UWL6H64H
X-Message-ID-Hash: MPKRXSJMYWMAQLO7LRX6RWQ4UWL6H64H
X-MailFrom: miran20089@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OAYD3JVD3755RJGAHSRG7EXMG4Z3AYFB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I hope this email finds you.
I want to know if you received the last message I sent you?
I really want to hear from you.
wish you all the best.
Miran Posser....
I look forward to your response.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

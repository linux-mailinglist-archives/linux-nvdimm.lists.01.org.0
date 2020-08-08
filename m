Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801C23F803
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 Aug 2020 17:09:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEB7A12D33382;
	Sat,  8 Aug 2020 08:09:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.47.104; helo=nam04-bn8-obe.outbound.protection.outlook.com; envelope-from=patrickmmgomez54@hotmail.com; receiver=<UNKNOWN> 
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2104.outbound.protection.outlook.com [40.92.47.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49FD912D33381;
	Sat,  8 Aug 2020 08:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw+3I2eDDB1HhcXuwotzWA8ubpXv4ue2+HjyxKXC74F34LBq3p2cd2dSY3cn+VShUuxOJ7vyLO3sn0WTFKOk08HLpcQbm6OVG5Y3kU/2dle6nij4rMudaZcCn5gcruF6I5o7O0c8ioqARKuUJhZI3Dura6PNFGl4Ns8gNWXnDUTtrt/P9b83C9dVSNiRFHzq/2sbGvh/DQ+yANdfK0VX8tVfyMpcbjGKRGENp2cE4hEDXxa2QKLGkO/4JMNqRAkactAG8gukjKBplTKRlH2rSLr+anoPI9HoGIaRB2at9RibPD+9YRfu8FlXL4KMeRhC/m8giW4evc+gUkQipkvChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Fj5CgnKDZWfL1/+Wi9YgwkMu6xikpAY5CTU29bSfE=;
 b=DbBPrj+yHKxZjsimv+l+52pIFWXl2PDte93bvj0VE8+Qe9GRijjGNIfeog+U6QrZSLoMwrPBA6Dlx0bL1UZ1Le/24OwmVWwFKvJjo8U4khZoDAZYh4AwdK17P6ng9P+8EpdvTbKhf+BW0EgYLwPnKCjdclJ22zFikgLXr2hWiI16/11ZUqL/x+mUVcOKSX3bePlyHKLDKgJTxjYE0Pep0LGiI+TTL5vO7Jd+oUDztSt7H8aHMlfFWmu2I8R4MzfK8lBQ9uZKTAKYWgyiw0f4EgzziqzZYoE5sB81SXzEW51lO2r/kKoVRURJxnagGzwtX/FqhlpN/rk4fPso9oncZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Fj5CgnKDZWfL1/+Wi9YgwkMu6xikpAY5CTU29bSfE=;
 b=hq1pRTCi9vAc3j+Ckpwdv3M+HsNHU/Uh7TjDFMhRj9Q0qubLFOAkoQ5k42SMneVYyjYXC/m/QHIxTIwkwTcuKiMVG6sK2AzZHGjq9rqKwHCZ8o8A09+MZOPy8ePC1HGAbhY++u3ZVNfIJKm9mBG0TYMNqRtmMou85/qCJjUUY22cl9ho7cFZiEsxgA2FpvmONGt2pt8DsnSFK/+BOIRbBYrBGenBrjj3kytsGyiYe5flT2/W0lRPgeo13nAaqGISTvIJGDYwHlF0GuXyJ6+urBcIxDt7vs0ZaEohy3k+IEyioMKmDh+EXLbi66zR9PmX+8ACylQDq7ZpfTcov2sHRw==
Received: from SN1NAM04FT007.eop-NAM04.prod.protection.outlook.com
 (10.152.88.56) by SN1NAM04HT025.eop-NAM04.prod.protection.outlook.com
 (10.152.89.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Sat, 8 Aug
 2020 15:09:47 +0000
Received: from BN7PR07MB4179.namprd07.prod.outlook.com
 (2a01:111:e400:7e4c::4c) by SN1NAM04FT007.mail.protection.outlook.com
 (2a01:111:e400:7e4c::140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 15:09:47 +0000
Received: from BN7PR07MB4179.namprd07.prod.outlook.com
 ([fe80::d942:75ae:2b40:9445]) by BN7PR07MB4179.namprd07.prod.outlook.com
 ([fe80::d942:75ae:2b40:9445%2]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 15:09:47 +0000
From: Patrick M Gomez <patrickmmgomez54@hotmail.com>
Subject: RE?
Thread-Topic: RE?
Thread-Index: AQHWbZX0MwCavs+Co0aWJl8HoYVM7Q==
Date: Sat, 8 Aug 2020 15:09:47 +0000
Message-ID: 
 <BN7PR07MB41797601F329AC5B998C8629C2460@BN7PR07MB4179.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:B5E2B9CA00AA44A4762A2AB7E1BA007921E80CF01EB904BECDB84FBDCFD686CA;UpperCasedChecksum:CA70C78B1E4F3754347890170EAFEC43B98299C227E5F778F8A17D4358B1F6DC;SizeAsReceived:9848;Count:40
x-tmn: [mSq2NTLhFxccLP2otbt2H5CIVt4ouz+F]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e00a0679-9a1e-4e3a-06d4-08d83bad16e9
x-ms-traffictypediagnostic: SN1NAM04HT025:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5ya2qpxZ1siAkau+SRmceEdpXjUf+QskBHN5YLbKaKVh6R8rlQNXg6A2GvZ3VfjfjDlaOdTYq8TFUaXNarPXJhowTsO9v9dsQI/43WmT2nCgdQB4oh87SPYrOmz+NqEHAPQrtXkfyckNrunsvlG2tmII/SnzDFFfGO8P2F6DtGP7bZFbyeT+bUX+6YCwJ0v++BkGUoZ3w7uxASa9hNTh1Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR07MB4179.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
x-ms-exchange-antispam-messagedata: 
 /w9FdEIbDJJxkUnYTVaRtgj2u4TpikhooLuWt/edUsmjP/laBNmE8Li9ZeyI0hnYbEh0v8zrZLTRUvt0ouKhXOhTUWz9KjmPuJ/rA1ptgJlVMg9TObn7DcLVW2MzRdMDwFI/F5TaHupqry2UO7ldpg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM04FT007.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a0679-9a1e-4e3a-06d4-08d83bad16e9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 15:09:47.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM04HT025
Message-ID-Hash: SMXKPZ7CMEWROH3QAJ7RZOOQ3AW2T7U2
X-Message-ID-Hash: SMXKPZ7CMEWROH3QAJ7RZOOQ3AW2T7U2
X-MailFrom: patrickmmgomez54@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VCEA3JEHZE6ZVLN6PJK2OP6C6HXYRDUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Is this a Business or Private Email?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

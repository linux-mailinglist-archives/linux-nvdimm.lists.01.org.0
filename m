Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6220F2D145B
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Dec 2020 16:05:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33F12100EBB73;
	Mon,  7 Dec 2020 07:05:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.18.27; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=amiya.bernier852@outlook.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2027.outbound.protection.outlook.com [40.92.18.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3353D100EBB72
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 07:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koaoDVqlgdWTjMr21DZ6NZMtnUHlUywAz7q/K+rn9DWKnjrw6EFjK6wrv2OQQ/Z8gkiek9W4He3a5aTc6M6zpbnGv4zstoaMBrVPoqFKLWny2wWt+53EJnsry2Q0dTYde1vV6AnpUpn0XhpJI4qyjJdNKnhQRMt5QuvrjlSuTXVrvZzIXf3jeKEfzaM4UELhtlQx+92WCaC/a65miVaC7ffNpfPyiJJvcOqLYwFLl50asj9uiRBqp5swkGZdqcvXHNIqByrQgODC/Ob5alisEqzi0xRDypRjWoldMWJGEpeU5nliUKAZkPXrCXgTJarfMmWX+rNKc42rW0Yt9fFMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q5XE6mK+R+JBhchVSNZJy7TZ+EGxtZSyH/PTeS0w2A=;
 b=Ksd1Tcox+ZfrQnLSPfRj9mAyspaKnXqzPV8Ux+jRRADd9yGe7er29vIU8nchhZtNYaQZVqWhI2MjqENc18oKiMlbiIwnvckd72SYZ8R5OufTFqM+gWwn8W027msfgYv3p93WitrTQ91HBcSeezIXnTlE/Nj7F3de3SVB7esdm31zJ+LnPCwdYa8FpU8X/GckIbbQgMtH+KzcNHnIL0I5Z0DXnKaOelJA9HRGbkj8Z83mZ7eGurZvGwsYnyNZv6NI1SF3ZXEhv8CligktMZWE5AlL6T1RULdv+gnxzuR+JyDIN24AO799nHTfjLvXKwHyxobAw6KYjUM5SJmkkEoXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q5XE6mK+R+JBhchVSNZJy7TZ+EGxtZSyH/PTeS0w2A=;
 b=m1WlbQ/DluuVSkBe8B17FErVkxu7hbeqM2VXYChEQDJ1Hm7Xbe5Hz7Pi06MzjHD2LEMt4QkT5Jf6onm7Yfo9StlH/2iqZg1fm07Rly+M1YxW3XAo19+BQo0F4OwjqwTqfMyBkv5V0ldCoe3NhiWBf117AXPc1lZG7wWpvMYhYhQSGWUkcDv9C4T4+27g5XvV8iLbmzIo4QFLCiF4BpteqeclLmn4fMgPVjTQbbGQ1lH+OhKUUp6AdW/9NZoM+2EHjRYBfEC0+fAHal6iU9824E7uCHFQPOU0mDFR9kKp2KS1nrCJq1mP+YY72ph7v9wLN30Oi42yrOqGSi0x94q02Q==
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::46) by
 CO1NAM11HT046.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::190)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 15:05:34 +0000
Received: from BY5PR14MB4146.namprd14.prod.outlook.com
 (2a01:111:e400:3861::40) by CO1NAM11FT021.mail.protection.outlook.com
 (2a01:111:e400:3861::307) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 15:05:34 +0000
Received: from BY5PR14MB4146.namprd14.prod.outlook.com
 ([fe80::882d:ea1f:7768:e9d5]) by BY5PR14MB4146.namprd14.prod.outlook.com
 ([fe80::882d:ea1f:7768:e9d5%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 15:05:34 +0000
From: Amiya Bernier <Amiya.Bernier852@outlook.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: Gynecologist and Fertility Doctors Contacts 
Thread-Topic: Gynecologist and Fertility Doctors Contacts 
Thread-Index: AdbJuti9GfzDQc9tTouZHQSeNTkgpgC7zdbQ
Importance: high
X-Priority: 1
Date: Mon, 7 Dec 2020 15:05:34 +0000
Message-ID: 
 <BY5PR14MB4146B67F00D024B92E9B5C07D5CE0@BY5PR14MB4146.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:8EE4EE73003C528CB040A906D92F21C762B09513A60231931C205CAE85BA47A6;UpperCasedChecksum:46727DF6A64FFC92A313AA944090FA1E3B7E57DD1266D42587307391F4E22CE5;SizeAsReceived:7109;Count:46
x-tmn: [4g7s6vTVxPPzlBQdDDu4xE6yLJNuTJvTbQ+89LkhtRw63se52dJWe9D9RYjxXATI]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a242ef93-f50e-484e-bdfd-08d89ac18c30
x-ms-traffictypediagnostic: CO1NAM11HT046:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ch3yrLytT0EBK+HUFqekAZRl1RXIR+SXe/BYYArqUON5hWm8DctFXY0yn7i6pA7S5yQCxBJ4OtwpRTGS8YfEGFPEVUburXt4AX88ri9JZ5EJ5vaufes64Da55i9rEFb+3C5LF8NtQLhEi0zf+vMtB5v8ZSBB9b2mSVRL26RDu4aASaVC8T3tHhZYL8sdWQ/wKs1QSTmp+EnIbRn16Y/6qg==
x-ms-exchange-antispam-messagedata: 
 /yAd6cCdpwLgMLznnPlAkzt9HD2Wyz+nFeXDZWjhi5MPl2NbxuxrinjLzLHVDrbO0kqnq7hFietq5KLNvgqgcf+3/BkwdKq03m96/7+66DoCCwCOBNw/vgtuUhKN3JLNEHr2fJfilTJDiNYGNgi8mZ7MStMxMCWqPXFj2F7K9XGBg/6V//w1gK7n91H8UytFbdL5639PTcBNDIdtYbpNsQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a242ef93-f50e-484e-bdfd-08d89ac18c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 15:05:34.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT046
Message-ID-Hash: MGUP7HGVYQ6JT7GBOEJZCEVRHGQJAKFE
X-Message-ID-Hash: MGUP7HGVYQ6JT7GBOEJZCEVRHGQJAKFE
X-MailFrom: Amiya.Bernier852@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HIC5BHXY45Z2KGDUS3IGYDAQRYZYSF64/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi,

Kindly review my email and share your thoughts. If you feel that the suggested contact database is not relevant to your business, feel free to share your target market.

We are happy to customize our data to meet your requirements.

Awaiting your response.

Thanks,
Amiya


From: Amiya Bernier
Sent: Friday, December 4, 2020 3:17 AM
To: 'linux-nvdimm@lists.01.org'
Subject: Gynecologist and Fertility Doctors Contacts
Importance: High


Hi,



I wanted to check if you'd be interested in acquiring Gynecologist and Fertility Doctors Contacts for your sales and marketing initiative?



Note: We can help customize the list for any specific requirement based on your criteria.



Let me know your preferred Target Geography____ so that I can get back to you with the counts and pricing.



Regards,

Amiya Bernier

Marketing Manager



To opt-out, please reply unsubscribe in subject line.




_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

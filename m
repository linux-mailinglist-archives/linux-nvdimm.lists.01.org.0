Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F2DB682
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 20:46:52 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65128100DC3CD;
	Thu, 17 Oct 2019 11:49:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.5.102; helo=nam02-sn1-obe.outbound.protection.outlook.com; envelope-from=ucheok@hotmail.com; receiver=<UNKNOWN> 
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-oln040092005102.outbound.protection.outlook.com [40.92.5.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0FD37100DC3CB
	for <linux-nvdimm@lists.01.org>; Thu, 17 Oct 2019 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI3WnmJADt/XwBAImIyH58kLPa1dKLHMFTIH/euVSAteQCNe0vX1dOJxw04aNlGfcBsTLabdNkI6FknV74UXzFF7LNPTZubE3DuLqvOFaE8YYXs0GCXjCqZlj+mUz75nroXdbeRyOG0dQinpejg3qF0vkbjICAgc5tSRyjIelVkAAXreBD+7O0DeTdcDpzETFnO1EqOLRDlhzcdnP5HtXg4a5h5XTM6Jrcb7Xu0kAkvObdOWTBFYSaQQy+2NWiAJvuULyfOhLm/HZS8WIxshzZL5AR3OkG3I6SOeEViNwpAuznGegCfYxxKmd6ETyqb8QEg0MOUp340JC77qwjA5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTjzulFiltOVQqiRcxEgDNboEgSa4jskgSdgaJfnCnI=;
 b=TFPKQODL/WvzcPdeX2iQguRFUt25WtXjnhwD6YkPM0XY7+6SjZI3MoxvufI4MEr0eWibu1I7uxFJ9G5qd0SOy1ZmAQpvP5nd/67/rLnRPqMXH+uNY+GL/j0M5qc9S59i1i5aEfXsHdYEI60ouok3WCoLeyWc9y9zvEJiDOWMhXJzc1DVjySxRCYZmF9bm4+TL0tvCjUA4wwnuO962cR2Eg9X7qI//I7CdqQXcgKZ9hQiv7vkMKax37IiUtJzra198WiAxhNcE9TZ7IAGEn8WwgTXY3g4OYYF02EtdCPR3A6FZuGyUAykz4Caxlt3bl/OE4onp9y2IQbqV/Xs0CJiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTjzulFiltOVQqiRcxEgDNboEgSa4jskgSdgaJfnCnI=;
 b=eYH5lsJHT4LMieMyHv0hXrFRCDlrCSsVlldCnzeaYCYanvC6V1VeZA8ExRuSD/TqRLbgiE2uCrEH5hsQk5B10zxQjzGnnReclBfU9OZCzp0PcFB3zM/7JCSlLMt5B+orN5fGc7+jelGwGk7jCAqmKlMYV70p20zppioGzUa12ZjP9xPH7wo4A5G6s3KiiKC9Q6owJYWnegxmws+hiVfK1Ur9q+2V3QKKvIzMfflWKYaZ9JXEcgMd5bL/giKDWbAzWS/kJWK/qylfhwkoP7ydyoIxhopWbTpGqHIjCtwAt2gp3yjqcwpiMWgCdzRkeQfyo6nx3FwhpdFfRiDw4L8ALQ==
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (10.152.76.56) by BL2NAM02HT019.eop-nam02.prod.protection.outlook.com
 (10.152.76.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Thu, 17 Oct
 2019 18:46:45 +0000
Received: from BN7PR06MB3986.namprd06.prod.outlook.com (10.152.76.51) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Thu, 17 Oct 2019 18:46:45 +0000
Received: from BN7PR06MB3986.namprd06.prod.outlook.com
 ([fe80::b07f:358e:6025:a7a8]) by BN7PR06MB3986.namprd06.prod.outlook.com
 ([fe80::b07f:358e:6025:a7a8%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 18:46:45 +0000
From: Elizabeth prosser <ucheok@hotmail.com>
To: "alexander.levin@microsoft.com" <alexander.levin@microsoft.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "mb@lightnvm.io" <mb@lightnvm.io>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "agust@denx.de" <agust@denx.de>,
	"alistair@popple.id.au" <alistair@popple.id.au>, "oss@buserror.net"
	<oss@buserror.net>
Subject: wish you all the best.
Thread-Topic: wish you all the best.
Thread-Index: AQHVhRsolmsRhCIG50i3+QortTIqLg==
Date: Thu, 17 Oct 2019 18:46:45 +0000
Message-ID: 
 <BN7PR06MB3986BDB74C60B7A996A60919D06D0@BN7PR06MB3986.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:6F030215F8925230F3709F4AA0D52D936D27498DCCC74DD700BA9B06CD49DFFA;UpperCasedChecksum:171BC0CBD0BE2878E9191F289E232F2F6404F1B5482CAC45DED49C71F7F10097;SizeAsReceived:7010;Count:41
x-tmn: [/HxXlZLDRQUi4kA3U9hUGjN95jE4yn1P]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: BL2NAM02HT019:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lM/mHudpmxvAMcz/k2L1oH7Y0NDt5IUGkHJ0mCLHdfLpLBpBlODi3R7UkgQzKRVdfrPI9P/o4gR3MliA58qJTbrOIbV24CjyQLG3OyXCnco2uPzL3J/77nhf0us45+t+apALfkdCcmmBqGC1XB3+VcaLYUSDSTIxsNqsJGbWnFe4fRNxGQuLb9CebXUWkHKO
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b0966-a51f-4139-8a20-08d753325c1c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 18:46:45.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT019
Message-ID-Hash: DJFCOHM74CORW2N3SWLBTUCNJN5AA5XY
X-Message-ID-Hash: DJFCOHM74CORW2N3SWLBTUCNJN5AA5XY
X-MailFrom: ucheok@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PS3JYM64UK6VKDSZJQEBWJFPLUTD7EL4/>
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
Elizabeth prosser
I look forward to your response.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

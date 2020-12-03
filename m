Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846C2CE10A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Dec 2020 22:49:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0271100EC1D1;
	Thu,  3 Dec 2020 13:49:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.20.76; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=amiya.bernier852@outlook.com; receiver=<UNKNOWN> 
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2076.outbound.protection.outlook.com [40.92.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6310100EC1CF
	for <linux-nvdimm@lists.01.org>; Thu,  3 Dec 2020 13:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+k9bwP7bFW6pUAQLJ3UVr5PrMYlLFeRiG1rjAVuTgShNOt6p8eIQ5ov9Tr9URCllu1Cmh4CPwvdwCp4KmXrO4EmtrHh6Spl8crOc+dF5iXRLQzkMdKiLRwkXh0bQ4gygB2OLbI3ELPW8SrfPZfB+VdIxB75OX/IFnFr83T/nQL1ISS8QiUMrWtlKbWPx4/mUtxbAh9BXvq8OlbW1cwBB8wk4w3fXsubhWWePPFooHQJrZcWwZLIL5wsahmDD3D3ItFaVQwuEUMI7BQR2UwaTtUi7yznfqC5HXkmAZSrRiUHZR9M03gGqKh9NFq+n5bPCIXCm7T+tw7HYONvE/p/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1CF5IhCULT/AzOigVjoj9m/nYilg2hruP2ygXDH2tc=;
 b=WIdgVlI+vSR4iqOQQ3m2CXE8AcaKti+drlDbwBx56vq8eWwnu6Egg+GLArA/LmOtlDi3XdRyR+AmChABzxR6rYOFwh2a31ucF8MVGBl/Hn2vRAxLQRpvWr8BMpyBpbAkYS7dJP9J8ef/gOyAJYESZqg5SFlXbi2YYG0DWoO4GxcanBN7HLaef8bQqrKHxIKzc/4ts/tsN/CnkZDpY9cJTEx8LpmeQ8EBZa4TJoqnLzb9RwiljQzbPrlBizuwuptqOT42qsBZDyZ8zD7rON+d+4Rc7zq1HD4OnhXPXnLL5r+jPnUjFthaB9fxwHyJYdBiaONyBIVl/feH40rimfIKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1CF5IhCULT/AzOigVjoj9m/nYilg2hruP2ygXDH2tc=;
 b=HTnxpRZ49p0OXCe2xk1RH5x/T0B9x4Vuw9CjTpFVfSFyEaCYnrwp0oIOIcYhKSEwXXaNxQL1aUxVom6iQm2BczpHbWmLGiNRy0sLxiyKA8AT3L54ULtAbZpmCoZlezPj3TvyoZgs5RmD6V2sSPL9dglSx5pP5r801pC7VWcNYEK4PeyQm2W5f80BAPdwvR3ZsPmIyNWvyBrTUSGFNzFAEEhZF6v7YxDA2gUQ+M5S1YyOJE/YCntRox/L6ZOohHFHkJIsA8IUhbfRGxN4JeXDBeMGu0J+E3zRUQigcnXVwufY+Zirpkrd5oIjnDOjXmL9HiSU1A+xltJHMoKohVm4LA==
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::4b) by
 DM6NAM11HT192.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::263)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 21:49:28 +0000
Received: from BY5PR14MB4146.namprd14.prod.outlook.com
 (2a01:111:e400:fc4d::41) by DM6NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:fc4d::64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Thu, 3 Dec 2020 21:49:28 +0000
Received: from BY5PR14MB4146.namprd14.prod.outlook.com
 ([fe80::882d:ea1f:7768:e9d5]) by BY5PR14MB4146.namprd14.prod.outlook.com
 ([fe80::882d:ea1f:7768:e9d5%3]) with mapi id 15.20.3632.020; Thu, 3 Dec 2020
 21:49:28 +0000
From: Amiya Bernier <Amiya.Bernier852@outlook.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Gynecologist and Fertility Doctors Contacts 
Thread-Topic: Gynecologist and Fertility Doctors Contacts 
Thread-Index: AdbJuti9GfzDQc9tTouZHQSeNTkgpg==
Importance: high
X-Priority: 1
Date: Thu, 3 Dec 2020 21:49:28 +0000
Message-ID: 
 <BY5PR14MB414607439E4169869DDB5E81D5F20@BY5PR14MB4146.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:3D6A006366361BFC9B1AFC207A3A0B8376EC5D377FF0A8FE9C2B90B4250263A8;UpperCasedChecksum:BE5CEA05363851F13B2E14FC9A6ECC82CF08B7262EF40B9FB805CB35401B54E6;SizeAsReceived:7119;Count:46
x-tmn: 
 [uR0EoGNtQ+a93y5VAT0aUVkB9sxTVCZnrFQxI6Ygxqvr9tFhONiYggpm7bNrpEouU2/h/jAIugU=]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5f51b0a8-635f-4461-00af-08d897d54f00
x-ms-traffictypediagnostic: DM6NAM11HT192:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wnJ66wxlLX761YR4nB4VMIyfGTZRTNGycjxayqUy2xBxWkWvC+cHEP9EC+6p7k3AlHf+ZQQuAiVFh2ioUo1iEGMfMcWNa47JnpUoukhd3QcXtyWhlPsH0j5HsAynwBeVG6buzWtOzQWCZ9w9lxLqy1k+cOo4zgpzZiVbylewx0vyTBm+gvYWAH61l2bLsbFAe8TeYLaSYsFsEkbJUbo/FA==
x-ms-exchange-antispam-messagedata: 
 xmbodQe69aFjE7gp+NV/jmqyn8xiJlexd8jT3g1E/xD6w7uKP2MZfoZ6Bq3jlRFxRzAtgzpJxH56SRLPDhDkrpbIY0Kg6gZsZpBfMb8QLJPp+qKlNFqoWR+5r0aiPAf3GGSjY/rXVWtVs0C0FvwOYdBvVbobg46XMjHBHDr8H09WC195IG2UtkGgO2BixX/ozptJslBiZ0GkdynvLQVjKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f51b0a8-635f-4461-00af-08d897d54f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 21:49:28.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT192
Message-ID-Hash: CNOGNZTOUZREQ7TBBV33RZBJSZ3BUPZ6
X-Message-ID-Hash: CNOGNZTOUZREQ7TBBV33RZBJSZ3BUPZ6
X-MailFrom: Amiya.Bernier852@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QGDRRRNYPHYIBQBNW65CA6HJMSPRHUBC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

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

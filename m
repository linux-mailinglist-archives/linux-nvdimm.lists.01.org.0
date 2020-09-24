Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC32774A7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 16:59:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18973149D9094;
	Thu, 24 Sep 2020 07:59:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.42.39; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=will.jonson22085@outlook.com; receiver=<UNKNOWN> 
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2039.outbound.protection.outlook.com [40.92.42.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39CBD149D9093
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 07:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUCUPUCPBM96PblU7BnVHJ2BgMAA/IAD1upNne+te8EyNAvk8gVAKYbHdzbF8mDj4qHPkuc+5YCBvRetiFgLdQJGNcZaNWjRv+oG+ZQMQLwhMZiyrCe/kdqC8jROxctDl81biKmO2iiUw2aHix3JkUABnpHv1q4Rc6mVUv4/iw/GhCccQzykXckw7UwS9RTifl+qbTWxXVx3lvV9X5T6LjZYT1RdUiz/5ymoiznw95hPpD1tWYrmlEF9b47Z2F13G1hABqXbRQ9Vwzmn15RolGHhsJPQKV+dcRAXHvOmFOmwBx5xEdycL0JMTKCdWDMDng8mcPf/a9Wftp0NFoiakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7t5MAiqUtDuCCjNU+mkTsrG/iDur8oIk8zp83d/hL0=;
 b=MG5hJQnz8rmkD2c96sEn/8dizKe27W14EvsIA2/a65pcHu9Mgi5jOFAp5v8lKKvGmGubUr0XWbWjltDPz5P0UDOrNHZNI31956RnroPoaftpkmjiyvw/70Me0hFzS3GzmYLln9ZM2xdnT4bjKWxPqsgyIemHB0cxQckjs33TiJ80uLsGRkCAq7D/hVcq/NUD2LVOWLeha4I9W3m1jCDyWZweyB/S2vq6hBAOmySvOLvXiDqBIqKCJlJ9x69I1Mt/TUO+NZfzRHVTcMEdS8cYvm6CDPLaWKwzn7i7JTu/zjAk3L3HNRx7WcU5H3zw+rn75eFhTHGUcfVlRhn941em9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7t5MAiqUtDuCCjNU+mkTsrG/iDur8oIk8zp83d/hL0=;
 b=sm5+v6kx6Kj8c3vlOjyusdl6+MGFKy2UNkR3qmRUdT1mgXew8mUgyNew0jnhEMFyOaFLJKfWkaZs86KsTlUB9Bd8u1JBZAJSwOiHWxJhsQ2gPqh8JjcRkTlGxvIhte4iZuXv6hyApyRgBfqn+K8621y5oHiUDm00CDL2vR5IzHibzPORZM2FwXz2G7pw4bQzIMkgXaN1u0TcRBPxef5+WYDH/BOwUkgPmzN5nUyEducTkSP62FOTESKnta6YXusqTplhpjm1PBN2TVz3BgM3SU7l6XrO+Bk6rKx/Y692ofMo2gKVlOEBiZuVbwxKWIELC1wIig7akqxEC7q78PTzxQ==
Received: from BN7NAM10FT034.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::50) by
 BN7NAM10HT047.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::328)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 14:59:40 +0000
Received: from DM6PR02MB3963.namprd02.prod.outlook.com
 (2a01:111:e400:7e8f::47) by BN7NAM10FT034.mail.protection.outlook.com
 (2a01:111:e400:7e8f::151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Thu, 24 Sep 2020 14:59:40 +0000
Received: from DM6PR02MB3963.namprd02.prod.outlook.com
 ([fe80::b0bd:dfaf:cb2:3333]) by DM6PR02MB3963.namprd02.prod.outlook.com
 ([fe80::b0bd:dfaf:cb2:3333%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 14:59:40 +0000
From: will jonson <will.jonson22085@outlook.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: Obstetrician-Gynecologist Contact Details
Thread-Topic: Obstetrician-Gynecologist Contact Details
Thread-Index: AdaGxAodH7Fhv9a2SZmc4/G7Rt9aVgD9egiAAfJ6a5A=
Date: Thu, 24 Sep 2020 14:59:40 +0000
Message-ID: 
 <DM6PR02MB396385AC8DE6830DF4606130C8390@DM6PR02MB3963.namprd02.prod.outlook.com>
References: 
 <BYAPR02MB3959E8A038FCAA07BCAC4114C8260@BYAPR02MB3959.namprd02.prod.outlook.com>
 <DM6PR02MB3963AA6E727276EBC941715EC8230@DM6PR02MB3963.namprd02.prod.outlook.com>
In-Reply-To: 
 <DM6PR02MB3963AA6E727276EBC941715EC8230@DM6PR02MB3963.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:06A0589549B47893B683527657A4E79D8217DAF072C1BB6DC3D10B7273E56320;UpperCasedChecksum:37D62319ABAE6E13D930F06614E590182D741BC648433A29698238B06A370E81;SizeAsReceived:7175;Count:46
x-tmn: [GsV2Ar4pJK7y10fq52Z6eSAF7M1tt2J1]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: fd725def-f03c-4327-6b44-08d8609a767d
x-ms-traffictypediagnostic: BN7NAM10HT047:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5uVAaJaMzwzfbHLbVU6QwvNLVm/J7kFtX+/wU23ZGj6sa2C+N+nKHra/u7yFTCiA6bRvKYOHKo7p0q1oDCZ9dOgUubXVtlqPXJOjkSQ592Z2eceMLc9Pt/vYWd/+pjhZbBXntDrzG6vFrvZPuFVxoVDIpqEhnTFUttVlzPZgrLM6ykLoavlYdowjQ2+OvEw8jR3N2yeU9+cGGEEb3qFJAg==
x-ms-exchange-antispam-messagedata: 
 7cGaKm1CHS1RSP3JOlgs4zwjZwa6ngpls5pT1ASumv9w+L55pW30roUmagcV4bNT3aLCeuHycEa/VHq0reRcsBS7yPBkQ5h+iK81j/rwxMYbwpc0UmpSmcxG+0dPBVIyVYB1HvszBYe3b6O38cF/xg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT034.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fd725def-f03c-4327-6b44-08d8609a767d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 14:59:40.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT047
Message-ID-Hash: 6IV2HTMF3BA6SXMAG7IYWN25MB7D3SNG
X-Message-ID-Hash: 6IV2HTMF3BA6SXMAG7IYWN25MB7D3SNG
X-MailFrom: will.jonson22085@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GMMSD3VLZGVGCOUDAKXRASGQHRBDFJLF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi,

Hope you are safe and well.

I haven't heard from you since my initial email.

I really do not mean to be a bother, if you are not interested or if there is anyone else that I should be speaking with, do let me know.

Awaiting your response.

Thanks,
Will

From: will jonson
Sent: Monday, 14 September, 2020 10:37 PM
To: linux-nvdimm@lists.01.org
Subject: RE: Obstetrician-Gynecologist Contact Details

Hi,
Did you had a chance to review the email which I sent across?

Please let me know if you are interested or have any questions so that I will provide you more information on counts and pricing.

I would appreciate your reaction.

Regards,
Will

From: will jonson
Sent: Wednesday, 9 September, 2020 11:25 PM
To: linux-nvdimm@lists.01.org<mailto:linux-nvdimm@lists.01.org>
Subject: Obstetrician-Gynecologist Contact Details


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

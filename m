Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA431F9EA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 14:30:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E030100EC1D4;
	Fri, 19 Feb 2021 05:30:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.92.90.65; helo=eur05-vi1-obe.outbound.protection.outlook.com; envelope-from=drarobinsonmmm@hotmail.com; receiver=<UNKNOWN> 
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2065.outbound.protection.outlook.com [40.92.90.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 038A3100ED49E
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 05:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvRl3WTvkQW2O+vH0InJ9IqCIb/91qANtBT1xMvA/MIMCVRRnPhP5f0sio/vADvKW25rqEu3MdmkANYZPjYQ7YefXb+RCgCO71BQ7nTIiU3H9blCzq9S2+4/CDawUot15dFRigkt5Pwch3KFIhAGXOrDYIoN4RfIxxL/l10gkXuuqswpB56xRWfTEaWjdCtyIbh3quSpY/6ezH6PjHjmXC0kK+GN2SzXs/YYnLaMQRyZq9lJlcZFs3YQmv7gd8tZ1JVLydbyUXY9g8Yw5z2r518SaRYzPHQ3l3DsCyB7iILBEm5ZPvFtA0E5pRjjd/C0JBeMfP82zCkwkTBPHlj/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n66eCz3zXCXg0VbdLFUjf1kSMzhaLhz+dEpm7PxwMcM=;
 b=GCTBYc+8V4lUodw0d5e7eE64cp2teB7eBS7IuNDjI4QUMqelnq6zl2JrES4Y41o9p/SeAhon4rG9YqeOtusHh9HxgAwGw5O1MdQ5OorcLtWkUkPjRTDD2xcqYqJ/Twq8GduqPD9NPMgGHbnVbK6rje0oIZZsIwTNRBnv4Mvs9wnu/ywYlGufecNi11Vvfs8Yz7l/DLHBstkIWEZt56scKtoHMM26pCzanIH/dB7fK0mDYsEEeUnZa2tOh4PHbe2V26NR0fwIM6quv6ddxnJ+A9NXQd/bWO6RINavywFIofo5nqe9XFpNbHzkbxH6mvox17Cf5bYJ97h2hwAoh7uzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n66eCz3zXCXg0VbdLFUjf1kSMzhaLhz+dEpm7PxwMcM=;
 b=jqyJHlRhWMZnGnAu7IvLdIZtV/YxatHl84WV2IPRATb8WhObH1ZFsl35jIIx6D1WlxrdRQUt0i5xvNXxDVKkxM0L3Ue7YmBbewPhf0pobvtQsRMupyrBCytqTxz6wIl/uqdnk+hUTP58qiVZ4yN16pWEYSels5oOSWW2EmDGdlJMqIgDQf3IqZ2mAzsAzp5Jr3GIbf/8phT7l7M2QIyinE4D7vi7X0RkxU636+fdPwL93QImr6NcBam1ebzI0Ly5Hpoh4TzLtv10viCFw/ja2dvOAGDcKG0NOuvngjJd2pRCqA2BBrROACUhlLtzeEn5pf14LaJwj1uKhjbDpp2k9w==
Received: from AM6EUR05FT014.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::51) by
 AM6EUR05HT220.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::382)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 13:30:20 +0000
Received: from DB6P195MB0071.EURP195.PROD.OUTLOOK.COM (2a01:111:e400:fc11::48)
 by AM6EUR05FT014.mail.protection.outlook.com (2a01:111:e400:fc11::213) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 13:30:20 +0000
Received: from DB6P195MB0071.EURP195.PROD.OUTLOOK.COM
 ([fe80::a5ec:8904:38b2:224b]) by DB6P195MB0071.EURP195.PROD.OUTLOOK.COM
 ([fe80::a5ec:8904:38b2:224b%8]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 13:30:20 +0000
From: Oliver Thoma. <DRArobinsonmmm@hotmail.com>
Subject: Why continued silence 2
Thread-Topic: Why continued silence 2
Thread-Index: AQHXBsNerEFMfrxzcE2RFyRlq00GSA==
Date: Fri, 19 Feb 2021 13:30:20 +0000
Message-ID: 
 <DB6P195MB007199C33041E32DD46284AFDF849@DB6P195MB0071.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: 
 OriginalChecksum:3FDF08480EBAA8CBE686C3D25B63EFC16E48D96244FB32FD443B8EBD74065FFA;UpperCasedChecksum:C934908FABF5095102060C2F95630D18BE5BB4B184F782DD409104AA9DA1ED79;SizeAsReceived:12333;Count:40
x-tmn: [4gTJ3VuyidgA52jthKPhzFEQYS7/HJ/Q]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4c5fcb3c-7008-432d-2804-08d8d4da8112
x-ms-traffictypediagnostic: AM6EUR05HT220:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 e3trFKp6vnoNy2PtagiYqFRWAvjiEKBibOA3Tyh5vUdT5roZivKQAag32P+zPHj2+d7b57BmOq3Qxs+vWlxbxwdWs3r+N26wrrv+onY8PwGan+iRJRwzG3aiAB3or0PN/sxvCu53Dxlh26tBnVlT8LIK1+yl8QDiUVLYezCgWQIBeMNCGPpLzQeMWlvX3knU5/7P2HaHynTGT03zyz+IBZzz8dIc4D3Kd9X1Y95KQlpVStjclXueFaTf54ZT4Jy+03HNhsAd0Vzv/JDfOhe3HbP3VALHaTElSJ6lYYHs+6jnDfAsAjhWr8OK/vXU7vADqwTfSYhRWo5h0CxRFg+M6WJ8FxEo/XJPZASM1mpxbeERNjkSfM3UalHosy5hDj/2
x-ms-exchange-antispam-messagedata: 
 nBJdiW8l74WktERqi1Qpcqh9vBzzO88O6D5xe7X91Vyu8Xrl9PXDOKrkiiPr5bWojyUgMHuKfCJWRyly8E1ZGPsBbjAYokJNQb5tLD31/wRKlcBuy/Opn1jlI/bfTbyIMrPxupdbzDDoI7KC8w6YhA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT014.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5fcb3c-7008-432d-2804-08d8d4da8112
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 13:30:20.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT220
Message-ID-Hash: SYDDWZPC4T5VVBAFXO6C73B55BWHMHYK
X-Message-ID-Hash: SYDDWZPC4T5VVBAFXO6C73B55BWHMHYK
X-MailFrom: DRArobinsonmmm@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5HLMSW4IRKZFFVCT7SUZDXBKDO3GOG5E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Did you receive my previous email regarding your family inheritance?
Reply strictly through: thoma16999@outlook.com

Best Regards,
Oliver Thoma


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

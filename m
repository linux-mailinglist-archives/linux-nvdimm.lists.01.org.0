Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254A27F2CD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 22:00:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AC7C154B2A28;
	Wed, 30 Sep 2020 13:00:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.220.53; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A48E314C11643
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 13:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt9WEdTH+mKHKx99cQ9/jOcU8JjSyb4wJ5VdPr1hSq1IaGFUyB2+G8gW1gWsABWnP4AKjh4+3RIP8BfBWt01CvPopa+5G+W5qMjL6BYSBHOtAB9Wc+nN18gm9+kyhoeOCrlBzM6vt89CoAzgiSq4F6ynJyYBGJAwQAgPc618ypeq2BwAvaZLDtlXQzum7XaOrAPDbh7Y/nIuaozgpKFHLUVkrXubGhLSpVq60vpNmCyJhXJ7t76S7EfEOvOIw65tg8u1IcY1rA1YrQLIUcJuh4N52ntRFIjf3ooZHPZtD5e3jpSrsETzceCaAm6N4rd6r+bqajYpF9QxBOxQy5pVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS0EqSIbRvhHf02ES3DP1MYUjHDpTDJIztV5UUySz7A=;
 b=ocwqKyg4rz8QoUk0JF9MIRduZFKwg4NbNsllXLTx2JA7CWM7utZIaZr53Cc2rE/0Lv+CqaaTCabZkc6hNLdwJB6Vpnf2Xn5PnH3KnjCYDuPyRdPWCSmZKKI7uE22IeURb7ix6gNikjB8OTImq/45v26J8vw78yATI387XegfULJg8kZoQ5PEB9vJ0ZHtNHwKJ+WqaPUfcy8VA2wvxxCp2IDFrUGlZhPZFkoWje1PuaJ1Bsj9k54xtj3zLCMEVatdw6b6sv1QvpyWaRQO/Dbs7F19JH392zlylD9zuwplVaTF2t8gMDAjJODYNJoZvHeRUY4neEMQCKf+rqsAlI+YVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS0EqSIbRvhHf02ES3DP1MYUjHDpTDJIztV5UUySz7A=;
 b=Sy0HR9ahGIlpZ3EMgD3oOzTp7Hx+KpketaJUMNd/VbxEXpu/c9/4X3LXJPnz+AmAmJj8My+8YfmjG76ObvCiIjJHk7KZZoz9JsAstvTaGoip0QVSdVnmEfjIa4B4YPwJH7A6eR9dKyD6qH0TrCrDjdcvKly4TlcfOzegHQIilC8=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN6PR08MB4623.namprd08.prod.outlook.com (2603:10b6:805:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Wed, 30 Sep
 2020 20:00:06 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3433.035; Wed, 30 Sep 2020
 20:00:06 +0000
From: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [EXT] Re: [PATCH 17/22] mpool: add mpool lifecycle management
 ioctls
Thread-Topic: [EXT] Re: [PATCH 17/22] mpool: add mpool lifecycle management
 ioctls
Thread-Index: AQHWlbcLPnsRCBRfHEK8v2KQZl9QlqmAUZwAgAFG53A=
Date: Wed, 30 Sep 2020 20:00:06 +0000
Message-ID: 
 <SN6PR08MB420825E40A88DBDFE66C5E13B3330@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
 <20200928164534.48203-18-nmeeramohide@micron.com>
 <43f24e68-2625-36ce-1727-fcf981955b17@infradead.org>
In-Reply-To: <43f24e68-2625-36ce-1727-fcf981955b17@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd8972c7-5afe-4341-8fd4-08d8657b6d54
x-ms-traffictypediagnostic: SN6PR08MB4623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <SN6PR08MB4623FB781AC4642D5249E1B0B3330@SN6PR08MB4623.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4zrnwoW9XzFV1vnyzqopa3Tja1Ofr+HikE47t5qySZlBjDynzHZc+WvovD/7eTf/7qwZmkKQlEfjQODHeerByxQKia0gmAPTaXLrfWU7gXpOiKfMNJh+Rv9fX9JBEefoZ+rR1VFUhobJTIA/3AMFdvPStHau1D0Rhir9JCx6E3Aggi1wZjZw3sGvfx8UEIJGdCgMyps2nbyhE0LyRUd+E8aRQKvyJ2P3VkpFXrr58jnL5WAxrVBWUr8oYFXOj8VTpsq4WxTRCMN0p7fZfs3P1LCKBvUYUUQXmAHjXCzMXJl7xoAwRqVkAyft63j+dPnRax2an1lwwUYL9y1EVMgwwh7XgeLsDPX0NfJL4nxqwWj0MOe6hzbzEjf2TYkI5gV+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(9686003)(52536014)(55236004)(76116006)(66476007)(64756008)(66556008)(66446008)(86362001)(316002)(53546011)(5660300002)(6506007)(186003)(54906003)(55016002)(2906002)(8676002)(8936002)(66946007)(7696005)(4326008)(4744005)(33656002)(478600001)(110136005)(26005)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 B5J51C/gFl99K26sQ+RFIZ9HUliHC/50xSIYkve2BeI7hjOF35y6KnzxcP6wRacR+22uKJgZUvE6h+YJA1ttmNZJKEJOtLK2z2RQYrWVMZ8YFOWmWntlvQsAMUtRNGxs1acJuwvxJIm8gjRJtNxaYnlj1V5k6z5cxGxRnOl7ARMsHn6HAJD0BHKK4hGmuAFhHPiTEt6pg6Uqh3ATXUVUxYKkIpGPSZEG2S9/MK1ifSYfXteSaom7EYZ8i30UZCEMmGQRDeH0M0GUn6rYYN+eVyVm9SZyItbaya71x7D2udnww8N91fXPY/R3MhBCYxQe8QIkTK5e7zVK7hiifqdw8t/1CeuG0JN9fux7oo8mzd+PYToJciZmvjffprZqj+GuIo38mtjMAnO7Z2KWrEXMNJAB1B4b4fQXcMxM30LPjm0u4c/A66lKwJlnnLnbCt30tjtcKEj5B6lFhztV4fdpLbEgB+ix+amlhO6T3Qp7lO/fMpT7x3X+JNfbX7vsjp2d2YW0rM69vTQSp04wSBWDfZ4CtURng4Hul6V8fWSekSH+TjHNCbVQi3Yuz+gh2T+CMZTknR++YrUUqbAckXUlquq2hwGkePlTp2eBlTRTHOuytJJyfS896Up7E6mx9hvDkD/gMG+ZOsWB7CyxwG2pIw==
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8972c7-5afe-4341-8fd4-08d8657b6d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 20:00:06.0917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKKRe6Af0gaKqt4adsv/b14kpxVyq6mUF0mfiVrOV4an5Kxj8qoKYciCvYS2/BzFLRDR4CXzVL05qMd12loU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4623
Message-ID-Hash: VW46ZAE63UAWJN2JABVZPJMOVBY72K5E
X-Message-ID-Hash: VW46ZAE63UAWJN2JABVZPJMOVBY72K5E
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Steve Moyer (smoyer)" <smoyer@micron.com>,
	"Greg Becker (gbecker)" <gbecker@micron.com>,
	"Pierre Labat (plabat)" <plabat@micron.com>,
	jgroves <John@ml01.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PUU73BR66QCPDWJS42BIWGHMTZATE2Z4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Randy,

On Tuesday, September 29, 2020 6:13 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/28/20 9:45 AM, nmeeramohide@micron.com wrote:
> > +	if (_IOC_TYPE(cmd) != MPIOC_MAGIC)
> Hi,
> 
> MPIOC_MAGIC is defined in patch 01/22.
> It should also be added to Documentation/userspace-api/ioctl/ioctl-number.rst.
> 

Sure, thanks! I've made a note of this and will address it in v2.

Thanks,
Nabeel
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

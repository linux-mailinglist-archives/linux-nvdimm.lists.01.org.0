Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9B5A389
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 20:29:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E2D1212AB4F8;
	Fri, 28 Jun 2019 11:29:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.3.58; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4654A21237ABE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 11:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=SMGjLKbDUPfnf9EYwqTLq1tumGoualfPfZcFgUBrEzxzlqL/SVk3jtE5n9dT2tOgXbmj9lBwtsvItQONYVwwr5YfzL8oruGtdHK8n1yZklIdQeNlQZ01vC9+f3RSEKPH/fr3Re4hHu0z8fC0KIRg7c9+19rrwDox0/hNIeYC3b8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW+4ZnzFUxI2thr+G8Np8e2Oaw4bAbhf7CTAtwXVS7w=;
 b=XA9ftZejVn45JWnTwlvetjfcxwbhqKfzuI3izLVSnEYc9VQemMGteuUAyAVrpeKuLkJIT302YxzUg27XJQW/0988mEqMEeO0tQmLJrfKXyD4vaqSjxdd9qbfNfrlYTolHJ4xLjagtiu9BgCJ2iyCHiqF3okOMTCvJM0pprTAjp0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW+4ZnzFUxI2thr+G8Np8e2Oaw4bAbhf7CTAtwXVS7w=;
 b=i/sq3VFp3C08XaTuKwHLxcVYHPXIaNzhEuu3F3FguK6s4f+v0TYSCoJH2ugmmoXVU6n5/DNhHQNaWKQmEIMLgq5RWK0e1Er/GxWZs+smSRYlWXAF/zxXR48Wo9swMfK8cs9srf9qNSeH2CyPNtX0djywJbltIyU2UZb4thfbaC4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4365.eurprd05.prod.outlook.com (52.133.12.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 18:29:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 18:29:30 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Topic: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Index: AQHVLBqgvimki3zmIk2l4xtSxGbkyKaxNtmAgAANxQCAAAmqgIAAAboAgAAAeQCAABYfAA==
Date: Fri, 28 Jun 2019 18:29:29 +0000
Message-ID: <20190628182922.GA15242@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de> <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
 <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
In-Reply-To: <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.14.1.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92287021-7090-4314-de00-08d6fbf68ed6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4365; 
x-ms-traffictypediagnostic: VI1PR05MB4365:
x-microsoft-antispam-prvs: <VI1PR05MB43657FBDB1EA58C053C63BC0CFFC0@VI1PR05MB4365.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39840400004)(376002)(136003)(199004)(189003)(66476007)(486006)(6512007)(33656002)(66946007)(7416002)(6916009)(71200400001)(2906002)(73956011)(64756008)(36756003)(66556008)(71190400001)(68736007)(66066001)(1076003)(305945005)(99286004)(7736002)(6506007)(102836004)(53546011)(6116002)(66446008)(316002)(81156014)(52116002)(54906003)(8936002)(14454004)(5660300002)(2616005)(476003)(386003)(26005)(6246003)(53936002)(25786009)(86362001)(76176011)(6486002)(4326008)(229853002)(14444005)(3846002)(186003)(11346002)(6436002)(81166006)(446003)(478600001)(256004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4365;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NndW95S8YhHhIuIPXgE6DJ7FFQ7Wi7Qv94ks4fGecraJJl1kl/B/OiUhXXk9d64RAObNBGQNxj/+Dsy5mCDDXsBwBDTWMuw3tjOuwTSgwG5PzhEEsvNDJf9XW+MPpKaSIsZv/rs4/U1oe22/ThS4DnCfmYBIFdhumeofar4MDc1jemYw0XIYXX8bU9TB+TOtLL3E7d3f4yPyOPANELn3trWurneIuwVvOkzGEBz4dpp7ebk/fyq+oyUj00Dl1Sgj+X8NHddMhnD3WgJiL9qTBSapgYgKOkVLUcxF56u40YYlfwNZXXBi5FOP0gnYxu24VP8w25yfd0HTdOMjiy1SlXg4j33ovwiSGHGgr9YOfs+e/FuwerlAr0ZU/nj91QnAncOQQTkPfIx9yX5IeyPw9IJWGZeEyz3r0NamJ8DV4Fo=
Content-ID: <14F6B0C5B925FB4B8ECAEFC2C0B435B0@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92287021-7090-4314-de00-08d6fbf68ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 18:29:30.0154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4365
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 10:10:12AM -0700, Dan Williams wrote:
> On Fri, Jun 28, 2019 at 10:08 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > > > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > > >
> > > > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > > > The functionality is identical to the one currently open coded in
> > > > > > device-dax.
> > > > > >
> > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > > >  drivers/dax/dax-private.h |  4 ----
> > > > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > > > >  2 files changed, 47 deletions(-)
> > > > >
> > > > > DanW: I think this series has reached enough review, did you want
> > > > > to ack/test any further?
> > > > >
> > > > > This needs to land in hmm.git soon to make the merge window.
> > > >
> > > > I was awaiting a decision about resolving the collision with Ira's
> > > > patch before testing the final result again [1]. You can go ahead and
> > > > add my reviewed-by for the series, but my tested-by should be on the
> > > > final state of the series.
> > >
> > > The conflict looks OK to me, I think we can let Andrew and Linus
> > > resolve it.
> >
> > Andrew's tree effectively always rebases since it's a quilt series.
> > I'd recommend pulling Ira's patch out of -mm and applying it with the
> > rest of hmm reworks. Any other git tree I'd agree with just doing the
> > late conflict resolution, but I'm not clear on what's the best
> > practice when conflicting with -mm.

What happens depends on timing as things arrive to Linus. I promised
to send hmm.git early, so I understand that Andrew will quilt rebase
his tree to Linus's and fix the conflict in Ira's patch before he
sends it.

> Regardless the patch is buggy. If you want to do the conflict
> resolution it should be because the DEVICE_PUBLIC removal effectively
> does the same fix otherwise we're knowingly leaving a broken point in
> the history.

I'm not sure I understand your concern, is there something wrong with
CH's series as it stands? hmm is a non-rebasing git tree, so as long
as the series is correct *when I apply it* there is no broken history.

I assumed the conflict resolution for Ira's patch was to simply take
the deletion of the if block from CH's series - right?

If we do need to take Ira's patch into hmm.git it will go after CH's
series (and Ira will have to rebase/repost it), so I think there is
nothing to do at this moment - unless you are saying there is a
problem with the series in CH's git tree?

Regards,
Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

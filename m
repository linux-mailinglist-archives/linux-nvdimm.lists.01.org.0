Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31726A3DD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 13:09:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 026931404C1E4;
	Tue, 15 Sep 2020 04:09:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D9131404C1E3
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600168165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3elvcHYk5IARaG+8dg+B/xPu9csJdRPQUfuDredti0=;
	b=cg7f56F+FW+lxGreilGa5gKPCZw5QkBd3YnCGrZa6zkSxydwmmjtarMsuWPzK+A3Ks2uq5
	nis8jq72aZeGPjYziHwW1ZInn01pdyI4P2L2u1x7xYqsSnfL9D8uds28imZJgmQp9u5Gbc
	pohUz8fdvNlx0QWOW/p4+xdqnDYi6m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-whPXAj2IMsKfv5Hdd9FagQ-1; Tue, 15 Sep 2020 07:09:21 -0400
X-MC-Unique: whPXAj2IMsKfv5Hdd9FagQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE000801ADF;
	Tue, 15 Sep 2020 11:09:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A68355DDDE;
	Tue, 15 Sep 2020 11:09:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08FB9GZ4030093;
	Tue, 15 Sep 2020 07:09:16 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08FB9FOp030089;
	Tue, 15 Sep 2020 07:09:15 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 15 Sep 2020 07:09:15 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Adrian Huang12 <ahuang12@lenovo.com>
Subject: RE: [External]  regression caused by patch 6180bb446ab624b9ab8bf201ed251ca87f07b413
 ("dax: fix detection of dax support for non-persistent memory block
 devices")
In-Reply-To: <HK2PR0302MB259490E9D3F212396ACD0109B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
Message-ID: <alpine.LRH.2.02.2009150708460.29996@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com> <HK2PR0302MB259490E9D3F212396ACD0109B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mpatocka@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Message-ID-Hash: J3Y4LYAWGNRSEZJJ63B5AHTWHZKRQK74
X-Message-ID-Hash: J3Y4LYAWGNRSEZJJ63B5AHTWHZKRQK74
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Coly Li <colyli@suse.de>, Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J3Y4LYAWGNRSEZJJ63B5AHTWHZKRQK74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 15 Sep 2020, Adrian Huang12 wrote:

> Hi Mikulas,
> 
> > -----Original Message-----
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Sent: Monday, September 14, 2020 11:49 PM
> > To: Coly Li <colyli@suse.de>; Dan Williams <dan.j.williams@intel.com>; Dave
> > Jiang <dave.jiang@intel.com>
> > Cc: Jan Kara <jack@suse.com>; Vishal Verma <vishal.l.verma@intel.com>;
> > Adrian Huang12 <ahuang12@lenovo.com>; Ira Weiny <ira.weiny@intel.com>;
> > Mike Snitzer <snitzer@redhat.com>; Pankaj Gupta
> > <pankaj.gupta.linux@gmail.com>; linux-nvdimm@lists.01.org
> > Subject: [External] regression caused by patch
> > 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax
> > support for non-persistent memory block devices")
> > 
> > Hi
> > 
> > The patch 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix
> > detection of dax support for non-persistent memory block devices") causes
> > crash when attempting to mount the ext4 filesystem on /dev/pmem0
> > ("mkfs.ext4 /dev/pmem0; mount -t ext4 /dev/pmem0 /mnt/test"). The device
> > /dev/pmem0 is emulated using the "memmap" kernel parameter.
> > 
> 
> Could you please test the following patch? Thanks.
> https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2/

I tested it and it works.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

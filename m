Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6481B1A96
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Apr 2020 02:15:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 800CC100A028B;
	Mon, 20 Apr 2020 17:15:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53DAB100A027E
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 17:14:54 -0700 (PDT)
IronPort-SDR: TaNB3GICD7Le/x5MJr5qSoXEJmoKwOL2ULIkhCYIX1UKIfoBXlaggC4oQKxTWimrXqMMjcQans
 3sQ2aRwAyWkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:14:45 -0700
IronPort-SDR: B9UgK6aTUs5TQMh3rTlex+wdoRwmpjxEazW9iBWkeBAuGTQ+aOfqPpJ4ifs2yBDjKu4q9o9Rmc
 cD+OfwOtpKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200";
   d="scan'208";a="243999155"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2020 17:14:44 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 17:14:44 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.87]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 17:14:44 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH v5] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v5] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWFEIECEG69Pt18UScZqzwUBMWk6h9UlaAgAXeMwA=
Date: Tue, 21 Apr 2020 00:14:43 +0000
Message-ID: <5c0459c661560e22f77a73878b59d250f30750f7.camel@intel.com>
References: <20200416225438.15208-1-vishal.l.verma@intel.com>
	 <20200417063807.GE26707@dhcp22.suse.cz>
In-Reply-To: <20200417063807.GE26707@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <86E1CC51F340F84A8D8DD20059DE2CFF@intel.com>
MIME-Version: 1.0
Message-ID-Hash: MBRNXDMDY7DF3J6L6ZHXUG23UDLU5ZVA
X-Message-ID-Hash: MBRNXDMDY7DF3J6L6ZHXUG23UDLU5ZVA
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "david@redhat.com" <david@redhat.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MBRNXDMDY7DF3J6L6ZHXUG23UDLU5ZVA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-04-17 at 08:38 +0200, Michal Hocko wrote:
> On Thu 16-04-20 16:54:38, Vishal Verma wrote:
> > A misbehaving qemu created a situation where the ACPI SRAT table
> > advertised one fewer proximity domains than intended. The NFIT table did
> > describe all the expected proximity domains. This caused the device dax
> > driver to assign an impossible target_node to the device, and when
> > hotplugged as system memory, this would fail with the following
> > signature:
> > 
> >   [  +0.001627] BUG: kernel NULL pointer dereference, address: 0000000000000088
> >   [  +0.001331] #PF: supervisor read access in kernel mode
> >   [  +0.000975] #PF: error_code(0x0000) - not-present page
> >   [  +0.000976] PGD 80000001767d4067 P4D 80000001767d4067 PUD 10e0c4067 PMD 0
> >   [  +0.001338] Oops: 0000 [#1] SMP PTI
> >   [  +0.000676] CPU: 4 PID: 22737 Comm: kswapd3 Tainted: G           O      5.6.0-rc5 #9
> >   [  +0.001457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> >       BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >   [  +0.001990] RIP: 0010:prepare_kswapd_sleep+0x7c/0xc0
> >   [  +0.000780] Code: 89 df e8 87 fd ff ff 89 c2 31 c0 84 d2 74 e6 0f 1f 44
> >                       00 00 48 8b 05 fb af 7a 01 48 63 93 88 1d 01 00 48 8b
> > 		      84 d0 20 0f 00 00 <48> 3b 98 88 00 00 00 75 28 f0 80 a0
> > 		      80 00 00 00 fe f0 80 a3 38 20
> >   [  +0.002877] RSP: 0018:ffffc900017a3e78 EFLAGS: 00010202
> >   [  +0.000805] RAX: 0000000000000000 RBX: ffff8881209e0000 RCX: 0000000000000000
> >   [  +0.001115] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff8881209e0e80
> >   [  +0.001098] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000008000
> >   [  +0.001092] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000003
> >   [  +0.001092] R13: 0000000000000003 R14: 0000000000000000 R15: ffffc900017a3ec8
> >   [  +0.001091] FS:  0000000000000000(0000) GS:ffff888318c00000(0000) knlGS:0000000000000000
> >   [  +0.001275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [  +0.000882] CR2: 0000000000000088 CR3: 0000000120b50002 CR4: 00000000001606e0
> >   [  +0.001095] Call Trace:
> >   [  +0.000388]  kswapd+0x103/0x520
> >   [  +0.000494]  ? finish_wait+0x80/0x80
> >   [  +0.000547]  ? balance_pgdat+0x5a0/0x5a0
> >   [  +0.000607]  kthread+0x120/0x140
> >   [  +0.000508]  ? kthread_create_on_node+0x60/0x60
> >   [  +0.000706]  ret_from_fork+0x3a/0x50
> > 
> > Add a check in the add_memory path to fail if the node to which we
> > are adding memory is in the node_possible_map
> > 
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> We can start thiking on how to handle such a misconfiguration more
> gracefully when we see this hitting in real world and find out more why
> that happens. E.g. if a FW/BIOS are not fixable then we can implement
> some fallback strategy but this should be a good start.
> 
> Thanks!

Thank you for the review Michal.

Should this go via Andrew and the mm tree?

> 
> > ---
> >  mm/memory_hotplug.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > v2:
> > - Centralize the check in the add_memory path (David)
> > - Instead of failing, add the memory to a nearby node, while warning
> >   (and tainting) to call out attention to the firmware bug (Dan)
> > 
> > v3:
> > - Fix the CONFIG_NUMA=n case, and use node 0 as the final fallback (Dan)
> > 
> > v4:
> > - Error out instead of being smart about picking a node that wasn't
> >   asked for (Michal)
> > 
> > v5:
> > - Change the return code to -EINVAL (David)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 0a54ffac8c68..e07b80d149db 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1005,6 +1005,11 @@ int __ref add_memory_resource(int nid, struct resource *res)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!node_possible(nid)) {
> > +		WARN(1, "node %d was absent from the node_possible_map\n", nid);
> > +		return -EINVAL;
> > +	}
> > +
> >  	mem_hotplug_begin();
> >  
> >  	/*
> > -- 
> > 2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

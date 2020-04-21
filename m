Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21601B1EF4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Apr 2020 08:44:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1EAC100A0298;
	Mon, 20 Apr 2020 23:44:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.67; helo=mail-wr1-f67.google.com; envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 88521100A0292
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 23:44:35 -0700 (PDT)
Received: by mail-wr1-f67.google.com with SMTP id t14so15063642wrw.12
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 23:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rt6nWbLDz2zfNJRwiDwyt40cwBlJAiz4+TqRx7f7T1Y=;
        b=rkq9Bl46wQ6cy0kYkQIZmnzrWrxabiPgXQCrvafZwar/nMcrRJANU4MfGKUzkuw58P
         p+1E7dbMxgBJUHLy0I/tdDwsmP0DzInu86ysPuqZgb1iqFUCzcrq93l2Ohze6XyJjXqE
         T/wVhUjY+ZCZjVha8my341bFogyLrmt4bhlrHMzROaJOSzLAnHtzdIw2oPHmx6gnPPLh
         YGfDRLSM4ylJNBdnzgjH3rjuv8XeSVFDhikYFmgxSfg7EyagPz/pTJRdiKDh+w5Oe6W6
         Y3UGb3JKoYNfnyqYuHEZX28fI4ru42blLXGL98X/U92/nQmJCW7v9rVFM1Qu8oMfWif+
         gHjw==
X-Gm-Message-State: AGi0PuZ4d7qA8Uhsczk7aU0Ok39RL/e5VxBDMO2xF1usFp53mZD/IeaX
	YCqkaoIQhS+U9TohXn8xqNw=
X-Google-Smtp-Source: APiQypKr6Ux6TBE3lTwC21NjSTuR48TTmDpy39n7c0Ku/5u+Ycj0sPmEZzdZMJdKu0Mj/TKv6tA8tA==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr21554746wrv.86.1587451482894;
        Mon, 20 Apr 2020 23:44:42 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id m15sm2141153wmc.35.2020.04.20.23.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 23:44:41 -0700 (PDT)
Date: Tue, 21 Apr 2020 08:44:40 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH v5] mm/memory_hotplug: refrain from adding memory into an
 impossible node
Message-ID: <20200421064440.GY27314@dhcp22.suse.cz>
References: <20200416225438.15208-1-vishal.l.verma@intel.com>
 <20200417063807.GE26707@dhcp22.suse.cz>
 <5c0459c661560e22f77a73878b59d250f30750f7.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c0459c661560e22f77a73878b59d250f30750f7.camel@intel.com>
Message-ID-Hash: VPTZ2LKS7XZ7S7FFFLGFHFZD6TYRXBCJ
X-Message-ID-Hash: VPTZ2LKS7XZ7S7FFFLGFHFZD6TYRXBCJ
X-MailFrom: mstsxfx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "david@redhat.com" <david@redhat.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VPTZ2LKS7XZ7S7FFFLGFHFZD6TYRXBCJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 21-04-20 00:14:43, Verma, Vishal L wrote:
> On Fri, 2020-04-17 at 08:38 +0200, Michal Hocko wrote:
> > On Thu 16-04-20 16:54:38, Vishal Verma wrote:
> > > A misbehaving qemu created a situation where the ACPI SRAT table
> > > advertised one fewer proximity domains than intended. The NFIT table did
> > > describe all the expected proximity domains. This caused the device dax
> > > driver to assign an impossible target_node to the device, and when
> > > hotplugged as system memory, this would fail with the following
> > > signature:
> > > 
> > >   [  +0.001627] BUG: kernel NULL pointer dereference, address: 0000000000000088
> > >   [  +0.001331] #PF: supervisor read access in kernel mode
> > >   [  +0.000975] #PF: error_code(0x0000) - not-present page
> > >   [  +0.000976] PGD 80000001767d4067 P4D 80000001767d4067 PUD 10e0c4067 PMD 0
> > >   [  +0.001338] Oops: 0000 [#1] SMP PTI
> > >   [  +0.000676] CPU: 4 PID: 22737 Comm: kswapd3 Tainted: G           O      5.6.0-rc5 #9
> > >   [  +0.001457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > >       BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > >   [  +0.001990] RIP: 0010:prepare_kswapd_sleep+0x7c/0xc0
> > >   [  +0.000780] Code: 89 df e8 87 fd ff ff 89 c2 31 c0 84 d2 74 e6 0f 1f 44
> > >                       00 00 48 8b 05 fb af 7a 01 48 63 93 88 1d 01 00 48 8b
> > > 		      84 d0 20 0f 00 00 <48> 3b 98 88 00 00 00 75 28 f0 80 a0
> > > 		      80 00 00 00 fe f0 80 a3 38 20
> > >   [  +0.002877] RSP: 0018:ffffc900017a3e78 EFLAGS: 00010202
> > >   [  +0.000805] RAX: 0000000000000000 RBX: ffff8881209e0000 RCX: 0000000000000000
> > >   [  +0.001115] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff8881209e0e80
> > >   [  +0.001098] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000008000
> > >   [  +0.001092] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000003
> > >   [  +0.001092] R13: 0000000000000003 R14: 0000000000000000 R15: ffffc900017a3ec8
> > >   [  +0.001091] FS:  0000000000000000(0000) GS:ffff888318c00000(0000) knlGS:0000000000000000
> > >   [  +0.001275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   [  +0.000882] CR2: 0000000000000088 CR3: 0000000120b50002 CR4: 00000000001606e0
> > >   [  +0.001095] Call Trace:
> > >   [  +0.000388]  kswapd+0x103/0x520
> > >   [  +0.000494]  ? finish_wait+0x80/0x80
> > >   [  +0.000547]  ? balance_pgdat+0x5a0/0x5a0
> > >   [  +0.000607]  kthread+0x120/0x140
> > >   [  +0.000508]  ? kthread_create_on_node+0x60/0x60
> > >   [  +0.000706]  ret_from_fork+0x3a/0x50
> > > 
> > > Add a check in the add_memory path to fail if the node to which we
> > > are adding memory is in the node_possible_map
> > > 
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > We can start thiking on how to handle such a misconfiguration more
> > gracefully when we see this hitting in real world and find out more why
> > that happens. E.g. if a FW/BIOS are not fixable then we can implement
> > some fallback strategy but this should be a good start.
> > 
> > Thanks!
> 
> Thank you for the review Michal.
> 
> Should this go via Andrew and the mm tree?

Yes, this is the usual route for memory hotplug patches.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

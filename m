Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71331D24A3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 May 2020 03:25:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09A6611AE62EB;
	Wed, 13 May 2020 18:22:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=<UNKNOWN> 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5028111AE2B32
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 18:22:41 -0700 (PDT)
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04E1PCQp014833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2020 21:25:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
	id 391134202E4; Wed, 13 May 2020 21:25:12 -0400 (EDT)
Date: Wed, 13 May 2020 21:25:12 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: How to fake a dax device for debugging purposes?
Message-ID: <20200514012512.GK1596452@mit.edu>
References: <20200511015404.GA1490816@mit.edu>
 <CAPcyv4gotnFKCw8+p+DbT30E7eEix3mDkCbHJz9BA4DfeJOKig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gotnFKCw8+p+DbT30E7eEix3mDkCbHJz9BA4DfeJOKig@mail.gmail.com>
Message-ID-Hash: 4QBI7WG57VHY26WY4S7ESK5SGHAFCXSJ
X-Message-ID-Hash: 4QBI7WG57VHY26WY4S7ESK5SGHAFCXSJ
X-MailFrom: tytso@mit.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QBI7WG57VHY26WY4S7ESK5SGHAFCXSJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 11, 2020 at 11:38:45AM -0700, Dan Williams wrote:
> Might you have disabled CONFIG_ZONE_DEVICE? That allows the pmem
> driver to map 'struct page' for pmem and is required for DAX.

Yep that's it!  Apparently there have been changes so that the "make
olddefconfig" starting with [1] doesn't result in CONFIG_ZONE_DEVICE
being defined any more.  I'll fix that...

[1] https://github.com/tytso/xfstests-bld/blob/master/kernel-configs/x86_64-config-5.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

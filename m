Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C52745A6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 17:44:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2749142AE4DC;
	Tue, 22 Sep 2020 08:44:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C438142638AD
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 08:44:01 -0700 (PDT)
IronPort-SDR: KLiVLeOzp6wtx/9iMSJXbxZLvNY4YP5/yAYMk5z8W0x2nNMg1CDyIVdQ3Ewb2gTgPCHAQgAbBD
 U/CveLhS8Ilw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="140639226"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400";
   d="scan'208";a="140639226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 08:44:00 -0700
IronPort-SDR: CrBX6uCXF/Ea+FOpNE7cJh8tZR89yO3TH83yCb8vusQ0t2a2qis7v6kd/QGYtfr1T+ca/2ACIf
 8+8dfadffPrg==
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400";
   d="scan'208";a="486006776"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 08:44:00 -0700
Date: Tue, 22 Sep 2020 08:43:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
Message-ID: <20200922154359.GT2540965@iweiny-DESK2.sc.intel.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 6IZOOGU7AJTUHCTN4ZTAOVIUFHTW3VMO
X-Message-ID-Hash: 6IZOOGU7AJTUHCTN4ZTAOVIUFHTW3VMO
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6IZOOGU7AJTUHCTN4ZTAOVIUFHTW3VMO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2020 at 12:19:07PM -0400, Mikulas Patocka wrote:
> 
> 
> On Tue, 15 Sep 2020, Dan Williams wrote:
> 
> > > TODO:
> > >
> > > - programs run approximately 4% slower when running from Optane-based
> > > persistent memory. Therefore, programs and libraries should use page cache
> > > and not DAX mapping.
> > 
> > This needs to be based on platform firmware data f(ACPI HMAT) for the
> > relative performance of a PMEM range vs DRAM. For example, this
> > tradeoff should not exist with battery backed DRAM, or virtio-pmem.
> 
> Hi
> 
> I have implemented this functionality - if we mmap a file with 
> (vma->vm_flags & VM_DENYWRITE), then it is assumed that this is executable 
> file mapping - the flag S_DAX on the inode is cleared on and the inode 
> will use normal page cache.
> 
> Is there some way how to test if we are using Optane-based module (where 
> this optimization should be applied) or battery backed DRAM (where it 
> should not)?
> 
> I've added mount options dax=never, dax=auto, dax=always, so that the user 
                                      ^^^^^^^^
				      dax=inode?

'inode' is the option used by ext4/xfs.

Ira

> can override the automatic behavior.
> 
> Mikulas
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

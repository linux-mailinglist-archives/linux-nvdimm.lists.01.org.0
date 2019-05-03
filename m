Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE512BD8
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 12:48:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87B9021244A77;
	Fri,  3 May 2019 03:48:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E36A221244A5F
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 03:48:38 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0A4E7AD89;
 Fri,  3 May 2019 10:48:37 +0000 (UTC)
Date: Fri, 3 May 2019 12:48:32 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
Message-ID: <20190503104831.GF15740@linux>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bBT=goxf5KWLhca7uQutUj9670aL9r02_+BsJ+bLkjj=g@mail.gmail.com>
 <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gWZxSepaACiyR43qytA1jR8fVaeLy1rv7dFJW-ZE63EA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 stable <stable@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 02, 2019 at 04:20:03PM -0700, Dan Williams wrote:
> On Thu, May 2, 2019 at 3:46 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > Hi Dan,
> >
> > How do you test these patches? Do you have any instructions?
> 
> Yes, I briefly mentioned this in the cover letter, but here is the
> test I am using:
> 
> >
> > I see for example that check_hotplug_memory_range() still enforces
> > memory_block_size_bytes() alignment.
> >
> > Also, after removing check_hotplug_memory_range(), I tried to online
> > 16M aligned DAX memory, and got the following panic:
> 
> Right, this functionality is currently strictly limited to the
> devm_memremap_pages() case where there are guarantees that the memory
> will never be onlined. This is due to the fact that the section size
> is entangled with the memblock api. That said I would have expected
> you to trigger the warning in subsection_check() before getting this
> far into the hotplug process.
> >
> > # echo online > /sys/devices/system/memory/memory7/state
> > [  202.193132] WARNING: CPU: 2 PID: 351 at drivers/base/memory.c:207
> > memory_block_action+0x110/0x178
> > [  202.193391] Modules linked in:
> > [  202.193698] CPU: 2 PID: 351 Comm: sh Not tainted
> > 5.1.0-rc7_pt_devdax-00038-g865af4385544-dirty #9
> > [  202.193909] Hardware name: linux,dummy-virt (DT)
> > [  202.194122] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [  202.194243] pc : memory_block_action+0x110/0x178
> > [  202.194404] lr : memory_block_action+0x90/0x178
> > [  202.194506] sp : ffff000016763ca0
> > [  202.194592] x29: ffff000016763ca0 x28: ffff80016fd29b80
> > [  202.194724] x27: 0000000000000000 x26: 0000000000000000
> > [  202.194838] x25: ffff000015546000 x24: 00000000001c0000
> > [  202.194949] x23: 0000000000000000 x22: 0000000000040000
> > [  202.195058] x21: 00000000001c0000 x20: 0000000000000008
> > [  202.195168] x19: 0000000000000007 x18: 0000000000000000
> > [  202.195281] x17: 0000000000000000 x16: 0000000000000000
> > [  202.195393] x15: 0000000000000000 x14: 0000000000000000
> > [  202.195505] x13: 0000000000000000 x12: 0000000000000000
> > [  202.195614] x11: 0000000000000000 x10: 0000000000000000
> > [  202.195744] x9 : 0000000000000000 x8 : 0000000180000000
> > [  202.195858] x7 : 0000000000000018 x6 : ffff000015541930
> > [  202.195966] x5 : ffff000015541930 x4 : 0000000000000001
> > [  202.196074] x3 : 0000000000000001 x2 : 0000000000000000
> > [  202.196185] x1 : 0000000000000070 x0 : 0000000000000000
> > [  202.196366] Call trace:
> > [  202.196455]  memory_block_action+0x110/0x178
> > [  202.196589]  memory_subsys_online+0x3c/0x80
> > [  202.196681]  device_online+0x6c/0x90
> > [  202.196761]  state_store+0x84/0x100
> > [  202.196841]  dev_attr_store+0x18/0x28
> > [  202.196927]  sysfs_kf_write+0x40/0x58
> > [  202.197010]  kernfs_fop_write+0xcc/0x1d8
> > [  202.197099]  __vfs_write+0x18/0x40
> > [  202.197187]  vfs_write+0xa4/0x1b0
> > [  202.197295]  ksys_write+0x64/0xd8
> > [  202.197430]  __arm64_sys_write+0x18/0x20
> > [  202.197521]  el0_svc_common.constprop.0+0x7c/0xe8
> > [  202.197621]  el0_svc_handler+0x28/0x78
> > [  202.197706]  el0_svc+0x8/0xc
> > [  202.197828] ---[ end trace 57719823dda6d21e ]---

This warning relates to:

        for (; section_nr < section_nr_end; section_nr++) {
                if (WARN_ON_ONCE(!pfn_valid(pfn)))
                        return false;

from pages_correctly_probed().
AFAICS, this is orthogonal to subsection_check().


-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

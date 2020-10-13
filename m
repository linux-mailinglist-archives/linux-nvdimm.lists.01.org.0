Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE7328D5BF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Oct 2020 22:50:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4194B15E3E2FE;
	Tue, 13 Oct 2020 13:50:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DC6615E3E2FE
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 13:50:16 -0700 (PDT)
IronPort-SDR: vykgMeQ7VUYES5Fb6uL+JoAfn8fyZhGBtVikYVZbcZsrC5AzdHo4TEsFIT7e7x9WQkcJQjdHri
 jbOdt48yAKjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166045233"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400";
   d="scan'208";a="166045233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 13:50:14 -0700
IronPort-SDR: tBU8Od+WgzKnoE84+DWDWPkln+je7r0O2Nptsn2TVKPsgnriflj5gQkH1GYPWlpzBZ1iqAqtCk
 /srhQcj0pjbQ==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400";
   d="scan'208";a="318439699"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 13:50:12 -0700
Date: Tue, 13 Oct 2020 13:50:12 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC PKS/PMEM 33/58] fs/cramfs: Utilize new kmap_thread()
Message-ID: <20201013205012.GI2046448@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-34-ira.weiny@intel.com>
 <CAPcyv4gL3jfw4d+SJGPqAD3Dp4F_K=X3domuN4ndAA1FQDGcPg@mail.gmail.com>
 <20201013193643.GK20115@casper.infradead.org>
 <20201013200149.GI3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201013200149.GI3576660@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ZQIBY6UBBL62QDHXFUUU243V25CQNSBY
X-Message-ID-Hash: ZQIBY6UBBL62QDHXFUUU243V25CQNSBY
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nico@fluxnic.net>, X86 ML <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi <linux-efi@vger.kernel.org>, linux-mmc@vger.kernel.org, li
 nux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-afs@lists.infradead.org, linux-rdma <linux-rdma@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZQIBY6UBBL62QDHXFUUU243V25CQNSBY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 09:01:49PM +0100, Al Viro wrote:
> On Tue, Oct 13, 2020 at 08:36:43PM +0100, Matthew Wilcox wrote:
> 
> > static inline void copy_to_highpage(struct page *to, void *vfrom, unsigned int size)
> > {
> > 	char *vto = kmap_atomic(to);
> > 
> > 	memcpy(vto, vfrom, size);
> > 	kunmap_atomic(vto);
> > }
> > 
> > in linux/highmem.h ?
> 
> You mean, like
> static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t len)
> {
>         char *from = kmap_atomic(page);
>         memcpy(to, from + offset, len);
>         kunmap_atomic(from);
> }
> 
> static void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
> {
>         char *to = kmap_atomic(page);
>         memcpy(to + offset, from, len);
>         kunmap_atomic(to);
> }
> 
> static void memzero_page(struct page *page, size_t offset, size_t len)
> {
>         char *addr = kmap_atomic(page);
>         memset(addr + offset, 0, len);
>         kunmap_atomic(addr);
> }
> 
> in lib/iov_iter.c?  FWIW, I don't like that "highpage" in the name and
> highmem.h as location - these make perfect sense regardless of highmem;
> they are normal memory operations with page + offset used instead of
> a pointer...

I was thinking along those lines as well especially because of the direction
this patch set takes kmap().

Thanks for pointing these out to me.  How about I lift them to a common header?
But if not highmem.h where?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

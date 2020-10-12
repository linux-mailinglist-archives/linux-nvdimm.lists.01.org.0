Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029F28ADA0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 07:28:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2847158C110B;
	Sun, 11 Oct 2020 22:28:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 41E19158BD04B
	for <linux-nvdimm@lists.01.org>; Sun, 11 Oct 2020 22:28:24 -0700 (PDT)
IronPort-SDR: Mui+awipRrHu+EwyrhLxpPdcYc6JINKOOcrCW4BypPaOP4HaxbJxpOxIb9usg9d4zGpzpLoOeW
 H67Z4DtEUZ4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145556283"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400";
   d="scan'208";a="145556283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:28:23 -0700
IronPort-SDR: Awdi9Evv+UAQx0jH4ny/s7+Nxcmli85F+a73BOsSCHQvCG+q13xwJ2JLwUM5pKItlqpgm8qi5b
 o2XGvRLHUUbw==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400";
   d="scan'208";a="529816997"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 22:28:22 -0700
Date: Sun, 11 Oct 2020 22:28:18 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH RFC PKS/PMEM 48/58] drivers/md: Utilize new kmap_thread()
Message-ID: <20201012052817.GZ2046448@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-49-ira.weiny@intel.com>
 <c802fbf4-f67a-b205-536d-9c71b440f9c8@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c802fbf4-f67a-b205-536d-9c71b440f9c8@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 7U4PUTDELNV47B3X4G4SAB3VAU2WOHLA
X-Message-ID-Hash: 7U4PUTDELNV47B3X4G4SAB3VAU2WOHLA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@l
 ists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7U4PUTDELNV47B3X4G4SAB3VAU2WOHLA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 10, 2020 at 10:20:34AM +0800, Coly Li wrote:
> On 2020/10/10 03:50, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > These kmap() calls are localized to a single thread.  To avoid the over
> > head of global PKRS updates use the new kmap_thread() call.
> > 
> 
> Hi Ira,
> 
> There were a number of options considered.
> 
> 1) Attempt to change all the thread local kmap() calls to kmap_atomic()
> 2) Introduce a flags parameter to kmap() to indicate if the mapping
> should be global or not
> 3) Change ~20-30 call sites to 'kmap_global()' to indicate that they
> require a global mapping of the pages
> 4) Change ~209 call sites to 'kmap_thread()' to indicate that the
> mapping is to be used within that thread of execution only
> 
> 
> I copied the above information from patch 00/58 to this message. The
> idea behind kmap_thread() is fine to me, but as you said the new api is
> very easy to be missed in new code (even for me). I would like to be
> supportive to option 2) introduce a flag to kmap(), then we won't forget
> the new thread-localized kmap method, and people won't ask why a
> _thread() function is called but no kthread created.

Thanks for the feedback.

I'm going to hold off making any changes until others weigh in.  FWIW, I kind
of like option 2 as well.  But there is already kmap_atomic() so it seemed like
kmap_XXXX() was more in line with the current API.

Thanks,
Ira

> 
> Thanks.
> 
> 
> Coly Li
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

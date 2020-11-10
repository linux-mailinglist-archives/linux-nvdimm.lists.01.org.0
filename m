Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261EA2AD1A0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 09:48:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62365166C6140;
	Tue, 10 Nov 2020 00:48:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E147166B98C3
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 00:48:34 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604998111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lFM+Dy1hrzRRrrrA3qnbGkxEtyVqIh0g4peYrriLeU=;
	b=iuo8f+7vFglLggVRQElkiZ2WEkqCMbTG8xoMGtVyBk3DBfZOlzK9bn4iYE9n5TJlXEeyiw
	mK2AsUoeE727uJ+eyVgbEeyt2qz1CsngbkfMTC30zg6BSGbxrFxVJV/nTlcmtj9NHSMsJn
	sU38ljGJ30NJ8ooIZ53QTax6dO6NfnLLpRxklxBphTMVejdacYZZqkmCK8e4gkxhfN2Hq9
	zuGNw+h8VUH3NFZO14JlYgbkNPH833xVYFQ2lmqEAC35a4/baTqfi6uG7ey36+HQyygrEi
	Jy4I41umlX4stejJrRBLu7awPrfWhbLcelHNMzqQQSqRZrKTpO34TDntXU+02A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604998111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lFM+Dy1hrzRRrrrA3qnbGkxEtyVqIh0g4peYrriLeU=;
	b=y7osrUd/437dzM5/Hc5G9cQ/HuZ2jh7vgX8EDHSswmJuPLkHyLG6iEX8rrCl2sg3XohELe
	1aQhUu8PTNjq+DAw==
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC PKS/PMEM 05/58] kmap: Introduce k[un]map_thread
In-Reply-To: <20201110045954.GL3976735@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com> <20201009195033.3208459-6-ira.weiny@intel.com> <87h7pyhv3f.fsf@nanos.tec.linutronix.de> <20201110045954.GL3976735@iweiny-DESK2.sc.intel.com>
Date: Tue, 10 Nov 2020 09:48:31 +0100
Message-ID: <87eel1iom8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: KDLNZKUDLYPY2EQXL22NCYX4ATBOR6HF
X-Message-ID-Hash: KDLNZKUDLYPY2EQXL22NCYX4ATBOR6HF
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org
 , linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KDLNZKUDLYPY2EQXL22NCYX4ATBOR6HF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 09 2020 at 20:59, Ira Weiny wrote:
> On Tue, Nov 10, 2020 at 02:13:56AM +0100, Thomas Gleixner wrote:
> Also, we can convert the new memcpy_*_page() calls to kmap_local() as well.
> [For now my patch just uses kmap_atomic().]
>
> I've not looked at all of the patches in your latest version.  Have you
> included converting any of the kmap() call sites?  I thought you were more
> focused on converting the kmap_atomic() to kmap_local()?

I did not touch any of those yet, but it's a logical consequence to
convert all kmap() instances which are _not_ creating a global mapping
over to it.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

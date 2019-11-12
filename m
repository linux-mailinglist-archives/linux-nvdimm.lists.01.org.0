Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F6F9CB9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 23:02:19 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EF1B100DC415;
	Tue, 12 Nov 2019 14:04:01 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1D6A100DC415
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 14:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=7jAEbZsBzv3PFISvUcPFIFd7joU8uP8zZrxP8zk/r9M=; b=K16IxrZqUhqYgrANYfZo7ZnoD
	feYnXP9G733dvNL6/NsO3XGUkXqkNGRgGIRqKsPy38+Ued5nKS4GIFDNZhC5X7kAhq241K5uLSzHK
	cgqa7pAgkjuTVkfuyHdgHl3AawqxRhEQX5mFdKogL4n85ZBuXblzmmuSVRmEYCaReEhQTYtkVqdh/
	Ewg8hdV2JRyXaUqsBSBGiEGssfnGsfoTfpjqrwty7p9wEM50oTuSkQY1OZAoQUW87W5Xy7Ftm7fMf
	3W7ntvKrQMgeDFRIyqugl/z8IxQ0C895lbV5qQ3zgU+6Y7kbuGXRR3YjWZ73FpjOpGuU/AxrFAImg
	NseFvGxSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUeEm-0001EA-GF; Tue, 12 Nov 2019 22:02:12 +0000
Date: Tue, 12 Nov 2019 14:02:12 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: DAX filesystem support on ARMv8
Message-ID: <20191112220212.GC7934@bombadil.infradead.org>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
 <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Message-ID-Hash: AKMZVDRQBR24ELKX743DQ4RU2KAOZR7Y
X-Message-ID-Hash: AKMZVDRQBR24ELKX743DQ4RU2KAOZR7Y
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Bharat Kumar Gogada <bharatku@xilinx.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AKMZVDRQBR24ELKX743DQ4RU2KAOZR7Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 09:15:18AM -0800, Dan Williams wrote:
> On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada <bharatku@xilinx.com> wrote:
> >
> > Hi All,
> >
> > As per Documentation/filesystems/dax.txt
> >
> > The DAX code does not work correctly on architectures which have virtually
> > mapped caches such as ARM, MIPS and SPARC.
> >
> > Can anyone please shed light on dax filesystem issue w.r.t ARM architecture ?
> 
> The concern is VIVT caches since the kernel will want to flush pmem
> addresses with different virtual addresses than what userspace is
> using. As far as I know, ARMv8 has VIPT caches, so should not have an
> issue. Willy initially wrote those restrictions, but I am assuming
> that the concern was managing the caches in the presence of virtual
> aliases.

The kernel will also access data at different virtual addresses from
userspace.  So VIVT CPUs will be mmap/read/write incoherent, as well as
being flush incoherent.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

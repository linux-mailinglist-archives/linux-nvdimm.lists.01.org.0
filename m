Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5F314BA6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 10:34:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B11B100EAB53;
	Tue,  9 Feb 2021 01:34:44 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37415100EAB4D
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 01:34:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B90868BFE; Tue,  9 Feb 2021 10:34:38 +0100 (CET)
Date: Tue, 9 Feb 2021 10:34:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210209093438.GA630@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com> <20210208151920.GE12872@lst.de> <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: SZROXHL5JBQP4NALBYXYS5A3ADVDOMDB
X-Message-ID-Hash: SZROXHL5JBQP4NALBYXYS5A3ADVDOMDB
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SZROXHL5JBQP4NALBYXYS5A3ADVDOMDB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 09, 2021 at 05:15:13PM +0800, Ruan Shiyang wrote:
> The dax dedupe comparison need the iomap_ops pointer as argument, so my 
> understanding is that we don't modify the argument list of 
> generic_remap_file_range_prep(), but move its code into 
> __generic_remap_file_range_prep() whose argument list can be modified to 
> accepts the iomap_ops pointer.  Then it looks like this:

I'd say just add the iomap_ops pointer to
generic_remap_file_range_prep and do away with the extra wrappers.  We
only have three callers anyway.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

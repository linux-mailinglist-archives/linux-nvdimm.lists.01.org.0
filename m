Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5589324B4E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 08:35:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0ED34100EC1FA;
	Wed, 24 Feb 2021 23:35:33 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2227A100EC1CE
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 23:35:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D893868B05; Thu, 25 Feb 2021 08:35:25 +0100 (CET)
Date: Thu, 25 Feb 2021 08:35:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210225073525.GA3448@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com> <20210208151920.GE12872@lst.de> <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com> <20210209093438.GA630@lst.de> <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com> <20210210131928.GA30109@lst.de> <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com> <20210218162018.GT7193@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210218162018.GT7193@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 2T6GY7MCCZ6LGCJSZ53H2MU3SPBPM6R4
X-Message-ID-Hash: 2T6GY7MCCZ6LGCJSZ53H2MU3SPBPM6R4
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2T6GY7MCCZ6LGCJSZ53H2MU3SPBPM6R4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 18, 2021 at 08:20:18AM -0800, Darrick J. Wong wrote:
> > I think a nested call like this is necessary.  That's why I use the open
> > code way.
> 
> This might be a good place to implement an iomap_apply2() loop that
> actually /does/ walk all the extents of file1 and file2.  There's now
> two users of this idiom.

Why do we need a special helper for that?

> (Possibly structured as a "get next mappings from both" generator
> function like Matthew Wilcox keeps asking for. :))

OTOH this might be a good first use for that.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

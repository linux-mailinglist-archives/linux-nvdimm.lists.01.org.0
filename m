Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D3C32672E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 20:05:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54AAB100EAB60;
	Fri, 26 Feb 2021 11:04:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC8AB100EBBA2
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 11:04:55 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B1D464F1B;
	Fri, 26 Feb 2021 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1614366295;
	bh=PfeQuDYBIjQHtNJ4RxOXOTAV74C+Re27WPBrWtzUDU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGGKVLRykjmczWP3FyivF6q0SYw6J8EAG4OIZIx2MxP8mAiZ/Isk3756eCG1HlOdt
	 E/oCaXcPPD8hThBiCj/+yfoWeN0n2CjA/Z/05xkmNmTvaxvC1Tmwpj9PM+P6+2q7zT
	 1w2DKcFQSLF7aMWyQc2Zr1L3FiSB1ZR1/RjUmfWcmebygeM6qp0oenFuBe1DutDFWw
	 2iXkgZarGC5e6UNsbo+wm3l93zCTzETISjYVwRYJZGJwUvovCL9yboyyXfx4sLxw+y
	 qGOl89rmrHNo9QgYn5VEseoY1bwzOSPMtj4cw8YtZWrBYgo4prpP+aUsJsoXaYAW5S
	 kdxN4BoF0OWHg==
Date: Fri, 26 Feb 2021 11:04:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
Message-ID: <20210226190454.GD7272@magnolia>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Message-ID-Hash: SUWG7OE6LBUSUFB3RPCVIUXKHOZ2DZW7
X-Message-ID-Hash: SUWG7OE6LBUSUFB3RPCVIUXKHOZ2DZW7
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SUWG7OE6LBUSUFB3RPCVIUXKHOZ2DZW7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> Hi, guys
> 
> Beside this patchset, I'd like to confirm something about the
> "EXPERIMENTAL" tag for dax in XFS.
> 
> In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> when we mount a pmem device with dax option, has been existed for a
> while.  It's a bit annoying when using fsdax feature.  So, my initial
> intention was to remove this tag.  And I started to find out and solve
> the problems which prevent it from being removed.
> 
> As is talked before, there are 3 main problems.  The first one is "dax
> semantics", which has been resolved.  The rest two are "RMAP for
> fsdax" and "support dax reflink for filesystem", which I have been
> working on.  

<nod>

> So, what I want to confirm is: does it means that we can remove the
> "EXPERIMENTAL" tag when the rest two problem are solved?

Yes.  I'd keep the experimental tag for a cycle or two to make sure that
nothing new pops up, but otherwise the two patchsets you've sent close
those two big remaining gaps.  Thank you for working on this!

> Or maybe there are other important problems need to be fixed before
> removing it?  If there are, could you please show me that?

That remains to be seen through QA/validation, but I think that's it.

Granted, I still have to read through the two patchsets...

--D

> 
> Thank you.
> 
> 
> --
> Ruan Shiyang.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

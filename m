Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 483AF337293
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 13:30:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA8F1100EB827;
	Thu, 11 Mar 2021 04:30:09 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C064A100EBB81
	for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 04:30:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98CCA68B05; Thu, 11 Mar 2021 13:30:03 +0100 (CET)
Date: Thu, 11 Mar 2021 13:30:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [RESEND PATCH v2.1 07/10] iomap: Introduce iomap_apply2() for
 operations on two files
Message-ID: <20210311123002.GA18838@lst.de>
References: <20210226002030.653855-8-ruansy.fnst@fujitsu.com> <20210304054142.1147895-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210304054142.1147895-1-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: O3O6VAOEUD7E33H5XZ6BCCDYVPEEBFAP
X-Message-ID-Hash: O3O6VAOEUD7E33H5XZ6BCCDYVPEEBFAP
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O3O6VAOEUD7E33H5XZ6BCCDYVPEEBFAP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 04, 2021 at 01:41:42PM +0800, Shiyang Ruan wrote:
> Some operations, such as comparing a range of data in two files under
> fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
> we introduce iomap_apply2() to accept arguments from two files and
> iomap_actor2_t for actions on two files.

I still wonder if adding the iter based iomap API that willy proposed
would be a better fit here.  In that case we might not even need
a special API for the double iteration.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

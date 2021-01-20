Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92B2FCA15
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 05:47:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E5FA100EBB95;
	Tue, 19 Jan 2021 20:47:09 -0800 (PST)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.80; helo=mail109.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail109.syd.optusnet.com.au (mail109.syd.optusnet.com.au [211.29.132.80])
	by ml01.01.org (Postfix) with ESMTP id A0D39100EBB80
	for <linux-nvdimm@lists.01.org>; Tue, 19 Jan 2021 20:47:06 -0800 (PST)
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
	by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id C28BD114056B;
	Wed, 20 Jan 2021 15:47:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1l25OW-000Pbc-9B; Wed, 20 Jan 2021 15:47:00 +1100
Date: Wed, 20 Jan 2021 15:47:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Subject: Re: Expense of read_iter
Message-ID: <20210120044700.GA4626@dread.disaster.area>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
 <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
	a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
	a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
	a=9YBCWnU3LXitusiQSpoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: R7GN2GOBVO3XY6AUOVCL7Q562N42UC3O
X-Message-ID-Hash: R7GN2GOBVO3XY6AUOVCL7Q562N42UC3O
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mikulas Patocka <mpatocka@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, David Laight <David.Laight@aculab.com>, Mingkai Dong <mingkaidong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Wang Jianchao <jianchao.wan9@gmail.com>, Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7GN2GOBVO3XY6AUOVCL7Q562N42UC3O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 15, 2021 at 05:40:43PM +0800, Zhongwei Cai wrote:
> On Thu, 14 Jan 2021, Mikulas wrote:
> For Ext4-dax, the overhead of dax_iomap_rw is significant
> compared to the overhead of struct iov_iter. Although methods
> proposed by Mikulas can eliminate the overhead of iov_iter
> well, they can not be applied in Ext4-dax unless we implement an
> internal "read" method in Ext4-dax.
> 
> For Ext4-dax, there could be two approaches to optimizing:
> 1) implementing the internal "read" method without the complexity
> of iterators and dax_iomap_rw;

Please do not go an re-invent the wheel just for ext4. If there's a
problem in a shared path - ext2, FUSE and XFS all use dax_iomap_rw()
as well, so any improvements to that path benefit all DAX users, not
just ext4.

> 2) optimizing how dax_iomap_rw works.
> Since dax_iomap_rw requires ext4_iomap_begin, which further involves
> the iomap structure and others (e.g., journaling status locks in Ext4),
> we think implementing the internal "read" method would be easier.

Maybe it is, but it's also very selfish. The DAX iomap path was
written to be correct for all users, not inecessarily provide
optimal performance. There will be lots of things that could be done
to optimise it, so rather than creating a special snowflake in ext4
that makes DAX in ext4 much harder to maintain for non-ext4 DAX
developers, please work to improve the common DAX IO path and so
provide the same benefit to all the filesystems that use it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

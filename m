Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC752FCFA0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 21:24:12 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18A7A100EE8CF;
	Thu, 14 Nov 2019 12:25:39 -0800 (PST)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.246; helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
	by ml01.01.org (Postfix) with ESMTP id 90DFB100EE8CE
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 12:25:36 -0800 (PST)
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3D5E743E7D2;
	Fri, 15 Nov 2019 07:24:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1iVLer-0002xv-KL; Fri, 15 Nov 2019 07:24:01 +1100
Date: Fri, 15 Nov 2019 07:24:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write
 path).
Message-ID: <20191114202401.GB4614@dread.disaster.area>
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
 <e33532a2-a9e5-1578-bdd8-a83d4710a151@cn.fujitsu.com>
 <CAPcyv4ivOgMNdvWTtpXw2aaR0o7MEQZ=cDiy=_P9qhVb3QVWdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4ivOgMNdvWTtpXw2aaR0o7MEQZ=cDiy=_P9qhVb3QVWdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
	a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
	a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8 a=LDxVRJNMUMF_87RH2osA:9
	a=CjuIK1q_8ugA:10 a=baC4JDFNLZpnPwus_NF9:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: U27LQCR6Z3QRS2ZI5QC63QPFKIU3YYKK
X-Message-ID-Hash: U27LQCR6Z3QRS2ZI5QC63QPFKIU3YYKK
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U27LQCR6Z3QRS2ZI5QC63QPFKIU3YYKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 07, 2019 at 07:30:32PM -0800, Dan Williams wrote:
> On Thu, Nov 7, 2019 at 7:11 PM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
> >
> > Hi Darrick, Dave,
> >
> > Do you have any comment on this?
> 
> Christoph pointed out at ALPSS that this problem has significant
> overlap with the shared page-cache for reflink problem. So I think we
> need to solve that first and then circle back to dax reflink support.
> I'm starting to take a look at that.

I think the DAX side is somewhat simpler because it doesn't really
need to involve the page cache and we don't have to worry about
subtly breaking random filesystems. Hence I'd suggest we sort out a
solution for DAX first, then worry about page cache stuff. The
shared page cache for reflink feature is not a show stopper -
multiple references for DAX is a show stopper. Let's deal with the
DAX problem first.

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A43167D9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 14:21:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71476100EAAE6;
	Wed, 10 Feb 2021 05:21:44 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E5F7F100EAB7D
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 05:21:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C95C68B02; Wed, 10 Feb 2021 14:21:39 +0100 (CET)
Date: Wed, 10 Feb 2021 14:21:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 02/11] blk: Introduce ->corrupted_range() for block
 device
Message-ID: <20210210132139.GC30109@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-3-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208105530.3072869-3-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: RJ7XQOLP76SKYVCUHOG4H34SSDGQ6SE6
X-Message-ID-Hash: RJ7XQOLP76SKYVCUHOG4H34SSDGQ6SE6
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJ7XQOLP76SKYVCUHOG4H34SSDGQ6SE6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 08, 2021 at 06:55:21PM +0800, Shiyang Ruan wrote:
> In fsdax mode, the memory failure happens on block device.  So, it is
> needed to introduce an interface for block devices.  Each kind of block
> device can handle the memory failure in ther own ways.

As told before: DAX operations please do not add anything to the block
device.  We've been working very hard to decouple DAX from the block
device, and while we're not done regressing the split should not happen.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

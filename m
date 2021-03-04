Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215B32DD47
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Mar 2021 23:42:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8A79100ED4BC;
	Thu,  4 Mar 2021 14:42:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76C44100EF271
	for <linux-nvdimm@lists.01.org>; Thu,  4 Mar 2021 14:42:53 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF7D764FF4;
	Thu,  4 Mar 2021 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1614897773;
	bh=qnYCVH7kx24HUZZshVhHK698ZWbn+eQJdMYwdeGcWq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYsnshJoXNs+g8S9T7aTiyRoV0yR8Ehs3mX5Q6zzwfnNBAJYRW6kKqPw3gRtYTjMk
	 jyEFsMVzPFKMm3Xedx1PcOQ7h8IYUSN07FvNXZ6taEoSdNtbZbfzoFUARiVa0bVjgC
	 VSbUSwfKmshPg+4n/d3zrWObdOG05ZEHw74lZUa2sAxIs5JMcY1VrqGFhtT7/cXVOE
	 aAHmLHHQCDsF2bL252guTmnUemMWkbBTfvb5hX73TyyIyTbTNrHsFQeSIWDon7v693
	 lGyQfLIvsQTV6PzG0VCZnHkzkQXXuiG5O/zRiZhgetPvnOMXfdxsmp0WpeJzQyTQrv
	 NFFwjzKElG5iw==
Date: Thu, 4 Mar 2021 14:42:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 02/11] blk: Introduce ->corrupted_range() for block
 device
Message-ID: <20210304224250.GF3419940@magnolia>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-3-ruansy.fnst@cn.fujitsu.com>
 <20210210132139.GC30109@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210132139.GC30109@lst.de>
Message-ID-Hash: WNWEJAWSFC46NNQCD6CXI7WAI6YCGQP6
X-Message-ID-Hash: WNWEJAWSFC46NNQCD6CXI7WAI6YCGQP6
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WNWEJAWSFC46NNQCD6CXI7WAI6YCGQP6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 10, 2021 at 02:21:39PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 08, 2021 at 06:55:21PM +0800, Shiyang Ruan wrote:
> > In fsdax mode, the memory failure happens on block device.  So, it is
> > needed to introduce an interface for block devices.  Each kind of block
> > device can handle the memory failure in ther own ways.
> 
> As told before: DAX operations please do not add anything to the block
> device.  We've been working very hard to decouple DAX from the block
> device, and while we're not done regressing the split should not happen.

I agree with you (Christoph) that (strictly speaking) within the scope of
the DAX work this isn't needed; xfs should be able to consume the
->memory_failure events directly and DTRT.

My vision here, however, is to establish upcalls for /both/ types of
stroage.

Regular block devices can use ->corrupted_range to push error
notifications upwards through the block stack to a filesystem, and we
can finally do a teensy bit more with scsi sense data about media
errors, or thinp wanting to warn the filesystem that it's getting low on
space and maybe this would be an agreeable time to self-FITRIM, or raid
noticing that a mirror is inconsistent and can the fs do something to
resolve the dispute, etc.  Maybe we can use this mechanism to warn a
filesystem that someone did "echo 1 > /sys/block/sda/device/delete" and
we had better persist everything while we still can.

Memory devices will use ->memory_failure to tell us about ADR errors,
and I guess upcoming and past hotremove events.  For fsdax you'd
probably have to send the announcement and invalidate the current ptes
to force filesystem pagefaults and the like.

Either way, I think this piece is fine, but I would change the dax
side to send the ->memory_failure events directly to xfs.

A gap here is that xfs can attach to rt/log devices but we don't
currently plumb in enough information that get_active_super can find
the correct filesystem.

I dunno, maybe we should add this to the thread here[1]?

[1] https://lore.kernel.org/linux-xfs/CAPcyv4g3ZwbdLFx8bqMcNvXyrob8y6sBXXu=xPTmTY0VSk5HCw@mail.gmail.com/T/#m55a5c67153d0d10f3ff05a69d7e502914d97ac9d

--D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

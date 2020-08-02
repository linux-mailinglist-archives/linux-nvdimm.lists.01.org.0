Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF79239CF1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 01:01:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40CDD129765DC;
	Sun,  2 Aug 2020 16:01:56 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.97; helo=mail110.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail110.syd.optusnet.com.au (mail110.syd.optusnet.com.au [211.29.132.97])
	by ml01.01.org (Postfix) with ESMTP id 9EFD7129765DB
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 16:01:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
	by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 9F77B109820;
	Mon,  3 Aug 2020 09:01:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1k2MzE-0000Mk-Pv; Mon, 03 Aug 2020 09:01:48 +1000
Date: Mon, 3 Aug 2020 09:01:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [RFC 1/1] pmem: Add cond_resched() in bio_for_each_segment loop
 in pmem_make_request
Message-ID: <20200802230148.GA2114@dread.disaster.area>
References: <0d96e2481f292de2cda8828b03d5121004308759.1596011292.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d96e2481f292de2cda8828b03d5121004308759.1596011292.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
	a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
	a=qczKg5P-FDsFxSpMrEAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: DYKLH5NNFJEGKE3DAIGPGS742LDAGZ4P
X-Message-ID-Hash: DYKLH5NNFJEGKE3DAIGPGS742LDAGZ4P
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DYKLH5NNFJEGKE3DAIGPGS742LDAGZ4P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 29, 2020 at 02:15:18PM +0530, Ritesh Harjani wrote:
> For systems which do not have CONFIG_PREEMPT set and
> if there is a heavy multi-threaded load/store operation happening
> on pmem + sometimes along with device latencies, softlockup warnings like
> this could trigger. This was seen on Power where pagesize is 64K.
> 
> To avoid softlockup, this patch adds a cond_resched() in this path.
> 
> <...>
> watchdog: BUG: soft lockup - CPU#31 stuck for 22s!
> <...>
> CPU: 31 PID: 15627 <..> 5.3.18-20
> <...>
> NIP memcpy_power7+0x43c/0x7e0
> LR memcpy_flushcache+0x28/0xa0
> 
> Call Trace:
> memcpy_power7+0x274/0x7e0 (unreliable)
> memcpy_flushcache+0x28/0xa0
> write_pmem+0xa0/0x100 [nd_pmem]
> pmem_do_bvec+0x1f0/0x420 [nd_pmem]
> pmem_make_request+0x14c/0x370 [nd_pmem]
> generic_make_request+0x164/0x400
> submit_bio+0x134/0x2e0
> submit_bio_wait+0x70/0xc0
> blkdev_issue_zeroout+0xf4/0x2a0
> xfs_zero_extent+0x90/0xc0 [xfs]
> xfs_bmapi_convert_unwritten+0x198/0x230 [xfs]
> xfs_bmapi_write+0x284/0x630 [xfs]
> xfs_iomap_write_direct+0x1f0/0x3e0 [xfs]
> xfs_file_iomap_begin+0x344/0x690 [xfs]
> dax_iomap_pmd_fault+0x488/0xc10
> __xfs_filemap_fault+0x26c/0x2b0 [xfs]
> __handle_mm_fault+0x794/0x1af0
> handle_mm_fault+0x12c/0x220
> __do_page_fault+0x290/0xe40
> do_page_fault+0x38/0xc0
> handle_page_fault+0x10/0x30
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  drivers/nvdimm/pmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 2df6994acf83..fcf7af13897e 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -214,6 +214,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>  			bio->bi_status = rc;
>  			break;
>  		}
> +		cond_resched();

There are already cond_resched() calls between submitted bios in
blkdev_issue_zeroout() via both __blkdev_issue_zero_pages() and
__blkdev_issue_write_zeroes(), so I'm kinda wondering where the
problem is coming from here.

Just how big is the bio being issued here that it spins for 22s
trying to copy it?

And, really, if the system is that bound on cacheline bouncing that
it prevents memcpy() from making progress, I think we probably
should be issuing a soft lockup warning like this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62020FB94
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 20:19:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95B6F11427DB3;
	Tue, 30 Jun 2020 11:19:35 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 455F11141F7B2
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 11:19:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C5A868B05; Tue, 30 Jun 2020 20:19:29 +0200 (CEST)
Date: Tue, 30 Jun 2020 20:19:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
Message-ID: <20200630181928.GA7853@lst.de>
References: <20200629193947.2705954-1-hch@lst.de> <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk> <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: L7AONCJDTITJZIPA3CRERRCLA4PMOLX6
X-Message-ID-Hash: L7AONCJDTITJZIPA3CRERRCLA4PMOLX6
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L7AONCJDTITJZIPA3CRERRCLA4PMOLX6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2020 at 09:43:31AM -0600, Jens Axboe wrote:
> On 6/30/20 7:57 AM, Jens Axboe wrote:
> > On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> >> Hi Jens,
> >>
> >> this series moves the make_request_fn method into block_device_operations
> >> with the much more descriptive ->submit_bio name.  It then also gives
> >> generic_make_request a more descriptive name, and further optimize the
> >> path to issue to blk-mq, removing the need for the direct_make_request
> >> bypass.
> > 
> > Looks good to me, and it's a nice cleanup as well. Applied.
> 
> Dropped, insta-crashes with dm:

Hmm.  Can you send me what is at "submit_bio_noacct+0x1f6" from gdb?
Or your .config?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

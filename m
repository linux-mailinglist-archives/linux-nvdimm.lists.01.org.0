Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899901E37D8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 07:23:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3D7C1225F25E;
	Tue, 26 May 2020 22:19:38 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A35891224DB6A
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 22:19:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9937168B02; Wed, 27 May 2020 07:23:41 +0200 (CEST)
Date: Wed, 27 May 2020 07:23:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH 01/16] block: add disk/bio-based accounting helpers
Message-ID: <20200527052341.GA17530@lst.de>
References: <20200525113014.345997-1-hch@lst.de> <20200525113014.345997-2-hch@lst.de> <fafb94a9-cdce-5ea0-e73f-9463766a9f19@yandex-team.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fafb94a9-cdce-5ea0-e73f-9463766a9f19@yandex-team.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: LYQXU7AZGY24WYPO6WRETEERYB6Y7OVZ
X-Message-ID-Hash: LYQXU7AZGY24WYPO6WRETEERYB6Y7OVZ
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LYQXU7AZGY24WYPO6WRETEERYB6Y7OVZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 25, 2020 at 03:28:07PM +0300, Konstantin Khlebnikov wrote:
> I think it would be better to leave this jiffies legacy nonsense in
> callers and pass here request duration in nanoseconds.

jiffies is what the existing interfaces uses.  But now that they come
from the start helper fixing this will become easier.  I'll do that
as a follow on, as I'd rather not bloat this series even more.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

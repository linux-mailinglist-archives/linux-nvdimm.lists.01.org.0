Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC533089E
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Mar 2021 08:09:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2855D100EC1EE;
	Sun,  7 Mar 2021 23:09:23 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6A44100EC1CC;
	Sun,  7 Mar 2021 23:09:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9B6A68B02; Mon,  8 Mar 2021 08:09:15 +0100 (CET)
Date: Mon, 8 Mar 2021 08:09:15 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
Message-ID: <20210308070915.GA32695@lst.de>
References: <20210305055900.GC31481@xsang-OptiPlex-9020> <20210305074204.GA17414@lst.de> <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: KSUWHPRP5EARRB35MRMFJB6KTV3QKLST
X-Message-ID-Hash: KSUWHPRP5EARRB35MRMFJB6KTV3QKLST
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "hch@lst.de" <hch@lst.de>, lkp <lkp@intel.com>, "hare@suse.de" <hare@suse.de>, "olkuroch@cisco.com" <olkuroch@cisco.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "lkp@lists.01.org" <lkp@lists.01.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "Sang, Oliver" <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KSUWHPRP5EARRB35MRMFJB6KTV3QKLST/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Mar 06, 2021 at 08:33:04PM +0000, Williams, Dan J wrote:
> Yes, it looks like my unit test checks for exactly the behavior you
> changed. It was convenient to test that the device could be switched
> back to rw via BLKROSET, but I don't require that. The new behaviour of
> letting the disk->ro take precedence makes more sense to me, so I'll
> update the test for the new behaviour.
> 
> I.e. I don't think regressing a unit test counts as a userspace
> regression.

Ok, thanks for the confirmation.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

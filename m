Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D45EC28FEB7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 08:59:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 060DD1605FAE3;
	Thu, 15 Oct 2020 23:59:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+3f298eef0c732a4c5343+6263+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC8F51605FAE2
	for <linux-nvdimm@lists.01.org>; Thu, 15 Oct 2020 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hIWsgXRwwrdjTKWdcTDNxo1KkS1hr9+bm71pdZvcsgM=; b=VUmAniLLQhHQnbgFkmGnuIOW+E
	sm9Ply16VmMLDqM30lkMQl4EuwGjoati5bjov/lmVdITZYbbgE5TUfojIcEP7hFfAcEH4jrGYn+Wr
	3gShscQ8Wpyxb4U9kidvJ8q/YnN0Qz0sYhMBIzbhWH5+CmbPVML2yHOCeT0aE+UN0fOvskT4JaSv5
	AiBRp8BJi+wmBusF8CfOOgh4w1mrHhIH5xs5s3Ts7MU1w2K03c7FHEiScHZOWup+8xOlrTVSNKcGI
	f4sOV6AlP0ycXjSMZfYbGpIAZSFhM00DoRSfJVeuZfZ/aAUQugN+xbvj/5463rhYdYE/EHouZUR/D
	7ZDoXuLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTJhd-0002om-Js; Fri, 16 Oct 2020 06:59:01 +0000
Date: Fri, 16 Oct 2020 07:59:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] Clarify COPYING
Message-ID: <20201016065901.GA10448@infradead.org>
References: <160281074218.3146890.3209259735282870612.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160281074218.3146890.3209259735282870612.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: KTKDM5HRTLRWEHFPRORLCAQG43R2KDXA
X-Message-ID-Hash: KTKDM5HRTLRWEHFPRORLCAQG43R2KDXA
X-MailFrom: BATV+3f298eef0c732a4c5343+6263+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KTKDM5HRTLRWEHFPRORLCAQG43R2KDXA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2020 at 06:12:22PM -0700, Dan Williams wrote:
> The tools and the libraries this project produces are licensed under the
> GPLv2 and LGPLv2.1 licenses respectively. Add a COPYING file that
> highlights this arrangement and fixup files in */lib that mistakenly had
> a GPLv2 header applied.

Maybe it is time to move to formal SPDX annotations and the LICENSES/
infrastructure from the kernel?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

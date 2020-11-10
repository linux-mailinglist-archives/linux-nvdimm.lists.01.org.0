Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F762ADE41
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 19:26:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78C57167E6707;
	Tue, 10 Nov 2020 10:26:24 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A6238167E6707
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 10:26:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBEC367373; Tue, 10 Nov 2020 19:26:18 +0100 (CET)
Date: Tue, 10 Nov 2020 19:26:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: simplify follow_pte a bit
Message-ID: <20201110182618.GA29611@lst.de>
References: <20201029101432.47011-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 44AFMFVBMRE3EREUKDPF2UPDXL4WJSUB
X-Message-ID-Hash: 44AFMFVBMRE3EREUKDPF2UPDXL4WJSUB
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/44AFMFVBMRE3EREUKDPF2UPDXL4WJSUB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2020 at 11:14:30AM +0100, Christoph Hellwig wrote:
> Hi Andrew,
> 
> this small series drops the not needed follow_pte_pmd exports, and
> simplifies the follow_pte family of functions a bit.

any comments?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

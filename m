Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474962AEAF3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 09:18:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5487C1685A09C;
	Wed, 11 Nov 2020 00:18:08 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 791DF1685A08E
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 00:18:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 966BD6736F; Wed, 11 Nov 2020 09:18:00 +0100 (CET)
Date: Wed, 11 Nov 2020 09:18:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Message-ID: <20201111081800.GA23492@lst.de>
References: <20201029101432.47011-3-hch@lst.de> <20201111022122.1039505-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111022122.1039505-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: V7MXOEPJE4KN7434WZFJWOLE4EZWCRZW
X-Message-ID-Hash: V7MXOEPJE4KN7434WZFJWOLE4EZWCRZW
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: hch@lst.de, akpm@linux-foundation.org, daniel@ffwll.ch, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, clang-built-linux@googlegroups.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V7MXOEPJE4KN7434WZFJWOLE4EZWCRZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 10, 2020 at 06:21:22PM -0800, Nick Desaulniers wrote:
> Sorry, I think this patch may be causing a regression for us for s390?
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/432129279#L768
> 
> (via https://lore.kernel.org/linux-mm/20201029101432.47011-3-hch@lst.de)

Hmm, the call to follow_pte_pmd in the s390 code does not actually exist
in my tree.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

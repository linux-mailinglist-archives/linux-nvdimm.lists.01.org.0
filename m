Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823972FF6FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 22:18:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D336A100F225A;
	Thu, 21 Jan 2021 13:18:28 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 035C9100F224B
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z9XQotONVTpasWnTASx1CpS6wHolZ/YHd3IpBnAnbew=; b=QAjV0AXyq8nOc6B1325pwZpqf7
	aNR1ahgiWmXt2nWbG7fu2CiXy2UgQkm0i3zz6Xh2Mo6mXVOvCB/rdtMYOL5MfcqyoXOZVqyisJ/Tn
	Cp4/keveTLDcEVFEzYztIPexMSS9h4Klc/IrcA7mEjMwcEPlZz6TrH+26g/NOEeA/j1dMWxlpL89b
	hQlv0GuOQ+5Ug1JT60BIIRyBXmC2SrhMgdmnYu6XYvtN0oIJybzVgZ2MVLoFZOhG5vKHdtu9686dv
	QKON24iMZdcZkZIGlGmBupC0tYz0cjbpr8Fj/Mr+5nMMVdy6pltZsaySBNDDmDyoCn5IOJRWJcf/K
	cPsdB+WA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2hLJ-00HXfF-Lc; Thu, 21 Jan 2021 21:18:15 +0000
Date: Thu, 21 Jan 2021 21:18:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 1/4] mm: Introduce and use mapping_empty
Message-ID: <20210121211813.GD4127393@casper.infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-2-willy@infradead.org>
 <YAnnN1pnZAPse5X+@cmpxchg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YAnnN1pnZAPse5X+@cmpxchg.org>
Message-ID-Hash: HHQ5IB3EOMP666B42H2J6VHCT2A5E7B5
X-Message-ID-Hash: HHQ5IB3EOMP666B42H2J6VHCT2A5E7B5
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HHQ5IB3EOMP666B42H2J6VHCT2A5E7B5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 21, 2021 at 03:42:31PM -0500, Johannes Weiner wrote:
> On Mon, Oct 26, 2020 at 03:18:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > Instead of checking the two counters (nrpages and nrexceptional), we
> > can just check whether i_pages is empty.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Heh, I was looking for the fs/inode.c hunk here, because I remember
> those BUG_ONs in the inode free path. Found it in the last patch - I
> guess they escaped grep but the compiler let you know? :-)

Heh, I forget now!  I think I did it that way on purpose, but now I
forget what that purpose was!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

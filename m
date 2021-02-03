Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC630E09A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 18:12:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DB51100EAB7E;
	Wed,  3 Feb 2021 09:12:40 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+f06b10cfe9d4f1643769+6373+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4303F100EAB7D
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TOHrz9rJRmT1MZjmRcdSp7+GuY9P+OtZtUJvbJgCulo=; b=QlTPVhm61sGQuTcf3P0iNWT8ED
	Bi2gkvv6DDeJQwV2HZj+zq53XZjee6QmF+jgW/E4anVOGeBwLE0OhGlE/INHWoFljCKhZx4kLuKFi
	vBpPlOiPaIYrUSdcPkchYs5y8EocLYDkgBQi5zK2utgiNqo1gFusaNMlddnGX4lCKct1oIiIfQN0x
	4FZFsAcm9c0hrwdS+WY55lmm+xjte1BQs5jszrftBaCW8zuTfPkpbQPL1wxnyHoTRZuCOgTwdKSQC
	PmSjukh2Zy50HgX10fdq7MOFixROv7xKlGJkbVoqgE9rz6+csO3TxasqOuAu242s0FMgsIu5s/vvZ
	pnxR5IZg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l7LhT-00HEZu-Qm; Wed, 03 Feb 2021 17:12:20 +0000
Date: Wed, 3 Feb 2021 17:12:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210203171219.GA4104698@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
 <20210202180441.GC3708021@infradead.org>
 <20210202183151.7kwruvip7nshqsc4@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202183151.7kwruvip7nshqsc4@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: SSPBPRJ673JOTQEGX2YZWEZFVX375FC7
X-Message-ID-Hash: SSPBPRJ673JOTQEGX2YZWEZFVX375FC7
X-MailFrom: BATV+f06b10cfe9d4f1643769+6373+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SSPBPRJ673JOTQEGX2YZWEZFVX375FC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 02, 2021 at 10:31:51AM -0800, Ben Widawsky wrote:
> > > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > > +			rc = 0;
> > > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > > +			if (!cxlm)
> > > +				rc = -ENODEV;
> > > +			break;
> > 
> > And given that we're going to grow more types eventually, why not start
> > out with a switch here?  Also why return the structure when nothing
> > uses it?
> 
>  We've (Intel) already started working on the libnvdimm integration which does
>  change this around a bit. In order to go with what's best tested though, I've
>  chosen to use this as is for merge. Many different people not just in Intel
>  have tested these codepaths. The resulting code moves the check on register
>  type out of this function entirely.
> 
>  If you'd like me to make it a switch, I can, but it's going to be extracted
>  later anyway.

This was just a suggestion.  No hard feelings, it's just that the code
looks a little odd to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

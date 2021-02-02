Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6B30C993
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:24:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3287100EA2C3;
	Tue,  2 Feb 2021 10:24:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B1EB2100EA2C2
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:24:22 -0800 (PST)
IronPort-SDR: PN+KdxI9mbHINLSpFbuMsdsRBFuuJaybJVPWskeol6hTBP8IKkL7VWbKHE/JUwxEaAoePunDbO
 ZKFt7TSx5wuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168011206"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="168011206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:24:21 -0800
IronPort-SDR: rlVOr+F59Dm93VedZPbkRLa3d7C9TiDXpbtmq3k0WVsbXYLMphar3MgWZ1t5VZzywr2UW91/TO
 FbLUWuM8GdVQ==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="391610338"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:24:20 -0800
Date: Tue, 2 Feb 2021 10:24:18 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210202182418.3wyxnm6rqeoeclu2@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202181016.GD3708021@infradead.org>
Message-ID-Hash: YHMUS7WRS7NQFMWD6J4GHHTRPO6ONK3X
X-Message-ID-Hash: YHMUS7WRS7NQFMWD6J4GHHTRPO6ONK3X
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YHMUS7WRS7NQFMWD6J4GHHTRPO6ONK3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-02 18:10:16, Christoph Hellwig wrote:
> On Fri, Jan 29, 2021 at 04:24:27PM -0800, Ben Widawsky wrote:
> >  #ifndef __CXL_H__
> >  #define __CXL_H__
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/io.h>
> > +
> > +#define CXL_SET_FIELD(value, field)                                            \
> > +	({                                                                     \
> > +		WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> > +		FIELD_PREP(field##_MASK, value);                               \
> > +	})
> > +
> > +#define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
> 
> This looks like some massive obsfucation.  What is the intent
> here?
> 

I will drop these. I don't recall why I did this to be honest.

> > +	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> > +	struct {
> > +		void __iomem *regs;
> > +	} status;
> > +
> > +	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
> > +	struct {
> > +		void __iomem *regs;
> > +		size_t payload_size;
> > +	} mbox;
> > +
> > +	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> > +	struct {
> > +		void __iomem *regs;
> > +	} mem;
> 
> This style looks massively obsfucated.  For one the comments look like
> absolute gibberish, but also what is the point of all these anonymous
> structures?

They're not anonymous, and their names are for the below register functions. The
comments are connected spec reference 'Cap XXXXh' to definitions in cxl.h. I can
articulate that if it helps.

> 
> > +#define cxl_reg(type)                                                          \
> > +	static inline void cxl_write_##type##_reg32(struct cxl_mem *cxlm,      \
> > +						    u32 reg, u32 value)        \
> > +	{                                                                      \
> > +		void __iomem *reg_addr = cxlm->type.regs;                      \
> > +		writel(value, reg_addr + reg);                                 \
> > +	}                                                                      \
> > +	static inline void cxl_write_##type##_reg64(struct cxl_mem *cxlm,      \
> > +						    u32 reg, u64 value)        \
> > +	{                                                                      \
> > +		void __iomem *reg_addr = cxlm->type.regs;                      \
> > +		writeq(value, reg_addr + reg);                                 \
> > +	}                                                                      \
> 
> What is the value add of all this obsfucation over the trivial
> calls to the write*/read* functions, possible with a locally
> declarate "void __iomem *" variable in the callers like in all
> normall drivers?  Except for making the life of the poor soul trying
> to debug this code some time in the future really hard, of course.
> 

The register space for CXL devices is a bit weird since it's all subdivided
under 1 BAR for now. To clearly distinguish over the different subregions, these
helpers exist. It's really easy to mess this up as the developer and I actually
would disagree that it makes debugging quite a bit easier. It also gets more
convoluted when you add the other 2 BARs which also each have their own
subregions.

For example. if my mailbox function does:
cxl_read_status_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);

instead of:
cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);

It's easier to spot than:
readl(cxlm->regs + cxlm->status_offset + CXLDEV_MB_CAPS_OFFSET)


> > +	/* 8.2.8.4.3 */
> 
> ????
> 

I had been trying to be consistent with 'CXL2.0 - ' in front of all spec
reference. I obviously missed this one.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

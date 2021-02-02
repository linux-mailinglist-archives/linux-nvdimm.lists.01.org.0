Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B464830C918
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:10:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0EE11100EAB5F;
	Tue,  2 Feb 2021 10:10:27 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9534F100F227D
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AVVe2K/NEHRP81u+T9FBKHD+3y3Q3gc7pWp75m9zru0=; b=OI0GI4y9LgXK1Ujzm42hs9roVB
	96C9b2nQjVweVjdyYGWGMCv8eLoeT5/Ec/lG7zFc709TJV29GNpd8FdDuQO8XOlDSkH8IzLqCgoys
	QgcVvN7gDxNP2Xo9J0DAcAwNufDoWPtamooMnP4JMUUlNFHa/R8e0fhtjJDhbOOohKm0FLGyhdOsg
	V8CU3Xs10D8+YjfQh1E1Y3OWn4nH4KU7/isg3r2zDdsaJ2vrEXg85M+pdDTORRf5RPxTGY4oDyISE
	xFC7v0ckzMQ/+ddiF4d4ErqtBh0p9csQmsSoOkZlh9MpKMJWaroKNeJRjm9ah2JB7uQGKyJ32Itlj
	0VFvDMOA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l7080-00FZdy-GK; Tue, 02 Feb 2021 18:10:16 +0000
Date: Tue, 2 Feb 2021 18:10:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210202181016.GD3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-4-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: A5JNHHM3C44YCGWFCBIHYQSMPHTKRPZD
X-Message-ID-Hash: A5JNHHM3C44YCGWFCBIHYQSMPHTKRPZD
X-MailFrom: BATV+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A5JNHHM3C44YCGWFCBIHYQSMPHTKRPZD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 29, 2021 at 04:24:27PM -0800, Ben Widawsky wrote:
>  #ifndef __CXL_H__
>  #define __CXL_H__
>  
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +
> +#define CXL_SET_FIELD(value, field)                                            \
> +	({                                                                     \
> +		WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> +		FIELD_PREP(field##_MASK, value);                               \
> +	})
> +
> +#define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)

This looks like some massive obsfucation.  What is the intent
here?

> +	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
> +	struct {
> +		void __iomem *regs;
> +	} status;
> +
> +	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
> +	struct {
> +		void __iomem *regs;
> +		size_t payload_size;
> +	} mbox;
> +
> +	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
> +	struct {
> +		void __iomem *regs;
> +	} mem;

This style looks massively obsfucated.  For one the comments look like
absolute gibberish, but also what is the point of all these anonymous
structures?

> +#define cxl_reg(type)                                                          \
> +	static inline void cxl_write_##type##_reg32(struct cxl_mem *cxlm,      \
> +						    u32 reg, u32 value)        \
> +	{                                                                      \
> +		void __iomem *reg_addr = cxlm->type.regs;                      \
> +		writel(value, reg_addr + reg);                                 \
> +	}                                                                      \
> +	static inline void cxl_write_##type##_reg64(struct cxl_mem *cxlm,      \
> +						    u32 reg, u64 value)        \
> +	{                                                                      \
> +		void __iomem *reg_addr = cxlm->type.regs;                      \
> +		writeq(value, reg_addr + reg);                                 \
> +	}                                                                      \

What is the value add of all this obsfucation over the trivial
calls to the write*/read* functions, possible with a locally
declarate "void __iomem *" variable in the callers like in all
normall drivers?  Except for making the life of the poor soul trying
to debug this code some time in the future really hard, of course.

> +	/* 8.2.8.4.3 */

????
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

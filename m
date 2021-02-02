Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A330C8C0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:00:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 081F6100EAB44;
	Tue,  2 Feb 2021 10:00:40 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C7DC100EAB43
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=34JzfiaD98noVdYI8wGijdt5CbMl5vmcMb4nVnbQldQ=; b=vO5z5tvjc31myEUZzGdE71R7Br
	Y/Nzfs8zJY3uV6y00Mu/zEVEuwDCnaWBP6eQDvXu9TgZYzNa27lpaKOBRtu9RgwBdeWVMcavrCjjV
	toAyiyWm0vxFwXBjDYsOgWNyGOG6Xbs5JEA6G7YGX6TCA2TWe1ShBYZVhTZYhKgV7rULNHXjAHAOd
	ki+AU+lsEHlKowzeBwXTkqImxPd90/51+ccfIDW0dVXiCeZmURqv5kO913twHNJCIT6QnmEhq8Ppo
	iWdmd1PWCPDoACyTXy2Hoz+wGH9jdKYph4lEObpw24XkEk+eQUJQYJBEr6SVxYnqmPZoh2a8zxgcF
	my47UCuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l6zyW-00FYwW-Ne; Tue, 02 Feb 2021 18:00:28 +0000
Date: Tue, 2 Feb 2021 18:00:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210202180028.GB3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: O4KJCTQAEDW7YI7FQATWSHYTFUCQCWNK
X-Message-ID-Hash: O4KJCTQAEDW7YI7FQATWSHYTFUCQCWNK
X-MailFrom: BATV+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O4KJCTQAEDW7YI7FQATWSHYTFUCQCWNK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 vendor, id;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
> +				     &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}

There should be a patch with a generic version of this find a vendor
specific capability helper on linux-pci.

> +#define PCI_CLASS_MEMORY_CXL	0x050210

I think this should go into linux/pci_ids.h.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

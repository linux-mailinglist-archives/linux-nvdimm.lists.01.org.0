Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B749D3098F3
	for <lists+linux-nvdimm@lfdr.de>; Sun, 31 Jan 2021 00:51:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 641BF100EBBB1;
	Sat, 30 Jan 2021 15:51:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC35C100EBBB1
	for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id my11so7948765pjb.1
        for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=KakMFpmDEnIJAfIkwgFElM2OuCuzZHKBG8btmmU1ofJKTS7yI0zo08pqWacZX46IFI
         8fHWvBqPYFSupOKNtk43JJoG/x0xDILY1ny7YHyzKcQI/6v2eq+1+2sACm7zDjm9calq
         rah5jhD/eOqyjJnmkmMSpcrIa4Z4fOuHgRuowyV0XL+mnCr1BmkOz7ivyntQVH2EneOx
         iLG09O3UCbp8bUAmiA7k7GMVemtVjmTBSyL1T7IkifZ+NF1tJQKusqD8Mpl9Ru7GJRTO
         kL4WwHN7MMbiJL5NcAZkYBPC8h4+0dg3MVcVYtNOrdGtaqM3E3ELgyet8WY0yHGgx+NL
         TDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=tMLgi0wWBvttJaH0XPty8IsgLeNSLuW34pqBSmklac63RoS+Y1iQE/iOqoctoSKTwv
         jGvzIZB80oUTBIQehArpWp1yXkmttMzTMiVOQrowcw1s4VtrS2Fo8X8bwM1jZ8JJ+tZl
         Y15i1c8+dJOHtTq7REWTo3oLwJICSz1E8aisEC4F9fICYXBZE3gsgTiPypHGkvlBkCWl
         4HdZ41NXxXh/eR5umAmQGxenX9m+/bEy7gz2umAXW9iS1AizFsFE7wAOQIPp470fOLqn
         XXUO7xRvP3DL8OYyD662dY7MzAGb9tGxbDohshaF+Kt6/GBGu8t8asL2HpyLM0ElzYxU
         qSqg==
X-Gm-Message-State: AOAM531vKho9ysNzOE1j01MaCJuCJOJRqWzEW209514DmB26Vf6/5evF
	994cQJly+sH2nBGxg3AEtE9Z/w==
X-Google-Smtp-Source: ABdhPJyWfU3F6QFSqgDGRamotw78d6vqTVIqlXrDVhMybwvQ7IKMWFaK63q32G3vVTVfyW5mjbPKKg==
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id y16-20020a1709029b90b02900e006c0df4fmr11725622plp.60.1612050711168;
        Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b62sm13308050pfg.58.2021.01.30.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:50 -0800 (PST)
Date: Sat, 30 Jan 2021 15:51:49 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210130002438.1872527-4-ben.widawsky@intel.com>
Message-ID: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: BGOIHBEI4RDLD7THJSIJQ4TWTQ2L2AEQ
X-Message-ID-Hash: BGOIHBEI4RDLD7THJSIJQ4TWTQ2L2AEQ
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGOIHBEI4RDLD7THJSIJQ4TWTQ2L2AEQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> +{
> +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> +
> +	cxlm->mbox.payload_size =
> +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> +
> +	/* 8.2.8.4.3 */
> +	if (cxlm->mbox.payload_size < 256) {
> +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> +			cxlm->mbox.payload_size);
> +		return -ENXIO;
> +	}

Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
return ENXIO if true?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
